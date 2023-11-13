import 'package:flutter/material.dart';

import '../../common/constans.dart';

class ErrorMessage extends StatelessWidget {
  final String? image;
  final String? message;
  final Function()? onPressed;

  const ErrorMessage({
    super.key,
    required this.image,
    required this.message,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image ?? "",
            height: 150,
            width: 150,
          ),
          Text(
            message ?? "",
            style: primaryTextStyle.copyWith(
              fontSize: 14,
              fontWeight: medium,
            ),
          ),
          const SizedBox(height: 18),
          if (onPressed != null)
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
              ),
              child: Text(
                'Refresh',
                style: primaryTextStyle,
              ),
            ),
        ],
      ),
    );
  }
}
