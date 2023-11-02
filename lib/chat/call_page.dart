import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emg/models/channel_model.dart';
import 'package:emg/utils/const.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class CallPage extends StatefulWidget {
  const CallPage({super.key, required this.channel, required this.token});

  final ChannelModel channel;
  final String token;

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  late RtcEngine _engine;
  bool isJoined = false;
  int? remoteUid;
  bool isLowAudio = true;

  bool isVideo = true;
  bool isMic = true;

  @override
  void initState() {
    super.initState();

    _initEngine();
  }

  @override
  void dispose() {
    _destroyEngine();

    var batch = FirebaseFirestore.instance.batch();
    batch.set(
        FirebaseFirestore.instance.collection("calls").doc(widget.channel.id),
        {"status": "finished"},
        SetOptions(merge: true));

    batch.commit().then((value) {
      Navigator.of(context).pop();
    }, onError: (e) {
      print(e);
    });

    super.dispose();
  }

  Future<void> _initEngine() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Permission.microphone.request();
      await Permission.camera.request();
    }

    // _engine = await RtcEngine.createWithContext(RtcEngineContext(kAgoraAppID));
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: kAgoraAppID,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _addListener();

    // enable video module and set up video encoding configs
    // await _engine.enableVideo();

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();

    // make this room live broadcasting room
    await _engine
        .setChannelProfile(ChannelProfileType.channelProfileLiveBroadcasting);
    _updateClientRole(ClientRoleType.clientRoleBroadcaster);

    // // make this room live broadcasting room
    // await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    // _updateClientRole(ClientRole.Broadcaster);

    //Set audio route to speaker
    // await _engine.setDefaultAudioRoutetoSpeakerphone(true);

    // await _engine.joinChannel(
    //     widget.token, widget.channel.id, null, 0 //Globals.currentUser!.id,
    //     );

    ChannelMediaOptions option = const ChannelMediaOptions();
    // int id = 1000 +
    //     widget.channel.participants
    //         .indexWhere((e) => e == Globals.currentUser!.uid);
    await _engine.joinChannel(
      token: widget.token,
      channelId: widget.channel.id,
      uid: 0,
      options: option,
    );
  }

  _addListener() {
    // _engine.setEventHandler(RtcEngineEventHandler(warning: (warningCode) {
    //   log('Warning $warningCode');
    // }, error: (errorCode) {
    //   log('error $errorCode');
    // }, joinChannelSuccess: (channel, uid, elapsed) {
    //   log('joinChannelSuccess $channel $uid $elapsed');
    //   setState(() {
    //     isJoined = true;
    //   });
    // }, userJoined: (uid, elapsed) {
    //   log('userJoined $uid $elapsed');
    //   setState(() {
    //     remoteUid = uid;
    //   });
    // }, userOffline: (uid, reason) {
    //   log('userOffline $uid $reason');
    //   setState(() {
    //     remoteUid = null;
    //   });
    // }));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            isJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            remoteUid = -1;
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );
  }

  // _updateClientRole(ClientRole role) async {
  //   if (role == ClientRole.Broadcaster) {
  //     await _engine.setVideoEncoderConfiguration(VideoEncoderConfiguration(
  //         dimensions: VideoDimensions(width: 640, height: 360),
  //         frameRate: VideoFrameRate.Fps30,
  //         orientationMode: VideoOutputOrientationMode.Adaptative));
  //     // enable camera/mic, this will bring up permission dialog for first time
  //     await _engine.enableLocalAudio(true);
  //     await _engine.enableLocalVideo(true);
  //     await _engine.setClientRole(role);
  //   } else {
  //     // You have to provide client role options if set to audience
  //     ClientRoleOptions option = ClientRoleOptions(
  //         audienceLatencyLevel: isLowAudio
  //             ? AudienceLatencyLevelType.LowLatency
  //             : AudienceLatencyLevelType.UltraLowLatency);
  //     await _engine.setClientRole(role, option);
  //   }
  // }

  _updateClientRole(ClientRoleType role) async {
    if (role == ClientRoleType.clientRoleBroadcaster) {
      await _engine.setVideoEncoderConfiguration(
          const VideoEncoderConfiguration(
              dimensions: VideoDimensions(width: 640, height: 360),
              frameRate: 30,
              orientationMode: OrientationMode.orientationModeAdaptive));
      // enable camera/mic, this will bring up permission dialog for first time
      await _engine.enableLocalAudio(true);
      await _engine.enableLocalVideo(true);
      await _engine.setClientRole(role: role);
    } else {
      // You have to provide client role options if set to audience
      ClientRoleOptions option = ClientRoleOptions(
          audienceLatencyLevel: isLowAudio
              ? AudienceLatencyLevelType.audienceLatencyLevelLowLatency
              : AudienceLatencyLevelType.audienceLatencyLevelUltraLowLatency);
      await _engine.setClientRole(role: role, options: option);
    }
  }

  Future<void> _destroyEngine() async {
    await _engine.leaveChannel();
    await _engine.release();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: remoteUid != null
                ?
                // RtcRemoteView.SurfaceView(
                //     uid: remoteUid!,
                //     channelId: widget.channel.id,
                //   )
                AgoraVideoView(
                    controller: VideoViewController.remote(
                    rtcEngine: _engine,
                    canvas: VideoCanvas(uid: remoteUid!),
                    connection: RtcConnection(channelId: widget.channel.id),
                  ))
                : Container(),
          ),
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              margin: const EdgeInsets.only(top: 36, left: 16),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.black.withOpacity(0.2)),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          if (isJoined) _renderLocalVideo(),
          if (isJoined) _renderToolBar(),
        ],
      ),
    );
  }

  Widget _renderLocalVideo() {
    return Align(
      alignment: Alignment.topRight,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 36, right: 16, bottom: 16),
            width: MediaQuery.of(context).size.width * 0.24,
            height: MediaQuery.of(context).size.width * 0.32,
            child: AgoraVideoView(
              controller: VideoViewController(
                rtcEngine: _engine,
                canvas: const VideoCanvas(uid: 0),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _engine.switchCamera();
            },
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.black.withOpacity(0.6)),
              child: const Icon(
                Icons.cameraswitch,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderToolBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 48),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.black.withOpacity(0.4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  isVideo = !isVideo;
                  _engine.muteLocalVideoStream(isVideo);
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.2)),
                child: Icon(
                  isVideo ? Icons.videocam : Icons.videocam_off,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 16),
            InkWell(
              onTap: () {
                //Finish calling
                Navigator.of(context).pop();
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.red),
                child: const Icon(
                  Icons.call_end,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 16),
            InkWell(
              onTap: () {
                setState(() {
                  isMic = !isMic;
                  _engine.muteLocalAudioStream(isMic);
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.2)),
                child: Icon(
                  isMic ? Icons.mic : Icons.mic_off,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
