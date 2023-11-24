import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller=TextEditingController();
  
  //SnackBar get snackBar => null;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
           const SizedBox(height: 70,),
          const Center(
            child: Text('Generate Strong Password',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
              ),
              ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                readOnly: true,
                controller: _controller,
                decoration:  InputDecoration(
                  suffix: IconButton(
                    onPressed: (){ 
                      final data=ClipboardData(text: _controller.text);
                      Clipboard.setData(data);

                      final snackBar=const SnackBar(
                        content: Text(
                          "Password Copied",
                      style: TextStyle(
                        fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: Colors.pink,
                      );

                      ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(snackBar);
                    }, 
                    icon: const Icon(Icons.copy)),
                  label: const Text('Password')
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Center(
            child: ElevatedButton(
              onPressed: (){
                _controller.text=_generateStrongPassword();
              },
               child: const Text('Generate')
               ),
          )
        ],
      ),
    );
  }

  String _generateStrongPassword(){
  String lowercase="abcdefghijklmnopqrstuvwxyz";
  String uppercase="ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  String symbol="~!@#\$^&*()_-+=<:"";>,./?'|";
  String number="0123456789";

  String StrongPassword="$lowercase$uppercase$symbol$number";

  return List.generate(20, (index) {
    int randomIndex=Random.secure().nextInt(StrongPassword.length);
    return StrongPassword[randomIndex];
  }).join('');
}
}