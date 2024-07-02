import 'package:flutter/material.dart';
import 'package:sos/export.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.black,
        toolbarHeight: 104,
        backgroundColor: AppColors.primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: Text(
          "About Us",
          style: TextView.text70010Black.copyWith(
            fontSize: 20,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.symmetric(
          horizontal: 28,
          vertical: 28,
        ),
        child: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About Us:",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(
                "Welcome to AID - a beacon of hope and assistance in times of crisis. We are more than just an organization we are a tight-knit community of compassionate individuals dedicated to aiding those facing medical emergencies, violations, and cyber-related issues. At AID, we believe in the power of unity, kindness, and proactive support to make a positive impact on society, one act of compassion at a time.",
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Our Mission:",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(
                ''' "At AID, our mission goes beyond simply responding to emergencies. We are committed to preventing crises through proactive community engagement and support. Together, we can build a safer, more resilient future where everyone feels valued and supported. - AID Founders" ''',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Our Approach:",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(
                "In times of crisis, unity is our greatest strength. Together, we can overcome any challenge and extend a helping hand to those in need. At AID, we are dedicated to fostering a sense of community and support, ensuring that no one faces adversity alone. - AID Team",
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "What We Do:",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(
                "At AID, we offer a comprehensive range of services designed to meet the diverse needs of our community. Whether it's providing immediate emergency assistance, aiding in obtaining blood group certificates, offering support in cyber cases, or facilitating community engagement initiatives, our dedicated team is here to lend a helping hand whenever it's needed the most.",
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                ''' "At AID, we believe that every life is precious and deserving of care and compassion. Let's come together to uplift and empower those facing adversity, one act of kindness at a time." - AID Supporters" ''',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              SizedBox(height: 10),
              Text(
                "Our Vision:",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(
                "We envision a world where no one is left behind, where acts of kindness and generosity unite people across borders and barriers. Through the Aid App, we aim to create a global network of support, where individuals can easily connect and make a positive impact on each other's lives.",
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                ''' "In times of crisis, unity is our greatest strength. Together, we can overcome any challenge and extend a helping hand to those in need." - AID Team ''',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              SizedBox(height: 10),
              Text(
                "Meet Our Team:",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Managing Director :",
                style: TextStyle(
                    fontFamily: 'Poppins', fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/man.png'),
                  ),
                  SizedBox(
                    width: 61,
                  ),
                  Text(
                    "Sathya Sai Charan.M",
                    style: TextStyle(
                        fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Technical Director :",
                style: TextStyle(
                    fontFamily: 'Poppins', fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/man.png'),
                  ),
                  SizedBox(
                    width: 61,
                  ),
                  Text(
                    "Sreekar.K",
                    style: TextStyle(
                        fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Team Frontend Head :",
                style: TextStyle(
                    fontFamily: 'Poppins', fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/man.png'),
                  ),
                  SizedBox(
                    width: 61,
                  ),
                  Text(
                    "Siva Sai Teja.D",
                    style: TextStyle(
                        fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Team Backend Head :",
                style: TextStyle(
                    fontFamily: 'Poppins', fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/man.png'),
                  ),
                  SizedBox(
                    width: 61,
                  ),
                  Text(
                    "Ravi Teja.M",
                    style: TextStyle(
                        fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Team Designing Head :",
                style: TextStyle(
                    fontFamily: 'Poppins', fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/man.png'),
                  ),
                  SizedBox(
                    width: 61,
                  ),
                  Text(
                    "Siddu.P",
                    style: TextStyle(
                        fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Team Database Head :",
                style: TextStyle(
                    fontFamily: 'Poppins', fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/man.png'),
                  ),
                  SizedBox(
                    width: 61,
                  ),
                  Text(
                    "Sharmishta Reddy",
                    style: TextStyle(
                        fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Team Web Development Head :",
                style: TextStyle(
                    fontFamily: 'Poppins', fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/man.png'),
                  ),
                  SizedBox(
                    width: 61,
                  ),
                  Text(
                    "Kriti.M",
                    style: TextStyle(
                        fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Team Content Writing Head :",
                style: TextStyle(
                    fontFamily: 'Poppins', fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/man.png'),
                  ),
                  SizedBox(
                    width: 61,
                  ),
                  Text(
                    "Nithin Reddy.T",
                    style: TextStyle(
                        fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '''"Empathy knows no boundaries. By standing together and supporting each other, we can create a world where no one feels alone in their time of need." - AID Volunteers.''',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              SizedBox(height: 10),
              Text(
                "Join Us:",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(
                '''"Every act of kindness, no matter how small, has the power to make a profound difference in someone's life. Let's spread compassion and support one another in times of adversity. Together, we can create a brighter, more inclusive future for all." - AID Community.''',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '''Continuous Improvement: We are dedicated to continuously enhancing the Aid App to better serve the needs of our users. We welcome feedback, suggestions, and ideas for improvement as we strive to evolve and adapt to meet the evolving needs of our community.''',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '''Whether you're a volunteer looking to make a difference, a supporter seeking to uplift those in need, or an individual facing a crisis, AID welcomes you with open arms. Together, we can make a difference and create a world where compassion knows no bounds.''',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              SizedBox(
                height: 11,
              ),
              Text(
                '''Thank you for choosing AID. Together, we can make the world a better place.''',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
