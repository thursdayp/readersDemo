import 'package:flutter/material.dart';
import 'package:readers/Login/register_screen.dart';
import 'package:readers/screen/homgpage_screen.dart';
import 'package:flutter/gestures.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  late bool loggedIn;
  late String email;
  late String password;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _form = GlobalKey<FormState>();

  String? _validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      return 'กรุณากรอกชื่อผู้ใช้';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'กรุณาระบุรหัสผ่าน';
    }
    if (value.length < 8) {
      return 'รหัสผ่านต้องกรอก 8 อักขระขึ้นไป';
    }
    return null;
  }

  void _validate() {
    final form = _form.currentState;
    if (form?.validate() ?? false) {
      setState(() {
        loggedIn = true;
        email = _emailController.text;
        password = _passwordController.text;
      });

      // เปลี่ยนไปยังหน้า HomePage ทันทีหลังจากเข้าสู่ระบบ
      if (loggedIn) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    loggedIn = false;
    email = '';
    password = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'ReadersTrack',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _form,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                        validator: _validateEmail,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(),
                        ),
                        validator: _validatePassword,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: ElevatedButton(
                            onPressed: _validate,
                            child: const Text('Login'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: ElevatedButton(
                            onPressed: () {
                              _emailController.clear();
                              _passwordController.clear();
                            },
                            child: const Text('Cancel'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.facebook),
                  SizedBox(width: 10),
                  Icon(Icons.g_mobiledata),
                  SizedBox(width: 10),
                  Icon(Icons.cancel),
                ],
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: Colors.black), // สีข้อความอื่น
                    ),
                    TextSpan(
                      text: 'Sign up ',
                      style: const TextStyle(
                          color: Colors.blue), // สีฟ้าสำหรับ "Sign up"
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()),
                          );
                        },
                    ),
                    const TextSpan(
                      text: 'now',
                      style: TextStyle(color: Colors.black), // สีข้อความอื่น
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
}
