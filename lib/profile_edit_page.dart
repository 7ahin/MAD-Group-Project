//profile edit page
 import 'package:flutter/material.dart';
 import 'profile_page.dart';
 import 'package:image_picker/image_picker.dart';

class ProfileEditPage extends StatefulWidget {
  final UserProfile userProfile;
  final Function(UserProfile) updateUserProfile;

  const ProfileEditPage({
    Key? key,
    required this.userProfile,
    required this.updateUserProfile,
  }) : super(key: key);

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _bioController;
  String _profileImage = '';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userProfile.name);
    _emailController = TextEditingController(text: widget.userProfile.email);
    _bioController = TextEditingController(text: widget.userProfile.bio);
    _profileImage = widget.userProfile.profileImage;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    final updatedProfile = UserProfile(
      name: _nameController.text,
      email: _emailController.text,
      bio: _bioController.text,
      profileImage: _profileImage,
    );

    Navigator.pop(context, updatedProfile);

    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ProfileDisplayPage(userProfile: updatedProfile),
    //   ),
    // );
  }

  // void _editImage() {
  //   setState(() {
  //     _profileImage = 'https://cdn.pixabay.com/photo/2023/06/16/11/47/books-8067850_1280.jpg'; // Replace with your asset image path
  //     //The use of HTTP library for fetching data/img online 
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
          color: Colors.tealAccent,
          // [
          //   hexStringToColor("CB2B93"),
          //   hexStringToColor("9546c4"),
          //   hexStringToColor("5E61F4"),
          // ],
      //     begin: Alignment.topCenter,
      //     end: Alignment.bottomCenter,
      //   ),
      // ),
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 30.0), // Add a gap of 24.0 units
                const Text(
                  'EDIT PROFILE',
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Times New Roman',
                      fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 24.0), // Add a gap of 24.0 units
              GestureDetector(
                onTap: _editImage,
                child: CircleAvatar(
                  radius: 64.0,
                  backgroundImage: NetworkImage(_profileImage),
                    child: _profileImage.isEmpty
                        ? const Icon(
                          Icons.person,
                          size: 64.0,
                        )
                      : null,
                  ),
                ),
              //     backgroundImage: _profileImage.isNotEmpty
              //         ? AssetImage(_profileImage)
              //         : null,
              //     child: _profileImage.isEmpty
              //         ? const Icon(
              //             Icons.person,
              //             size: 64.0,
              //           )
              //         : null,
              //   ),
              // ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email', 
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _bioController,
                decoration: const InputDecoration(
                  labelText: 'About Me',
                ),
                maxLines: null,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.white),
              backgroundColor: MaterialStateProperty.all(Colors.grey),),
                onPressed: _saveChanges,
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _editImage() async {
    // Show a dialog to choose between camera and gallery options
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Image Source'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text('Camera'),
                  onTap: () async {
                    Navigator.pop(context);
                    final image =
                        await ImagePicker().getImage(source: ImageSource.camera);
                    if (image != null) {
                      setState(() {
                        _profileImage = image.path;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                GestureDetector(
                  child: const Text('Gallery'),
                  onTap: () async {
                    Navigator.pop(context);
                    final image = await ImagePicker().getImage(
                        source: ImageSource.gallery);
                    if (image != null) {
                      setState(() {
                        _profileImage = image.path;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}