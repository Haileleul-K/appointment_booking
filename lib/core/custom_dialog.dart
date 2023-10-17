import 'package:flutter/material.dart';

void customDialog(VoidCallback onBtnPressed, String titleText, String subText,
    String btnText, BuildContext context) {
  var theme = Theme.of(context);

  Dialog errorDialog = Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)), //this right here
    child: Container(
      height: MediaQuery.of(context).size.height / 4.5,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            titleText,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Expanded(
            child: Text(
              subText,
              style: const TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: GestureDetector(
              onTap: onBtnPressed,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                  color: theme.primaryColor,
                ),
                height: double.infinity,
                width: double.infinity,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    btnText,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
  showDialog(
      context: context,
      // barrierColor: theme.secondaryHeaderColor.withOpacity(0.9),
      builder: (BuildContext context) => errorDialog);
}
