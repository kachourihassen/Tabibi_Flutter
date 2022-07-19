import 'package:flutter/material.dart';

class CustomTextBoxDoc extends StatelessWidget {
  final TextEditingController search;

  const CustomTextBoxDoc({Key? key, required this.search}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 12, 12, 12),
          borderRadius: BorderRadius.circular(50)),
      child: Material(
        elevation: 20.0,
        child: TextFormField(
          controller: search,
          maxLines: 4,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            //prefixIcon: Icon(Icons.search, color: Colors.grey),
            border: InputBorder.none,
            hintText: "  Write what you are feeling ...",
            hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
          ),
        ),
      ),
    );
  }
}
