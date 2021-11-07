import 'package:flutter/material.dart';

class UploadingDialogWidget extends StatelessWidget {
  const UploadingDialogWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.4),
      body: Dialog(
        backgroundColor: Colors.white,
        insetAnimationCurve: Curves.easeInOut,
        insetAnimationDuration: const Duration(milliseconds: 100),
        elevation: 8.0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.8))),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Row body
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  SizedBox(width: 8.0),
                  // Show progress indicator
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue)),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  // Show text
                  Expanded(
                    child: Text(
                      "Loading",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(width: 8.0)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
