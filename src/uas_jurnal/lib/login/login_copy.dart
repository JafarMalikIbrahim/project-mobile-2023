// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:uas_jurnal/pages/view.dart';
// import '../login/first_screen.dart';
// import '../services/firebase_sign_in.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/log.jpg'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Image.asset(
//                 'assets/logo1.png',
//                 width: 200,
//                 height: 200,
//               ),
//               const SizedBox(height: 1),
//               const Text(
//                 'DEATH NOTE', // Judul teks yang ditambahkan
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   fontFamily:
//                       'BatikRegular', // Menggunakan font dengan motif batik
//                   letterSpacing: 2.0, // Menambahkan spasi antar huruf
//                 ),
//               ),
//               const SizedBox(height: 10),
//               _signInButton(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _signInButton() {
//     return OutlinedButton(
//       onPressed: () {
//         signInWithGoogle().then((result) {
//           if (result != null) {
//             Navigator.of(context).push(
//               MaterialPageRoute(builder: (context) {
//                 return HomePage();
//               }),
//             );
//           }
//         });
//       },
//       style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
//         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//           RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(40),
//           ),
//         ),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
//             child: Image.asset(
//               'assets/google.png',
//               height: 40,
//               width: 40,
//             ),
//           ),
//           const Padding(
//             padding: EdgeInsets.all(10.0),
//             child: Text(
//               'Login with Google',
//               style: TextStyle(color: Colors.black),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

