import 'package:attendance_tracking/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Myprofile extends StatefulWidget {
  const Myprofile({super.key});

  @override
  State<Myprofile> createState() => _MyprofileState();
}

class _MyprofileState extends State<Myprofile> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          //  crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Your Profile',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                // letterSpacing: 1.0,
              ),
            ),
          ],
        ),
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
        ),
        backgroundColor: const Color.fromARGB(255, 212, 91, 105),
      ),
      body: Column(
        children: [
          SizedBox(
            height:deviceHeight * 0.05,
            ),
          const CircleAvatar(
            radius: 80,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/images/default_avatar.png'),
          ),
          SizedBox(
            height:deviceHeight * 0.010,
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0,5),
                    color: Colors.blueGrey.withOpacity(0.2),
                    spreadRadius: 4,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: const ListTile(
                title: Text('Name'),
                subtitle: Text('Not Available'),
                leading: Icon(CupertinoIcons.person_fill),
              ),
            ),
          ),
          SizedBox(
            height:deviceHeight * 0.005,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 5),
                    color: Colors.blueGrey.withOpacity(0.2),
                    spreadRadius: 4,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: const ListTile(
                title: Text('Address'),
                subtitle: Text('Biratnagar, Nepal'),
                leading: Icon(CupertinoIcons.home),
              ),
            ),
          ),
          SizedBox(
            height:deviceHeight * 0.005,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 5),
                    color: Colors.blueGrey.withOpacity(0.2),
                    spreadRadius: 4,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: const ListTile(
                title: Text('contact'),
                subtitle: Text('+977-9812345678'),
                leading: Icon(CupertinoIcons.phone_fill),
              ),
            ),
          ),
          SizedBox(
            height:deviceHeight * 0.005,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 5),
                    color: Colors.blueGrey.withOpacity(0.2),
                    spreadRadius: 4,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: const ListTile(
                title: Text('e_Mail'),
                subtitle: Text('abc@gmail.com'),
                leading: Icon(CupertinoIcons.mail_solid),
              ),
            ),
          ),
          SizedBox(
            height:deviceHeight * 0.005,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 5),
                    color: Colors.blueGrey.withOpacity(0.2),
                    spreadRadius: 4,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: const ListTile(
                title: Text('Designation'),
                subtitle: Text('Officer'),
                leading: Icon(CupertinoIcons.person_2_fill),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
