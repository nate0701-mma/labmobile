import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:my_first_app/config/config.dart';
import 'package:my_first_app/model/request/customer_login_post_req.dart';
import 'package:my_first_app/model/response/customer_login_post_res.dart';
import 'package:my_first_app/pages/register.dart';
import 'package:my_first_app/pages/showtrip.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String text = '';
  int num = 0;
  String password = '';
  TextEditingController phoneNoCtl = TextEditingController();
  TextEditingController passwordCtl = TextEditingController();
  String url = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Configuration.getConfig().then((config) {
      url = config['apiEndpoint'];
      log("API endpoint from config: $url");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                child: Image.asset(
                  'asset/imge/4DQpjUtzLUwmJZZSGo1ixqZnRpnOmMWSTOyUajProYYU.jpg',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "หมายเลขโทรศัพท์",
                              style: TextStyle(
                                fontSize: 20,
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                          child: TextField(
                            controller: phoneNoCtl,
                            // onChanged: (value) {
                            //   phoneNO = value;
                            // },
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 5),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "รหัสผ่าน",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                          child: TextField(
                            controller: passwordCtl,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 5),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: register,
                            child: const Text(
                              'ลงทะเบียนใหม่',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          FilledButton(
                            onPressed: () {
                              login();
                            },
                            child: const Text(
                              'เข้าสู่ระบบ',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 20,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void register() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }

  void login() {
    // var data = {"phone": "0817399999", "password": "1111"};
    CustomerLoginPostRequest customerLoginPostRequest =
        CustomerLoginPostRequest(
          phone: phoneNoCtl.text,
          password: passwordCtl.text,
        );
    http
        .post(
          Uri.parse("$url/customers/login"),
          headers: {"Content-Type": "application/json; charset=utf-8"},
          body: customerLoginPostRequestToJson(customerLoginPostRequest),
        )
        .then((value) {
          CustomerLoginPostResponse customerLoginPostResponse =
              customerLoginPostResponseFromJson(value.body);
          log(customerLoginPostResponse.customer.email);
          log(customerLoginPostResponse.customer.fullname);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ShowtripPage(cid: customerLoginPostResponse.customer.idx),
            ),
          );
        })
        .catchError((error) {
          log('Error $error');
        });
  }
}
