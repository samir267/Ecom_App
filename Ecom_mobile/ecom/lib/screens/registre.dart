import 'package:ecom/models/user_model.dart';
import 'package:ecom/routes/app_routes.dart';
import 'package:ecom/services/api_service.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final ApiService _apiService = ApiService(); // Instance de votre service API

  Future<void> _signup() async {
    final user = UserModel(
       id: 1,// ou générer un ID si nécessaire
      username: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      address: _addressController.text,
      phone: _phoneController.text,
    );

    final UserModel? registeredUser = await _apiService.registerUser(user);

    if (registeredUser != null) {
      // Inscription réussie
      _usernameController.clear();
      _emailController.clear();
      _passwordController.clear();
      _addressController.clear();
      _phoneController.clear();
      Navigator.pushNamed(context, AppRoutes.login);
    } else {
      _showErrorDialog('Failed to sign up. Please try again.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An error occurred!'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, IconData icon, {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        fillColor: Colors.purple.withOpacity(0.1),
        filled: true,
        prefixIcon: Icon(icon),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const SizedBox(height: 60.0),
                    const Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Create your account",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    _buildTextField(_usernameController, "Username", Icons.person),
                    const SizedBox(height: 20),
                    _buildTextField(_emailController, "Email", Icons.email),
                    const SizedBox(height: 20),
                    _buildTextField(_passwordController, "Password", Icons.password, obscureText: true),
                    const SizedBox(height: 20),
                    _buildTextField(_addressController, "Address", Icons.location_on),
                    const SizedBox(height: 20),
                    _buildTextField(_phoneController, "Phone number", Icons.phone, obscureText: true),
                  ],
                ),
                ElevatedButton(
                  onPressed: _signup,
                  child: const Text(
                    "Sign up",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.purple,
                  ),
                ),
                const Center(child: Text("Or")),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.purple),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Logic for Google authentication
                    },
                    child: const Text(
                      "Sign up with Google",
                      style: TextStyle(color: Colors.purple, fontSize: 15),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.login);
                      },
                      child: const Text(
                        "Log in",
                        style: TextStyle(color: Colors.purple),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
