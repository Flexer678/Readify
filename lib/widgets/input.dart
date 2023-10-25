import "package:flutter/material.dart";
import "package:readify/utils/colors.dart";

class SearchInput extends StatelessWidget {
  SearchInput(
      {super.key,
      required this.controller,
      required this.text,
      required this.type,
      required this.run});

  TextEditingController controller;
  String text;
  TextInputType type;
  Function run;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.green, borderRadius: BorderRadius.circular(30)),
      margin: EdgeInsets.all(10),
      width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                  keyboardType: type,
                  controller: controller,
                  decoration: InputDecoration(
                      focusColor: AppColors.yellow,
                      iconColor: AppColors.yellow,
                      border: InputBorder.none,
                      labelText: text,
                      labelStyle: TextStyle(color: Colors.white))),
            ),
            IconButton(
              onPressed: () {
                run();
              },
              icon: const Icon(Icons.search),
            )
          ],
        ),
      ),
    );
  }
}
