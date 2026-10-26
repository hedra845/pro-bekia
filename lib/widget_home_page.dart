import 'package:flutter/material.dart';
import 'package:pro_bekia/buying_list.dart';
import 'package:pro_bekia/list_categories.dart';
import 'package:pro_bekia/list_items.dart';

class WidgetHomePage extends StatefulWidget {
  const WidgetHomePage({super.key});

  @override
  State<WidgetHomePage> createState() => _WidgetHomePageState();
}

class _WidgetHomePageState extends State<WidgetHomePage> {
  @override
    int cart_count = 0;
  void addToCart(Map<String, String> item) {
    int existingIndex = buyingLists.indexWhere(
      (element) => element['title'] == item['title'],
    );

    setState(() {
      if (existingIndex != -1) {
        // العنصر موجود، زوّد الكمية
        int currentNumber = int.parse(buyingLists[existingIndex]['number']!);
        buyingLists[existingIndex]['number'] = (currentNumber + 1).toString();
      } else {
        // العنصر غير موجود، أضفه مع quantity = 1
        buyingLists.add({...item, 'number': '1'});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Banner
        Container(
          height: 160,
          decoration: BoxDecoration(
            color: Colors.green[800],
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: AssetImage('assets/banner.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 20),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "الكراكيب الأكثر طلباً",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final cat = categories[index];
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2,
                            offset: Offset(0, 2),
                          ),
                        ],
                        color: Colors.yellow[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 3.0,
                              right: 3.0,
                            ),
                            child: Image.asset(cat['image']!, height: 40),
                          ),
                          SizedBox(height: 8),
                          Text(
                            cat['title']!,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(height: 20),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "اكتشف كراكيب البيت",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 220,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 5),
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder:
                  (context, index) => Container(
                    height: 200,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2,
                          offset: Offset(0, 2),
                        ),
                      ],
                      color: Colors.yellow[50],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          items[index]['image']!,
                          height: 70,
                          width: 70,
                        ),
                        SizedBox(height: 10),
                        Text(
                          items[index]['title']!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          " ${items[index]['price']!} ج.م",
                          style: TextStyle(color: Colors.green[800]),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              backgroundColor: Color(0xff21853C),
                            ),
                            onPressed: () {
                              setState(() {
                                cart_count++;
                                buyingLists.add(items[index]);
                                addToCart({
                                  'title': items[index]['title']!,
                                  'price': items[index]['price']!,
                                  'image': items[index]['image']!,
                                });
                              });
                            },
                            child: Text(
                              'اضف للسلة',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            ),
          ),
        ),
        SizedBox(height: 10),
        if (buyingLists.isNotEmpty)
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "تمت اضافته مؤخرا",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        SizedBox(height: 10),
        if (buyingLists.isNotEmpty)
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemBuilder:
                  (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2,
                            offset: Offset(0, 2),
                          ),
                        ],
                        color: Colors.yellow[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              backgroundColor: Color(0xff21853C),
                            ),
                            onPressed: () {
                              setState(() {});
                            },
                            child: Text(
                              'اضف للسلة',
                              style: TextStyle(color: Colors.white),
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
                                  Text(buyingLists[index]['price']!),
                                ],
                              ),
                              SizedBox(width: 10),
                              Image.asset(
                                buyingLists[index]['image']!,
                                height: 40,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              itemCount: buyingLists.length,
            ),
          ),
      ],
    );
  }
}
