import 'package:flutter/material.dart';
import 'package:tabibiplanet/Login_Screens/core/const.dart';

class InputWidget extends StatelessWidget {
  final String placeholder;
  final IconData icon;
  final bool secret;
  final String msg;
  final TextEditingController contr;
  final bool validate;
  final String errorText;

  const InputWidget({
    Key? key,
    required this.placeholder,
    required this.icon,
    this.secret = false,
    required this.msg,
    required this.contr,
    required this.validate,
    required this.errorText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.lightblack,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      height: 50,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              icon,
              color: AppColors.white.withAlpha(75),
            ),
          ),
          Container(
            width: 1,
            height: double.infinity,
            color: AppColors.black,
          ),
          Expanded(
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              controller: contr,
              validator: (value) {
                if (value!.isEmpty) return msg;
                if (placeholder == "Email" && !value.contains("@") ||
                    !value.contains(".")) return "Email is Invalid";
                return null;
              },
              obscureText: secret,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                labelStyle: TextStyle(
                  color: AppColors.white.withAlpha(75),
                ),
                hintStyle: TextStyle(
                  color: AppColors.blue.withAlpha(75),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: "$placeholder",
              ),
            ),
          ),
          if (secret) ...[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Icons.remove_red_eye,
                color: AppColors.white.withAlpha(75),
              ),
            )
          ]
        ],
      ),
    );
  }
}

class InputWidgetPassword extends StatelessWidget {
  final String placeholder;
  final IconData icon;
  final bool secret;
  final String msg;
  final TextEditingController contr;

  const InputWidgetPassword({
    Key? key,
    required this.placeholder,
    required this.icon,
    this.secret = false,
    required this.msg,
    required this.contr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.lightblack,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      height: 50,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              icon,
              color: AppColors.white.withAlpha(75),
            ),
          ),
          Container(
            width: 1,
            height: double.infinity,
            color: AppColors.black,
          ),
          Expanded(
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              controller: contr,
              validator: (value) {
                if (value!.isEmpty) return msg;
                if (value.length < 8) {
                  return "Password length must have >=8";
                }
                return null;
              },
              obscureText: secret,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                labelStyle: TextStyle(
                  color: AppColors.white.withAlpha(75),
                ),
                hintStyle: TextStyle(
                  color: AppColors.blue.withAlpha(75),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: "$placeholder",
              ),
            ),
          ),
          if (secret) ...[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: AppColors.white.withAlpha(75),
                  ),
                  onPressed: () {
                    !secret;
                  }),
            )
          ]
        ],
      ),
    );
  }
}

class InputWidgetNumber extends StatelessWidget {
  final String placeholder;
  final IconData icon;

  final bool number;
  final TextEditingController contr;
  const InputWidgetNumber({
    Key? key,
    required this.placeholder,
    required this.icon,
    this.number = false,
    required this.contr,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.lightblack,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      height: 50,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              icon,
              color: AppColors.white.withAlpha(75),
            ),
          ),
          Container(
            width: 1,
            height: double.infinity,
            color: AppColors.black,
          ),
          Expanded(
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              controller: contr,
              validator: (value) {
                if (value!.isEmpty) return "Phone number can't be empty";
                if (value.length < 8) {
                  return "Phone Number length must have >=8";
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                labelStyle: TextStyle(
                  color: AppColors.white.withAlpha(75),
                ),
                hintStyle: TextStyle(
                  color: AppColors.blue.withAlpha(75),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: "$placeholder",
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }
}

class InputWidgetall extends StatelessWidget {
  final String placeholder;
  final IconData icon;
  final bool secret;
  final String msg;
  final TextEditingController contr;
  final bool validate;
  final String errorText;

  const InputWidgetall({
    Key? key,
    required this.placeholder,
    required this.icon,
    this.secret = false,
    required this.msg,
    required this.contr,
    required this.validate,
    required this.errorText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.lightblack,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      height: 50,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              icon,
              color: AppColors.white.withAlpha(75),
            ),
          ),
          Container(
            width: 1,
            height: double.infinity,
            color: AppColors.black,
          ),
          Expanded(
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              controller: contr,
              validator: (value) {
                if (value!.isEmpty) return msg;
                return null;
              },
              obscureText: secret,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: "$placeholder",
                hintText: "$placeholder",
                labelStyle: TextStyle(
                  color: AppColors.white.withAlpha(75),
                ),
                hintStyle: TextStyle(
                  color: AppColors.blue.withAlpha(75),
                ),
              ),
            ),
          ),
          if (secret) ...[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Icons.remove_red_eye,
                color: AppColors.white.withAlpha(75),
              ),
            )
          ]
        ],
      ),
    );
  }
}

class InputWidgetYear extends StatelessWidget {
  final String placeholder;
  final IconData icon;

  final bool number;
  final TextEditingController contr;
  const InputWidgetYear({
    Key? key,
    required this.placeholder,
    required this.icon,
    this.number = false,
    required this.contr,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.lightblack,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      height: 50,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              icon,
              color: AppColors.white.withAlpha(75),
            ),
          ),
          Container(
            width: 1,
            height: double.infinity,
            color: AppColors.black,
          ),
          Expanded(
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              controller: contr,
              validator: (value) {
                if (value!.isEmpty)
                  return "Years of Experiences can't be empty";
                if (value.length > 2) {
                  return "Years Number length must have >=2";
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                labelStyle: TextStyle(
                  color: AppColors.white.withAlpha(75),
                ),
                hintStyle: TextStyle(
                  color: AppColors.blue.withAlpha(75),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: "$placeholder",
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }
}
