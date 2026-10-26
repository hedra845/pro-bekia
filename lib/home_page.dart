import 'package:flutter/material.dart';
import 'package:pro_bekia/buying_list.dart';
import 'package:pro_bekia/cart.dart';
import 'package:pro_bekia/cart_widget.dart';
import 'package:pro_bekia/pro.dart';
import 'package:pro_bekia/widget_home_page.dart';

class BekiaHomePage extends StatefulWidget {
  const BekiaHomePage({super.key});

  @override
  State<BekiaHomePage> createState() => _BekiaHomePageState();
}

class _BekiaHomePageState extends State<BekiaHomePage> {
    final PageController _pageController = PageController();
  int cart_count = 0;
  int _selectedIndex = 0;
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _pageController.dispose(); // مهم تنظيف الكنترولر
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            if (cart_count == []) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Cart is empty')));
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Cart()),
              );
            }
          },
          child: Stack(
            children: [
              Positioned(
                top: 10,
                right: 5,
                child: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$cart_count',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Icon(Icons.shopping_cart_outlined, color: Colors.white),
              ),
            ],
          ),
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
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.asset('assets/logo.png'),
          ),
        ],
        backgroundColor: Color(0xff21853C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 0,
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          border: Border.symmetric(
            horizontal: BorderSide(
              width: 1,
              color: Color(0xff21853C),
            ), // ✅ Border thickness
          ),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
          child: BottomNavigationBar(
            selectedItemColor: Color(0xff21853C),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'السلة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'الحساب',
          ),
        ],
      ),
        ),
      ),
      body: SafeArea(
          child: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: <Widget>[
          SingleChildScrollView(padding: EdgeInsets.all(10),child: WidgetHomePage()),
          SingleChildScrollView(padding: EdgeInsets.all(10),child: CartWidget()),
          SingleChildScrollView(padding: EdgeInsets.all(10),child: ProfileWidget()),
        ],
      ),
        ),
    );
  }
}
