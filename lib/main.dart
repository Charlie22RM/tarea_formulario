import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(FormularioApp());
}

class FormularioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulario App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FormularioScreen(),
    );
  }
}

class FormularioScreen extends StatefulWidget {
  @override
  _FormularioScreenState createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fechaController = TextEditingController();
  late DateTime _selectedDate;
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  String _nacionalidad = '';
  List<String> _hobbies = [];

  @override
  void dispose() {
    _fechaController.dispose();
    _nombreController.dispose();
    _telefonoController.dispose();
    _contrasenaController.dispose();
    super.dispose();
  }

  void _showDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _fechaController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  void _mostrarDatosIngresados() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Datos ingresados'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Nombre: ${_nombreController.text}'),
                Text('Teléfono: ${_telefonoController.text}'),
                Text('Contraseña: ${_contrasenaController.text}'),
                Text('Nacionalidad: $_nacionalidad'),
                Text('Hobbies: ${_hobbies.join(", ")}'),
                Text('Fecha de Nacimiento: ${_fechaController.text}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  void _borrarCampos() {
    setState(() {
      _formKey.currentState!.reset();
      _fechaController.clear();
      _nombreController.clear();
      _telefonoController.clear();
      _contrasenaController.clear();
      _nacionalidad = '';
      _hobbies.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de Ingreso'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nombreController,
                  decoration: const InputDecoration(labelText: 'Usuario'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingresa tu usuario';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _contrasenaController,
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingresa tu contraseña';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _telefonoController,
                  decoration: const InputDecoration(labelText: 'Teléfono'),
                  keyboardType: TextInputType.phone,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingresa tu número de teléfono';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                const Text('Nacionalidad', style: TextStyle(fontSize: 16.0)),
                RadioListTile(
                  title: const Text('Ecuador'),
                  value: 'Ecuador',
                  groupValue: _nacionalidad,
                  onChanged: (value) {
                    setState(() {
                      _nacionalidad = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('Colombia'),
                  value: 'Colombia',
                  groupValue: _nacionalidad,
                  onChanged: (value) {
                    setState(() {
                      _nacionalidad = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('México'),
                  value: 'México',
                  groupValue: _nacionalidad,
                  onChanged: (value) {
                    setState(() {
                      _nacionalidad = value.toString();
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                const Text('Hobbies', style: TextStyle(fontSize: 16.0)),
                CheckboxListTile(
                  title: const Text('Escuchar música'),
                  value: _hobbies.contains('Escuchar música'),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        _hobbies.add('Escuchar música');
                      } else {
                        _hobbies.remove('Escuchar música');
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Ver películas'),
                  value: _hobbies.contains('Ver películas'),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        _hobbies.add('Ver películas');
                      } else {
                        _hobbies.remove('Ver películas');
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Jugar videojuegos'),
                  value: _hobbies.contains('Jugar videojuegos'),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        _hobbies.add('Jugar videojuegos');
                      } else {
                        _hobbies.remove('Jugar videojuegos');
                      }
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                GestureDetector(
                  onTap: _showDatePicker,
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: _fechaController,
                      decoration: const InputDecoration(
                        labelText: 'Fecha de Nacimiento',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, ingresa tu fecha de nacimiento';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                     child: ElevatedButton(
                        onPressed: _mostrarDatosIngresados,
                        child: const Text('Aceptar'),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _borrarCampos,
                        child: const Text('Borrar'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
