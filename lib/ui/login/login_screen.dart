import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset('assets/images/background.jpg', fit: BoxFit.cover)),
          SafeArea(
              child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.only(left: 27, right: 27, top: 10),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Image.asset('assets/images/logo.png'),
                  const SizedBox(height: 80),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Tên người dùng',
                      labelStyle: const TextStyle(fontSize: 16, color: Colors.black54),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.blueAccent, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black45, width: 2.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Mật khẩu',
                      labelStyle: const TextStyle(fontSize: 16, color: Colors.black54),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.blueAccent, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black45, width: 2.0),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                      ),
                    ),
                    obscureText: !_isPasswordVisible,
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                              colors: [Colors.blue, Colors.purple],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              offset: const Offset(0, 5),
                              blurRadius: 5,
                              spreadRadius: 0,
                            )
                          ]),
                      child: ElevatedButton(
                          onPressed: () {
                            context.go('/app');
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(15.0),
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            elevation: 8,
                          ),
                          child: const Text('ĐĂNG NHẬP',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold))),
                    ),
                  )
                ],
              ),
            )),
          ))
        ],
      ),
    );
  }
}
