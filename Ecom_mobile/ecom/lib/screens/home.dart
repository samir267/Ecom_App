import 'package:ecom/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _selectedCategoryIndex = 0;

  final List<String> productImages = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQZ73gGY7FekDTWOtmfCuuVCLvhCbOnSWvjw&s',
    'https://spacenet.tn/165527-large_default/telephone-portable-ipro-a7-mini-bleu.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQZ73gGY7FekDTWOtmfCuuVCLvhCbOnSWvjw&s',
    'https://spacenet.tn/165527-large_default/telephone-portable-ipro-a7-mini-bleu.jpg',
    'https://www.bfmtv.com/comparateur/wp-content/uploads/2024/04/Definition-dune-souris-gamer.jpg',
    'https://www.bfmtv.com/comparateur/wp-content/uploads/2024/04/Definition-dune-souris-gamer.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQZ73gGY7FekDTWOtmfCuuVCLvhCbOnSWvjw&s',
    'https://spacenet.tn/165527-large_default/telephone-portable-ipro-a7-mini-bleu.jpg',
    'https://www.bfmtv.com/comparateur/wp-content/uploads/2024/04/Definition-dune-souris-gamer.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQZ73gGY7FekDTWOtmfCuuVCLvhCbOnSWvjw&s',
  ];

  final List<String> categories = ["All", "Electronics", "Fashion", "Toys", "Sports", "Home"];
  final List<IconData> categoryIcons = [
    Icons.category, // All
    Icons.devices, // Electronics
    Icons.checkroom, // Fashion
    Icons.toys, // Toys
    Icons.sports, // Sports
    Icons.home, // Home
  ];

  void _onCategoryTapped(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFCF0EBE),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search products",
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFCF0EBE),
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home',),
              onTap: () {
                // Handle Home navigation
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Categories'),
              onTap: () {
                // Handle Categories navigation
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Cart'),
              onTap: () {
                // Handle Cart navigation
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                // Handle Profile navigation
                Navigator.pushNamed(context, AppRoutes.profile);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
              ),
              items: productImages.map((item) => Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(item),
                    fit: BoxFit.cover,
                  ),
                ),
              )).toList(),
            ),
            SizedBox(height: 10),
            Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        _onCategoryTapped(index);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedCategoryIndex == index
                            ? Color(0xFFCF0EBE)
                            : Colors.grey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            categoryIcons[index],
                            color: _selectedCategoryIndex == index ? Colors.white : Colors.black,
                          ),
                          SizedBox(width: 5),
                          Text(
                            categories[index],
                            style: TextStyle(
                              color: _selectedCategoryIndex == index ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: productImages.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(8),
                            ),
                            child: Image.network(
                              productImages[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          child: Text(
                            "Product ${index + 1}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${(index + 1) * 10.0} €",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Color(0xFFCF0EBE),
                                ),
                              ),
                              Icon(
                                Icons.shopping_cart,
                                color: Colors.black,
                                size: 23,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Color(0xFFCF0EBE),
        selectedItemColor: Color(0xFFCF0EBE),
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
