import 'dart:async';

import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  bool _isResendAgain = false;
  bool _isVerified = false;
  bool _isLoading = false;

  String _code = '';

  late Timer _timer;
  int _start = 60;
  int _currentIndex = 0;

  void resend() {
    setState(() {
      _isResendAgain = true;
    });

    const oneSec = Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_start == 0) {
          _start = 60;
          _isResendAgain = false;
          timer.cancel();
        } else {
          _start--;
        }
      });
    });
  }

  verify() {
    setState(() {
      _isLoading = true;
    });

    const oneSec = Duration(milliseconds: 2000);
    _timer = new Timer.periodic(oneSec, (timer) {
      setState(() {
        _isLoading = false;
        _isVerified = true;
      });
    });
  }

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _currentIndex++;

        if (_currentIndex == 3) _currentIndex = 0;
      });
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: width * 0.3,
                height: height * 0.3,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade200,
                ),
                child: Transform.rotate(
                  angle: 38,
                  child: const Image(
                    image: AssetImage('assets/email.png'),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),

              // duration: const Duration(milliseconds: 500),
              const Text(
                "Verification",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: height * 0.02,
              ),

              // delay: const Duration(milliseconds: 500),
              // duration: const Duration(milliseconds: 500),
              Text(
                "Please enter the 4 digit code sent to \n +93 706-399-999",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16, color: Colors.grey.shade500, height: 1.5),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              //    FadeInDown(
              //     delay: Duration(milliseconds: 600),
              //     duration: Duration(milliseconds: 500),
              //      VerificationCode(
              //       length: 4,
              //       textStyle: TextStyle(fontSize: 20, color: Colors.black),
              //       underlineColor: Colors.black,
              //       keyboardType: TextInputType.number,
              //       underlineUnfocusedColor: Colors.black,
              //       onCompleted: (value) {
              //         setState(() {
              //           _code = value;
              //         });
              //       },
              //       onEditing: (value) {},
              //     ),

              // SizedBox(height: height*0.02,),
              // FadeInDown(
              //   delay: Duration(milliseconds: 700),
              //   duration: Duration(milliseconds: 500),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't resive the OTP?",
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                  ),
                  TextButton(
                      onPressed: () {
                        if (_isResendAgain) return;
                        resend();
                      },
                      child: Text(
                        _isResendAgain
                            ? "Try again in " + _start.toString()
                            : "Resend",
                        style: TextStyle(color: Colors.blueAccent),
                      ))
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              // FadeInDown(
              //   delay: Duration(milliseconds: 800),
              //   duration: Duration(milliseconds: 500),
              MaterialButton(
                elevation: 0,
                onPressed: _code.length < 4
                    ? () => {}
                    : () {
                        verify();
                      },
                color: Colors.orange.shade400,
                minWidth: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                child: _isLoading
                    ? Container(
                        width: 20,
                        height: 20,
                        child: const CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          strokeWidth: 3,
                          color: Colors.black,
                        ),
                      )
                    : _isVerified
                        ? Icon(
                            Icons.check_circle,
                            color: Colors.white,
                            size: 30,
                          )
                        : Text(
                            "Verify",
                            style: TextStyle(color: Colors.white),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
