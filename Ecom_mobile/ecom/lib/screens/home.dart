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
    'https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?cs=srgb&dl=pexels-madebymath-90946.jpg&fm=jpg',
    'https://images.unsplash.com/photo-1523275335684-37898b6baf30?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZHVjdHxlbnwwfHwwfHx8MA%3D%3D',
    'https://images.unsplash.com/photo-1504274066651-8d31a536b11a?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fHByb2R1Y3QlMjBkZXNjcmlwdGlvbnxlbnwwfHwwfHx8MA%3D%3D',
    'https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?cs=srgb&dl=pexels-madebymath-90946.jpg&fm=jpg',
    'https://static.toiimg.com/thumb/msid-88872085,width-400,resizemode-4/88872085.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3hf_7Cw2cK7ZAup3kJGHWuhmCZbH8VfjDu783-s-y2JWAD5_7F4AueFJrIA9zg8UEOpc&usqp=CAU',
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

  // Naviguer vers les pages appropriées
  switch (index) {
    case 0:
      Navigator.pushNamed(context, AppRoutes.home);
      break;
    case 1:
      Navigator.pushNamed(context, AppRoutes.home); // Remplacer par la route des catégories si elle existe
      break;
    case 2:
      Navigator.pushNamed(context, AppRoutes.cartscreen); // Remplacer par la route du panier si elle existe
      break;
    case 3:
      Navigator.pushNamed(context, AppRoutes.profile);
      break;
    default:
      break;
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
backgroundColor: Colors.blue.shade700, // Remplacer la couleur
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
          color: Colors.blue.shade400,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
               "https://i.imgur.com/IXnwbLk.png", // Remplacez par l'URL de l'image de profil.
              ),
            ),
            SizedBox(height: 5),
            Text(
              'John Doe', // Remplacez par le nom de l'utilisateur.
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'johndoe@example.com', // Remplacez par l'email de l'utilisateur.
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      ListTile(
        leading: Icon(Icons.home),
        title: Text('Home'),
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
                            ? Colors.blue.shade400
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
                                  color: Colors.blue.shade700,
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
backgroundColor: Colors.blue.shade400, // Remplacer la couleur
  selectedItemColor: Colors.blue.shade400,
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
