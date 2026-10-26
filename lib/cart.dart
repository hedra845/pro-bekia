import 'package:flutter/material.dart';
import 'package:pro_bekia/buying_list.dart';
import 'package:url_launcher/url_launcher.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}
void sendOrdersToWhatsApp(List<Map<String, String>> items) async {
  final filteredItems = items.where((item) => int.parse(item['number']!) > 0).toList();

  if (filteredItems.isEmpty) {
    print("لا يوجد طلبات لإرسالها");
    return;
  }

  String message = filteredItems.asMap().entries.map((entry) {
    int index = entry.key + 1;
    Map<String, String> item = entry.value;
    return "الطلب $index:\n"
        "المنتج: ${item['title']}\n"
        "العدد: ${item['number']}\n"
        "السعر: ${item['price']}";
  }).join('\n\n');

  var phoneNumber = "201123311995";
  final Uri url = Uri.parse("https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}");

  if (items.isNotEmpty) {
    await launchUrl(url, mode: LaunchMode.externalApplication,);
  } else {
    throw 'Could not launch $url';
  }
}



class _CartState extends State<Cart> {
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Text(
            'Pro Bekia',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 10),
          Image.asset('assets/logo.jpg'),
        ],
        backgroundColor: Color(0xff21853C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ListView.builder(
                    itemBuilder:
                        (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                          child: Container(
                            margin: EdgeInsets.all(8),
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              boxShadow: [BoxShadow(blurRadius: 1)],
                              color: Colors.yellow[50],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(150),
                                        ),
                                        backgroundColor: Color(0xff21853C),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                           buyingLists[index]['number'] =(int.parse(buyingLists[index]['number']!) +1).toString();
                                        });
                                      },
                                      child: Center(
                                        child: Icon(Icons.add, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 3),
                                Text(buyingLists[index]['number']!),
                                SizedBox(width: 3),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(150),
                                        ),
                                        backgroundColor: Color(0xff21853C),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          buyingLists[index]['number'] =
                                              (int.parse(buyingLists[index]['number']!) -
                                                      1)
                                                  .toString();
                                        });
                                      },
                                      child: Center(
                                        child: Icon(
                                          Icons.minimize,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Text(buyingLists[index]['title']!),
                                        Text('${buyingLists[index]['price']!}جنيه'),
                                      ],
                                    ),
                                    SizedBox(width: 5),
                                    Image.asset(buyingLists[index]['image']!,width: 50,height: 50,),                           
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                    itemCount: buyingLists.length,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: (){
                      sendOrdersToWhatsApp(buyingLists);
                      print(buyingLists);
                    },style: ElevatedButton.styleFrom(backgroundColor: Color(0xff21853C)), child: Text('ارسال الطلب',style: TextStyle(color: Colors.white),),),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
