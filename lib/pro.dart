import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
final Uri url = Uri.parse('https://wa.me/201551407492');

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "hedra naguib",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff21853C),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Icon(Icons.account_circle, color: Color(0xff21853C), size: 35),
            ],
          ),
        ),
        const SizedBox(height: 20),
   GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AboutUsPage()),
    );
  },
  child: buildOptionTile('أعرف عنا', Icons.info_outline, Colors.grey.shade100),
),

GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const TermsPage()),
    );
  },
  child: buildOptionTile('الشروط والأحكام', Icons.card_giftcard, Colors.grey.shade200),
),

GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PrivacyPage()),
    );
  },
  child: buildOptionTile('سياسة الخصوصية', Icons.security, Colors.grey.shade100),
),

GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ContactPage()),
    );
  },
  child: buildOptionTile('تواصل معنا', Icons.mail_outline, Colors.grey.shade200),
),

    const Divider(thickness: 1),
    GestureDetector(onTap: () {
      
    },child: buildOptionTile('تسجيل الدخول', Icons.login, Colors.grey.shade100)),
    SizedBox(height: 20,),
    GestureDetector(onTap: () async {
        if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
    }
    },
    child: Text('@Eng/hedra naguib',style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff21853C),),)),
      ],
    );
  }
}

Widget buildOptionTile(String title, IconData trailingIcon, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12),
    ),
    child: ListTile(
      leading: const Icon(Icons.arrow_back_ios),
      trailing: Icon(trailingIcon),
      title: Text(
        title,
        textAlign: TextAlign.end,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  );
}




// Ab
class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('أعرف عنا')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'نحن شركة بيكيا نعمل على إعادة تدوير المخلفات من خلال استبدالها بمنتجات مفيدة. نهدف إلى المساهمة في الحفاظ على البيئة وتشجيع المستخدمين على التخلص من المخلفات بطريقة مفيدة.',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}

// Terms and Conditions Page
class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الشروط والأحكام')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'باستخدامك لتطبيق بيكيا فإنك توافق على جميع الشروط والأحكام الخاصة بالخدمة، بما في ذلك الالتزام بالقوانين المحلية وعدم إساءة استخدام التطبيق.',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}

// Privacy Policy Page
class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('سياسة الخصوصية')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'نحترم خصوصيتك. يتم جمع البيانات فقط لتقديم خدمات أفضل لك، ولا يتم مشاركة معلوماتك مع أي طرف ثالث دون إذنك.',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}

// Contact Us Page
class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تواصل معنا')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('للتواصل معنا:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('📧 البريد الإلكتروني: support@bekia.com', style: TextStyle(fontSize: 16)),
            SizedBox(height: 5),
            Text('📞 رقم الهاتف: 01551407492', style: TextStyle(fontSize: 16)),
            SizedBox(height: 5),
            Text('📍 العنوان: القاهرة، مصر', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}