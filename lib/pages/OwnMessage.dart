import 'package:flutter/material.dart';

class OwnMessage extends StatelessWidget {
  const OwnMessage({Key? key, required this.message, required this.time})
      : super(key: key);
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 1.25,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          color: Colors.blue.shade200,
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 12, right: 60, top: 5, bottom: 20),
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Positioned(
              bottom: 4,
              right: 10,
              child: Row(
                children: [
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.done_all,
                    size: 20,
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
