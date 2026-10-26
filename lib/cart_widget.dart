import 'package:flutter/material.dart';
import 'package:pro_bekia/buying_list.dart';
import 'package:pro_bekia/cart.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: ListView.builder(
            itemBuilder:
                (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
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
                                  buyingLists[index]['number'] =
                                      (int.parse(
                                                buyingLists[index]['number']!,
                                              ) +
                                              1)
                                          .toString();
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
                                      (int.parse(
                                                buyingLists[index]['number']!,
                                              ) -
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
                                Text('${buyingLists[index]['price']! }ج.م.ك '),
                              ],
                            ),
                            SizedBox(width: 5),
                            Image.asset(
                              buyingLists[index]['image']!,
                              width: 50,
                              height: 50,
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
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                sendOrdersToWhatsApp(buyingLists);
                print(buyingLists);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff21853C),
              ),
              child: Text('ارسال الطلب', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }
}
