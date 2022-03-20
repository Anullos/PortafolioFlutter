import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: ListView(
        children: <Widget>[
          // header
          UserAccountsDrawerHeader(
            otherAccountsPictures: <Widget>[
              GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  backgroundColor: Colors.blue.shade300,
                  child: Icon(Icons.home, color: Colors.white),
                ),
              ),
            ],
            accountName: Text('Daniel Aranda Maestro'),
            accountEmail: Text('info@anullos.es'),
            currentAccountPicture: GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                backgroundColor: Colors.blue.shade300,
                //    child: (_me.data.avatar != null)
                child: Image.asset(
                  'assets/dani.png',
                  scale: 1.5,
                  fit: BoxFit.contain,
                ),
                //   : Icon(Icons.add,size: 50,),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          // body
          ListaTitulos(
            onTap: () {},
            titulo: "Demostraciones",
            icono: Icons.home,
            iconoColor: Colors.blue,
          ),
          ListaTitulos(
            onTap: () {},
            titulo: "Animaciones",
            icono: Icons.people,
            iconoColor: Colors.blue,
          ),
          ListaTitulos(
            onTap: () {},
            titulo: "Gestores de estado",
            icono: Icons.pie_chart,
            iconoColor: Colors.blue,
          ),
          ListaTitulos(
            onTap: () {},
            titulo: "Navegaciones",
            icono: Icons.library_books,
            iconoColor: Colors.blue,
          ),
          SizedBox(
            height: 50,
          ),
          Divider(),
          ListaTitulos(
            onTap: () {},
            titulo: "Settings",
            icono: Icons.settings,
            iconoColor: Colors.grey,
          ),
          ListaTitulos(
            onTap: () {},
            titulo: "About",
            icono: Icons.help,
            iconoColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}

class ListaTitulos extends StatelessWidget {
  final VoidCallback onTap;
  final String titulo;
  final IconData icono;
  final MaterialColor iconoColor;

  ListaTitulos(
      {required this.onTap,
      required this.titulo,
      required this.icono,
      required this.iconoColor});
      
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        title: Text(titulo),
        leading: Icon(
          icono,
          color: iconoColor,
        ),
      ),
    );
  }
}
