import 'package:flutter/material.dart';
import 'profile_page.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(), // Changed the initial route to HomePage
    theme: ThemeData(
      scaffoldBackgroundColor: Colors.transparent,
    ),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List App'),
      ),
      body: Container(
        color: Colors.teal[100], // Soft turquoise background color
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/cartoon_girl.jpg',
                      width: 80,
                      height: 80,
                    ),
                    SizedBox(width: 16.0),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Good Morning, Nur',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Do the best you can today.',
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GridView.count(
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                shrinkWrap: true,
                children: [
                  CategoryCard(
                    title: 'Study Challenges',
                    imageAsset: 'assets/study_challenges.jpg',
                  ),
                  CategoryCard(
                    title: 'Self Care',
                    imageAsset: 'assets/self_care.jpg',
                  ),
                  CategoryCard(
                    title: 'Future',
                    imageAsset: 'assets/future.jpg',
                  ),
                  CategoryCard(
                    title: 'Wedding Dreams',
                    imageAsset: 'assets/wedding_dreams.jpg',
                  ),
                  CategoryCard(
                    title: 'Happiness',
                    imageAsset: 'assets/happiness.jpg',
                  ),
                  CategoryCard(
                    title: 'Productivity',
                    imageAsset: 'assets/productivity.jpg',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Task',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileDisplayPage(
                  userProfile: UserProfile(
                    name: 'BCS_Student_01',
                    email: '01std@gmail.com',
                    bio: 'Hello, I am students_01 studying MAD.',
                    profileImage: 'https://cdn.pixabay.com/photo/2023/06/16/11/47/books-8067850_1280.jpg',
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String imageAsset;

  const CategoryCard({
    required this.title,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageAsset,
              width: 80,
              height: 80,
            ),
            SizedBox(height: 16.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
