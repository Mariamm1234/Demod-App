
import 'package:demod/components/button.dart';
import 'package:flutter/material.dart';

class Intro extends StatelessWidget{
  const Intro({super.key});
  @override
  Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Theme.of(context).colorScheme.surfaceBright,
body: Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      //logo
      Icon(
        Icons.shopping_bag,
        size: 72,
        color: Theme.of(context).colorScheme.inversePrimary,
      ),

      const SizedBox(height: 25),

   const   Text("demod",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24
      ),
      ),

      const SizedBox(height: 10),

       Text("Premium quality",
      style: TextStyle(
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      ),

      const SizedBox(height: 25),

       Button(
        onTap:()=>Navigator.pushNamed(context,'/login'),
        child: const Icon(Icons.arrow_forward),
      ),
    ],
  ),
),

);
  }
  
}