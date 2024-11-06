// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_app/src/features/widgets/my_app_drawer.dart';

class BmiScreen extends StatefulWidget {
  @override
  BmiScreenState createState() => BmiScreenState();
}

class BmiScreenState extends State<BmiScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  double? _bmi;
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
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _calculateBmi() {
    if (_formKey.currentState!.validate()) {
      final double weight = double.parse(_weightController.text);
      final double height = double.parse(_heightController.text);

      setState(() {
        _bmi = weight / ((height / 100) * (height / 100));
      });

      _showBmiDialog(_bmi!);
    }
  }

  Color _getBmiColor(double bmi) {
    if (bmi < 18.5) return Colors.blue;
    if (bmi >= 18.5 && bmi <= 24.9) return Colors.green;
    if (bmi >= 25 && bmi <= 29.9) return Colors.orange;
    return Colors.red;
  }

  IconData _getBmiIcon(double bmi) {
    if (bmi < 18.5) return Icons.arrow_downward;
    if (bmi >= 18.5 && bmi <= 24.9) return Icons.check_circle;
    if (bmi >= 25 && bmi <= 29.9) return Icons.arrow_upward;
    return Icons.warning;
  }

  String _getBmiCategory(double bmi) {
    if (bmi < 18.5) return 'Bajo peso';
    if (bmi >= 18.5 && bmi <= 24.9) return 'Peso normal';
    if (bmi >= 25 && bmi <= 29.9) return 'Sobrepeso';
    return 'Obesidad';
  }

  void _showBmiDialog(double bmi) {
    _controller.reset();
    _controller.forward();

    final Color bmiColor = _getBmiColor(bmi);
    final IconData bmiIcon = _getBmiIcon(bmi);
    final String category = _getBmiCategory(bmi);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ScaleTransition(
          scale: _animation,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.white,
            content: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    bmiIcon,
                    size: 50,
                    color: bmiColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: bmiColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Tu IMC es',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    bmi.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: bmiColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _getBmiMessage(bmi),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: bmiColor,
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

  String _getBmiMessage(double bmi) {
    if (bmi < 18.5) {
      return 'Considera aumentar tu peso de forma saludable para alcanzar un IMC óptimo.';
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      return '¡Felicitaciones! Mantén tus hábitos saludables.';
    } else if (bmi >= 25 && bmi <= 29.9) {
      return 'Considera adoptar hábitos más saludables para alcanzar un peso óptimo.';
    } else {
      return 'Es importante consultar con un profesional de la salud para establecer un plan saludable.';
    }
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: const [
                    Icon(
                      Icons.monitor_weight,
                      size: 60,
                      color: Colors.white,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Calculadora de IMC',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Calcula tu Índice de Masa Corporal\npara evaluar tu peso',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                padding: const EdgeInsets.all(30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _weightController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Peso (kg)',
                                  prefixIcon: Icon(Icons.fitness_center, color: Colors.blue),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.blue, width: 2),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, ingrese su peso';
                                  }
                                  final double? weight = double.tryParse(value);
                                  if (weight == null || weight <= 0) {
                                    return 'Por favor, ingrese un peso válido';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _heightController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Altura (cm)',
                                  prefixIcon: Icon(Icons.height, color: Colors.blue),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.blue, width: 2),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, ingrese su altura';
                                  }
                                  final double? height = double.tryParse(value);
                                  if (height == null || height <= 0) {
                                    return 'Por favor, ingrese una altura válida';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(225, 66, 141, 253),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 15,
                          ),
                        ),
                        onPressed: _calculateBmi,
                        child: const Text(
                          'Calcular IMC',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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