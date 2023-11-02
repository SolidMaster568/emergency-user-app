import 'package:emg/models/admin_model.dart';
import 'package:emg/models/category_model.dart';
import 'package:emg/utils/colors.dart';
import 'package:emg/utils/utils.dart';
import 'package:emg/view/widgets/custom_card_widget.dart';
import 'package:flutter/material.dart';

typedef EmrCallback = void Function(AdminModel, String);

class EmergencyHelpDialog extends StatefulWidget {
  const EmergencyHelpDialog({super.key, required this.callback});

  final EmrCallback callback;

  @override
  State<EmergencyHelpDialog> createState() => _EmergencyHelpDialogState();
}

class _EmergencyHelpDialogState extends State<EmergencyHelpDialog> {
  int? selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Select Category to proceed"),
        const SizedBox(
          height: 12,
        ),
        Expanded(
          // height: MediaQuery.of(context).size.height * 0.6,
          child: FutureBuilder<List<CategoryModel>>(
              future: Util.gtCategories(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 25,
                      crossAxisSpacing: 25,
                    ),
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      CategoryModel item = snapshot.data![index];

                      return CustomCardWidget(
                        onTap: () async {
                          setState(() => selected = index);

                          List<AdminModel> adminList =
                              await Util.gtEmrsForCategory(item.id);
                          if (adminList.isEmpty) {
                            showSnakBar("Emr is not registered yet", context);
                            return;
                          }

                          AdminModel admin = adminList.first;
                          widget.callback(admin, item.name);
                        },
                        iconData: item.getPhotoUrl(),
                        label: item.name,
                        iconColor: persianRed,
                        isSelected: index == selected,
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Container();
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ],
    );
  }
}
