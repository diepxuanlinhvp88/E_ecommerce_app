import 'package:flutter/material.dart';
import 'package:untitled/core/app_export.dart';
import 'package:untitled/model/user.dart';
import 'package:untitled/services/Database/user_service.dart';
import 'package:untitled/widgets/custom_elevated_button.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileService profileService;
  late final userId;

  // final userId = AuthService().getCurrentUser()!.uid;
  late CustomUser userProfile;

  @override
  void initState() {
    super.initState();
    profileService = ProfileService();
    userId = AuthService().getCurrentUser()!.uid;
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    final profile = await profileService.getUserProfile(userId);
    setState(() {
      userProfile = profile!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: LightCodeColors().deepPurpleA200,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.homeScreen);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: userProfile == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(userProfile.avatar_link ??
                  'https://m.media-amazon.com/images/I/41V5FtEWPkL._SX300_SY300_QL70_FMwebp_.jpg'),
            ),
            SizedBox(height: 16),
            _buildProfileField(
              'Name',
              userProfile.name!,
              (value) => userProfile.name = value,
            ),
            _buildProfileField(
              'Email',
              userProfile.email!,
              (value) => userProfile.email = value,
            ),
            _buildProfileField(
              'Phone',
              userProfile.phone!,
              (value) => userProfile.phone = value,
            ),
            _buildProfileField(
              'Address',
              userProfile.address!,
              (value) => userProfile.address = value,
            ),
            _buildRoleField(),
            CustomElevatedButton(
                text: userProfile.isSeller! ? 'View store' : 'Create store',
                onPressed: userProfile.isSeller! ? _viewStore : _createStore),
            SizedBox(
              height: 16,
            ),
            CustomElevatedButton(
              text: 'Update profile',
              onPressed: () {
                // profileService.createUserProfile(CustomUser(
                //     uid: userId,
                //     name: "linh",
                //     email: 'diepxuanlinhvp88',
                //     phone: '0358',
                //     address: 'Ha Noi',
                //     isSeller: false));

                profileService.updateUserProfile(userId, userProfile.toMap());
                try {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Profile updated successfully!')),
                  );
                }
                catch(e){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to update profile.')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _viewStore() {}

  void _createStore() {}

  Widget _buildProfileField(
      String label, String initialValue, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildRoleField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: userProfile.isSeller! ? 'Seller' : 'Buyer',
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'Role',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
