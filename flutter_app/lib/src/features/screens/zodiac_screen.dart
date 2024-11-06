// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_app/src/features/widgets/my_app_drawer.dart';

class ZodiacScreen extends StatelessWidget {
  final Map<String, Map<String, dynamic>> zodiacInfo = {
    "Aries": {
      "elemento": "Fuego",
      "color": Colors.red,
      "icon": Icons.whatshot,
    },
    "Tauro": {
      "elemento": "Tierra",
      "color": Colors.green,
      "icon": Icons.landscape,
    },
    "Géminis": {
      "elemento": "Aire",
      "color": Colors.yellow,
      "icon": Icons.people,
    },
    "Cáncer": {
      "elemento": "Agua",
      "color": Colors.blue,
      "icon": Icons.water_drop,
    },
    "Leo": {
      "elemento": "Fuego",
      "color": Colors.orange,
      "icon": Icons.pets,
    },
    "Virgo": {
      "elemento": "Tierra",
      "color": Colors.brown,
      "icon": Icons.spa,
    },
    "Libra": {
      "elemento": "Aire",
      "color": Colors.pink,
      "icon": Icons.balance,
    },
    "Escorpio": {
      "elemento": "Agua",
      "color": Colors.purple,
      "icon": Icons.dark_mode,
    },
    "Sagitario": {
      "elemento": "Fuego",
      "color": Colors.deepOrange,
      "icon": Icons.arrow_forward,
    },
    "Capricornio": {
      "elemento": "Tierra",
      "color": Colors.grey,
      "icon": Icons.terrain,
    },
    "Acuario": {
      "elemento": "Aire",
      "color": Colors.lightBlue,
      "icon": Icons.waves,
    },
    "Piscis": {
      "elemento": "Agua",
      "color": Colors.teal,
      "icon": Icons.water,
    },
  };

  String _getZodiacSign(DateTime date) {
    int month = date.month;
    int day = date.day;
    
    if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) return "Aries";
    if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) return "Tauro";
    if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) return "Géminis";
    if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) return "Cáncer";
    if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) return "Leo";
    if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) return "Virgo";
    if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) return "Libra";
    if ((month == 10 && day >= 23) || (month == 11 && day <= 21)) return "Escorpio";
    if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) return "Sagitario";
    if ((month == 12 && day >= 22) || (month == 1 && day <= 19)) return "Capricornio";
    if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) return "Acuario";
    return "Piscis";
  }

  void _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      String zodiacSign = _getZodiacSign(picked);
      _showZodiacDialog(context, zodiacSign, picked);
    }
  }

  void _showZodiacDialog(BuildContext context, String zodiacSign, DateTime date) {
    final zodiacData = zodiacInfo[zodiacSign]!;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  zodiacData['color'].withOpacity(0.2),
                  Colors.white,
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  zodiacData['icon'],
                  size: 50,
                  color: zodiacData['color'],
                ),
                SizedBox(height: 20),
                Text(
                  zodiacSign,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Elemento: ${zodiacData['elemento']}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Fecha de nacimiento:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  '${date.day}/${date.month}/${date.year}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 25),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: zodiacData['color'],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                  child: Text(
                    "Cerrar",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyAppDrawer(),
      appBar: AppBar(
        title: Text('Zodiaco'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.withOpacity(0.2),
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: Column(
                  children: const [
                    Icon(
                      Icons.stars,
                      size: 80,
                      color: Colors.blue,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Descubre tu Signo Zodiacal',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Conoce tu signo y elemento basado en tu fecha de nacimiento',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Selecciona tu fecha de nacimiento',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton.icon(
                          icon: Icon(Icons.calendar_today, color: Colors.white,),
                          label: Text('Seleccionar Fecha',
                          style: TextStyle(color: Colors.white),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 15,
                            ),
                          ),
                          onPressed: () => _showDatePicker(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}