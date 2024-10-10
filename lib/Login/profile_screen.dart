import 'package:flutter/material.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ส่วนข้อมูลผู้ใช้งาน
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  // รูปโปรไฟล์
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/profile.jpg'),
                  ),
                  const SizedBox(width: 16),
                  // ชื่อและ Username
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Karina Yu',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Username: Karinayu2004@gmail.com',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            // เมนูตัวเลือกต่าง ๆ
            Expanded(
              child: ListView(
                children: [
                  _buildProfileOption(context, 'แก้ไขข้อมูลส่วนตัว'),
                  _buildProfileOption(context, 'เปลี่ยนรหัสผ่าน'),
                  _buildProfileOption(context, 'การเชื่อมต่อบัญชี'),
                  _buildProfileOption(context, 'ตั้งค่าการแสดงผล'),
                  _buildProfileOption(context, 'ตั้งค่าประสิทธิภาพ'),
                  _buildProfileOption(context, 'ตั้งค่าความปลอดภัย'),
                  _buildProfileOption(context, 'ติดต่อเรา'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // ปุ่มออกจากระบบ
            ElevatedButton(
              onPressed: () {
                // เพิ่มฟังก์ชันออกจากระบบที่นี่
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'ออกจากระบบ',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ฟังก์ชันสร้างปุ่มตัวเลือกต่างๆ
  Widget _buildProfileOption(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // เพิ่มฟังก์ชันการทำงานตามปุ่มที่เลือก
        },
      ),
    );
  }
}
