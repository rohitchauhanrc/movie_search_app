import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text(
          "Profile Page",
          style: GoogleFonts.openSans(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
              const SizedBox(height: 16.0),
              Text(
                "Rohit Chauhan",
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'rohitchauhanreal@gmail.com',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white54,
                ),
              ),
              const SizedBox(height: 24.0),
              Expanded(
                child: ListView(
                  children: [
                    _buildListTile(
                      icon: CupertinoIcons.phone,
                      title: 'Contact Us',
                      onTap: () {
                        _showContactDialog(context);
                      },
                    ),
                    _buildListTile(
                      icon: CupertinoIcons.square_pencil_fill,
                      title: 'Feedback',
                      onTap: () {},
                    ),
                    _buildListTile(
                      icon: CupertinoIcons.settings,
                      title: 'Settings',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      onTap: onTap,
    );
  }

  void _showContactDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Contact Us'),
          content: const Text('Contact +91 6266674959 for any query.'),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }
}
