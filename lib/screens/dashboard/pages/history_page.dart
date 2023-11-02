import 'package:emg/utils/colors.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: ghostWhite,
              height: size.height * 0.4,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.2,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: colorSnow,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      Icons.person,
                      color: colorWhite,
                      size: size.height * 0.1,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    "John Bello",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: frenchGray, fontSize: 20),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  const Text(
                    "EMERGENCY HISTORY",
                    style: TextStyle(
                        fontSize: 20, color: onyx, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return const Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle_outlined,
                                  color: offRedButton,
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Health Care",
                                      style: TextStyle(
                                          color: colorBlack,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "7.00: AM",
                                      style: TextStyle(
                                        color: colorGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              "23 December 2023",
                              style: TextStyle(color: colorGrey, fontSize: 15),
                            )
                          ],
                        ),
                        Divider(
                          color: ghostWhite,
                        ),
                      ],
                    ),
                  );
                  // return const ListTile(
                  //     leading: Icon(
                  //       Icons.circle_outlined,
                  //       color: offRedButton,
                  //     ),
                  //     trailing: Text(
                  //       "23 December 2023",
                  //       style: TextStyle(color: colorGrey, fontSize: 15),
                  //     ),
                  //     title: Text(
                  //       "Health Care",
                  //       style: TextStyle(
                  //           color: colorBlack, fontWeight: FontWeight.bold),
                  //     ),
                  //     subtitle: Text(
                  //       "7.00: AM",
                  //       style: TextStyle(
                  //         color: colorGrey,
                  //       ),
                  //     ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
