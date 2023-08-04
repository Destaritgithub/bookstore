// ignore_for_file: prefer_const_constructors

import 'package:bookstore/view/ui/otp.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String phone = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.only(right: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "assets/B.png",
                        height: 70,
                      ),
                      Image.asset(
                        "assets/fkr.jpg",
                        height: 70,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Ethiopean All Book in One App",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                    ),
                    Text("Login"),
                    Container(
                        child: Column(
                      children: [
                        Text("Mobile Number"),
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 40, right: 40),
                                  child: TextFormField(
                                    key: const ValueKey('phone'),
                                    decoration: InputDecoration(
                                      hintText: "Enter Mobile Number",
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                      prefixIcon: Container(
                                          margin: EdgeInsets.only(
                                              left: 10, top: 15),
                                          child: const Text(
                                            "+251",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Your phone';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (value) {
                                      setState(() {
                                        phone = value!;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(height: 15,),
                                OutlinedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30))),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        padding: MaterialStateProperty.all(
                                            const EdgeInsets.fromLTRB(
                                                120, 15, 120, 15)),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.brown)),
                                    onPressed: () {
                                      //_showDialog(context);
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();

                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => OTPScreen(phone: phone,
                                                           )));
                                      }
                                    },
                                    child: Text('Next')),
                              ],
                            ))
                      ],
                    )),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.yellow,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
