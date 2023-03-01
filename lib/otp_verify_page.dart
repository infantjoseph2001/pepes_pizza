import 'package:flutter/material.dart';
import 'package:pepess_pizza/api_service.dart';
import 'package:pepess_pizza/config.dart';
import 'package:pepess_pizza/dish_page.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class OTPVerifyPage extends StatefulWidget {
  final String? mobileNo;
  final String? otpHash;

  OTPVerifyPage({this.mobileNo, this.otpHash});

  @override
  State<OTPVerifyPage> createState() => _OTPVerifyPageState();
}

class _OTPVerifyPageState extends State<OTPVerifyPage> {
  bool enableResendBtn = false;
  String _otpCode = "";
  final int _otpCodeLength = 4;
  bool _enableButton = false;
  late FocusNode myFocusNode;
  bool isAPIcallProcess = false;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    myFocusNode.requestFocus();

    SmsAutoFill().listenForCode.call();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ProgressHUD(
          child: otpVerify(),
          inAsyncCall: isAPIcallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget otpVerify() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 20),
          child: Center(
            child: Text(
              "OTP Verification",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Text(
            "Enter OTP code sent to you mobile \n+91-${widget.mobileNo}",
            maxLines: 2,
            style: const TextStyle(
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          //child: autoFill,
          child: PinFieldAutoFill(
            decoration: UnderlineDecoration(
              textStyle: const TextStyle(fontSize: 20, color: Colors.black),
              colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
            ),
            currentCode: _otpCode,
            codeLength: _otpCodeLength,
            onCodeSubmitted: (code) {},
            onCodeChanged: (code) {
              print(code);
              if (code!.length == _otpCodeLength) {
                _otpCode = code;
                _enableButton = true;
                FocusScope.of(context).requestFocus(FocusNode());
              }
            },
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: FormHelper.submitButton(
            "Continue",
            () {
              if (_enableButton) {
                setState(() {
                  isAPIcallProcess = true;
                });

                APIService.verifyOtp(
                        widget.mobileNo!, widget.otpHash!, _otpCode)
                    .then((response) {
                  setState(() {
                    isAPIcallProcess = false;
                  });

                  if (response.data != null) {
                    //REDIRECT TO HOME SCREEN
                    FormHelper.showSimpleAlertDialog(
                      context,
                      Config.appName,
                      response.message,
                      "OK",
                      () {
                        Navigator.pop(context);
                      },
                    );
                  } else {
                    FormHelper.showSimpleAlertDialog(
                      context,
                      Config.appName,
                      response.message,
                      "OK",
                      () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const dishpage()));
                      },
                    );
                  }
                });
              }
            },
            btnColor: HexColor("#78D0B1"),
            borderColor: HexColor("#78D0B1"),
            txtColor: HexColor(
              "#000000",
            ),
            borderRadius: 20,
          ),
        ),
      ],
    );
  }
}
