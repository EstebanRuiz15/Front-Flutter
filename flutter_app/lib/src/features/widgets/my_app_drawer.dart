import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyAppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[Container(
            height: 150, 
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'My Health App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: const Color.fromARGB(240, 0, 25, 46)),
            title: Text('Home',
            style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold)
            ),
            onTap: () {
              Navigator.pop(context);
              context.go('/');
            },
          ),
          ListTile(
            leading: Icon(Icons.cake, color: const Color.fromARGB(237, 255, 153, 0)),
            title: Text('Age calculator',
            style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold)
            ),
            onTap: () {
              Navigator.pop(context);
              context.go('/age');

            },
          ),
          ListTile(
            leading: Icon(Icons.scale, color: const Color.fromARGB(235, 43, 206, 48)),
            title: Text('Bmi calculator',
            style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold)
            ),
            onTap: () {
              Navigator.pop(context);
              context.go('/bmi');
            },
          ),
          ListTile(
            leading: Icon(Icons.star,color: const Color.fromARGB(234, 155, 39, 176)),
            title: Text('Zodiac calculator',
            style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold)
            ),
            onTap: () {
              Navigator.pop(context);
              context.go('/zodiac');
            },
          ),
        ],
      ),
    );
  }
}
