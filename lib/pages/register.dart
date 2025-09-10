import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_first_app/config/config.dart';
import 'package:my_first_app/model/request/customer_register_post_req.dart';
import 'package:my_first_app/model/response/customer_register_post_res.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> {
  TextEditingController fullnameCtl = TextEditingController();
  TextEditingController phoneCtl = TextEditingController();
  TextEditingController emilCtl = TextEditingController();
  TextEditingController passwordClt = TextEditingController();
  TextEditingController confrimpasswordClt = TextEditingController();
  String url = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Configuration.getConfig().then((config) {
      url = config['apiEndpoint'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ลงทะเบียนสมาชิกใหม่')),
      body: Container(
        child: Column(
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 15, 0, 0),
                  child: Text(
                    "ชื่อ-นามสกุล",
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                controller: fullnameCtl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(width: 5)),
                ),
              ),
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 15, 0, 0),
                  child: Text(
                    "หมายเลขโทรศัพท์",
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                controller: phoneCtl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(width: 5)),
                ),
              ),
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 15, 0, 0),
                  child: Text(
                    "อีเมล",
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                controller: emilCtl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(width: 5)),
                ),
              ),
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 15, 0, 0),
                  child: Text(
                    "รหัสผ่าน",
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                controller: passwordClt,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(width: 5)),
                ),
              ),
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 15, 0, 0),
                  child: Text(
                    "ยืนยันรหัสผ่าน",
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                controller: confrimpasswordClt,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(width: 5)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: 200,
                child: FilledButton(
                  onPressed: () => regiater(),
                  child: const Text(
                    'สมัครสมาชิก',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'หากมีบัญชีอยู่แล้ว?',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 107, 103, 103),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'เข้าสู่ระบบ',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void regiater() {
    CustomerRegisterPostReques customerRegisterPostReques =
        CustomerRegisterPostReques(
          fullname: fullnameCtl.text,
          phone: phoneCtl.text,
          email: emilCtl.text,
          image: "",
          password: passwordClt.text,
        );
    http
        .post(
          Uri.parse("$url/customers/register"),
          headers: {"Content-Type": "application/json; charset=utf-8"},
          body: customerRegisterPostRequesToJson(customerRegisterPostReques),
        )
        .then((res) {
          CustomerRegisterPostResponse customerRegisterPostResponse =
              customerRegisterPostResponseFromJson(res.body);
          log(customerRegisterPostResponse.message);
        })
        .catchError((error) {
          log('Error $error');
        });
  }
}
