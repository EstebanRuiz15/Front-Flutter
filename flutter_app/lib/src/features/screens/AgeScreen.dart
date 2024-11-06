// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_app/src/features/widgets/my_app_drawer.dart';
import 'package:intl/intl.dart';

class AgeScreen extends StatefulWidget {
  @override
  AgeScreenState createState() => AgeScreenState();
}

class AgeScreenState extends State<AgeScreen> with SingleTickerProviderStateMixin {
  DateTime? _selectDate;
  int? _age;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectDate = pickedDate;
        _age = _calculateAge(pickedDate);
        _showAgeDialog(_age!);
      });
    });
  }

  int _calculateAge(DateTime birthDay) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDay.year;
    if (currentDate.month < birthDay.month ||
        (currentDate.month == birthDay.month && currentDate.day < birthDay.day)) {
      age--;
    }
    return age;
  }

  void _showAgeDialog(int age) {
    _controller.reset();
    _controller.forward();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ScaleTransition(
          scale: _animation,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.white,
            content: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.cake,
                    size: 50,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "¡Tu edad es de",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "$age años!",
                    style: const TextStyle(
                      fontSize: 36,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Naciste hace ${age * 12} meses\n"
                    "o ${age * 365} días aproximadamente",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
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
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue,
              Colors.blue.shade50,
            ],
          ),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: const [
                  Icon(
                    Icons.calendar_today,
                    size: 60,
                    color: Colors.white,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Calcula tu edad exacta',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Selecciona tu fecha de nacimiento\npara descubrir tu edad precisa',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: InkWell(
                        onTap: _presentDatePicker,
                        borderRadius: BorderRadius.circular(15),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Icon(
                                Icons.date_range,
                                size: 40,
                                color: Colors.blue.shade300,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _selectDate == null
                                    ? 'Toca para seleccionar fecha'
                                    : 'Fecha: ${DateFormat('dd/MM/yyyy').format(_selectDate!)}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (_selectDate != null) ...[
                      const SizedBox(height: 20),
                      TextButton.icon(
                        icon: const Icon(Icons.refresh),
                        label: const Text('Cambiar fecha'),
                        onPressed: _presentDatePicker,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}