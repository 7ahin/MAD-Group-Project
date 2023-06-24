//profile display page 
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile_edit_page.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(
    home: ProfileDisplayPage(
      userProfile: UserProfile(
        name: 'BCS_Student_01',
        email: '01std@gmail.com',
        bio: 'Hello, I am students_01 studying MAD.',
        profileImage:
            'https://cdn.pixabay.com/photo/2023/06/16/11/47/books-8067850_1280.jpg',         //The use of HTTP library for fetching data/img online
      ),
    ),
    theme: ThemeData(
      scaffoldBackgroundColor: Colors.transparent,
    ),
  ));
}

class UserProfile {
  String name;
  String email;
  String bio;
  String profileImage;

  UserProfile({
    required this.name,
    required this.email,
    required this.bio,
    required this.profileImage,
  });
}

class ProfileDisplayPage extends StatefulWidget {
  final UserProfile userProfile;

  const ProfileDisplayPage({Key? key, required this.userProfile})
      : super(key: key);

  @override
  _ProfileDisplayPageState createState() => _ProfileDisplayPageState();
}

class _ProfileDisplayPageState extends State<ProfileDisplayPage> {
  late UserProfile _userProfile;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    //to make sure that the changes are displayed in the profile pg even after naviagte to homepg or create task pg
    setState(() {
      _userProfile = UserProfile(
        name: prefs.getString('name') ?? widget.userProfile.name,
        email: prefs.getString('email') ?? widget.userProfile.email,
        bio: prefs.getString('bio') ?? widget.userProfile.bio,
        profileImage: prefs.getString('profileImageUrl') ??
            widget.userProfile.profileImage,
      );
    });
  }

  Future<void> _updateUserProfile(UserProfile updatedProfile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', updatedProfile.name);
    await prefs.setString('email', updatedProfile.email);
    await prefs.setString('bio', updatedProfile.bio);
    await prefs.setString('profileImage', updatedProfile.profileImage);

    setState(() {
      _userProfile = updatedProfile;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_userProfile == null) {
      return Container(
        color: Colors.white,
        child: const Center(
          child:
              CircularProgressIndicator(), // show that the image is loading
        ),
      );
    }

    return Container(
      color: Colors.tealAccent,
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 30.0), // Add a gap of 24.0 units
                const Text(
                  'MY PROFILE PAGE',
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Times New Roman',
                      fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 24.0), // Add a gap of 24.0 units
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(),
                          body: Container(
                            child: PhotoView(
                              imageProvider:
                                  NetworkImage(_userProfile.profileImage),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 64.0,
                    backgroundImage: NetworkImage(_userProfile.profileImage),
                    child: _userProfile.profileImage.isEmpty
                        ? const Icon(
                            Icons.person,
                            size: 64.0,
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Name: \n${_userProfile.name}',
                    style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Times New Roman',
                        color: Colors.black),
                  ),
                ),
                const SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email: \n${_userProfile.email}',
                    style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Times New Roman',
                        color: Colors.black),
                  ),
                ),
                const SizedBox(height: 16.0),
                const SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'About Me: \n${_userProfile.bio}',
                    style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Times New Roman',
                        color: Colors.black),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.grey),
                  ),
                  onPressed: () async {
                    final updatedProfile = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileEditPage(
                          userProfile: _userProfile,
                          updateUserProfile: (UserProfile) {},
                        ),
                      ),
                    );
                    if (updatedProfile != null) {
                      _updateUserProfile(updatedProfile);
                    }
                  },
                  child: const Text('Edit Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
