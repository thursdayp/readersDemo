import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:readers/Login/login_screen.dart';
import 'package:readers/Login/profile_screen.dart';
import 'package:readers/data/UserModel.dart';
import 'package:readers/screen/homgpage_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _name = TextEditingController();
  final _age = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool registering = false;
  String name = '';
  String age = '';
  String email = '';
  String password = '';
  String confirmPassword = '';

  final prohibitedChars =
      RegExp(r'[!@#\$%^&*(),.?":{}|<>]'); // Prohibited characters
  final allowedDomains = ['gmail.com', 'yahoo.com']; // Allowed email domains

  String? _validateRegisterInput(
      String? value, String label, int min, int max) {
    if (value!.isEmpty) {
      return 'กรุณาระบุ $label';
    } else if (value.length < min || value.length > max) {
      return 'กรุณา $label ความยาว $min - $max อักขระ';
    } else if (label == 'Name' && prohibitedChars.hasMatch(value)) {
      return 'ชื่อไม่ควรมีอักขระพิเศษ';
    } else if (label == 'Email') {
      String domain = value.split('@').last;
      if (!allowedDomains.contains(domain)) {
        return 'กรุณาใช้อีเมล์จาก $allowedDomains';
      }
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'กรุณากรอกรหัสผ่าน';
    }
    if (value.length < 8) {
      return 'รหัสผ่านต้องประกอบด้วย 8 อักขระขึ้นไป';
    }
    if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
      return 'รหัสผ่านต้องมีอักขระพิเศษอย่างน้อย 1 ตัว';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'กรุณากรอกรหัสผ่านอีกครั้ง';
    }
    if (value != _password.text) {
      return 'กรุณากรอกรหัสให้ตรงกัน';
    }
    return null;
  }

  void resetInput() {
    _formKey.currentState?.reset();
    _name.clear();
    _age.clear();
    _email.clear();
    _password.clear();
    _confirmPassword.clear();
  }

  void registration() {
    if (!mounted) return; // ตรวจสอบว่าหน้านี้ยังถูก mount อยู่
    showProcessingSnackBar(); // แสดง SnackBar ระหว่างการประมวลผล
    Future.delayed(const Duration(seconds: 2), () {
      if (_formKey.currentState?.validate() ?? false) {
        setState(() {
          registering = true;
          name = _name.text;
          age = _age.text;
          email = _email.text;
          password = _password.text;
        });
        showSuccessSnackBar(); // แสดง SnackBar เมื่อสำเร็จ
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        showErrorSnackBar('ข้อมูลไม่ถูกต้อง กรุณาตรวจสอบใหม่');
      }
    });
  }

  void gotoLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/login');
  }

  void showProcessingSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('กำลังดำเนินการ...'),
        backgroundColor: Colors.blueGrey,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('ลงทะเบียนสำเร็จ'),
        backgroundColor: Colors.green,
        action: SnackBarAction(
          label: 'ไปที่หน้า Profile',
          onPressed: () {
            if (mounted) {
              // เช็คว่าหน้านี้ยัง active อยู่หรือไม่
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const ProfileScreen()), // เปลี่ยนไปยังหน้า ProfileScreen
              );
            }
          },
          textColor: Colors.white,
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(5),
      ),
    );
  }

  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'ปิด',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
          textColor: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    controller: _name,
                    validator: (value) =>
                        _validateRegisterInput(value, 'Name', 1, 50),
                    decoration: const InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(),
                      // ลบหรือเปลี่ยนไอคอนลูกศรที่นี่
                      prefixIcon: Icon(Icons.person_pin_rounded),
                      // ไม่ต้องการให้มีลูกศรแสดงใน TextFormField
                      suffixIcon: null,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    controller: _age,
                    validator: (value) =>
                        _validateRegisterInput(value, 'Age', 1, 3),
                    decoration: const InputDecoration(
                      labelText: "Age",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.numbers),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    controller: _email,
                    validator: (value) =>
                        _validateRegisterInput(value, 'Email', 10, 50),
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    controller: _password,
                    validator: _validatePassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    controller: _confirmPassword,
                    validator: _validateConfirmPassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Confirm Password",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: registration,
                        child: const Text("ตกลง"),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: resetInput,
                        child: const Text("ยกเลิก"),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const Loginscreen()), // เปลี่ยนเป็น Loginscreen()
                    ),
                    child: const Text(
                      "มีบัญชีอยู่แล้ว",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
