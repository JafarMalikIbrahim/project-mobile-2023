// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:uas_jurnal/login/login.dart';
// import '../services/firebase_auth.dart';

// class Signup extends StatelessWidget {
//   const Signup({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             Icons.arrow_back_ios,
//             size: 20,
//             color: Colors.black,
//           ),
//         ),
//         systemOverlayStyle: SystemUiOverlayStyle.dark,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16.0),
//         children: <Widget>[
//           const SizedBox(height: 5),
//           // logo
//           Column(
//             children: <Widget>[
//               const Text(
//                 "Sign up",
//                 style: TextStyle(
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 "Daftar akun aplikasi ",
//                 style: TextStyle(fontSize: 15, color: Colors.grey[700]),
//               )
//             ],
//           ),
//           const SizedBox(height: 20),

//           const Padding(
//             padding: EdgeInsets.all(8.0),
//             child: SignupForm(),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     const Text('Sudah Punya Akun ?',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 15)),
//                     GestureDetector(
//                       onTap: () {},
//                       child: const Text(' Login !',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 15,
//                               color: Colors.blue)),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Container buildLogo() {
//     return Container(
//       height: 80,
//       width: 80,
//       decoration: const BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(10)),
//           color: Colors.blue),
//       child: const Center(
//         child: Text(
//           "T",
//           style: TextStyle(color: Colors.white, fontSize: 60.0),
//         ),
//       ),
//     );
//   }
// }

// class SignupForm extends StatefulWidget {
//   const SignupForm({Key? key}) : super(key: key);

//   @override
//   _SignupFormState createState() => _SignupFormState();
// }

// class _SignupFormState extends State<SignupForm> {
//   final _formKey = GlobalKey<FormState>();

//   String? email;
//   String? password;
//   String? name;
//   bool _obscureText = false;

//   bool agree = false;

//   final pass = new TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     var border = const OutlineInputBorder(
//       borderRadius: BorderRadius.all(
//         Radius.circular(100.0),
//       ),
//     );

//     var space = const SizedBox(height: 10);
//     return Form(
//       key: _formKey,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           // email
//           TextFormField(
//             decoration: InputDecoration(
//                 prefixIcon: const Icon(Icons.email_outlined),
//                 labelText: 'Email',
//                 border: border),
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Please enter some text';
//               }
//               return null;
//             },
//             onSaved: (val) {
//               email = val;
//             },
//             keyboardType: TextInputType.emailAddress,
//           ),

//           space,

//           // password
//           TextFormField(
//             controller: pass,
//             decoration: InputDecoration(
//               labelText: 'Password',
//               prefixIcon: const Icon(Icons.lock_outline),
//               border: border,
//               suffixIcon: GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     _obscureText = !_obscureText;
//                   });
//                 },
//                 child: Icon(
//                   _obscureText ? Icons.visibility_off : Icons.visibility,
//                 ),
//               ),
//             ),
//             onSaved: (val) {
//               password = val;
//             },
//             obscureText: !_obscureText,
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Please enter some text';
//               }
//               return null;
//             },
//           ),
//           space,
//           // confirm passwords
//           TextFormField(
//             decoration: InputDecoration(
//               labelText: 'Confirm Password',
//               prefixIcon: const Icon(Icons.lock_outline),
//               border: border,
//             ),
//             obscureText: true,
//             validator: (value) {
//               if (value != pass.text) {
//                 return 'password not match';
//               }
//               return null;
//             },
//           ),
//           space,
//           // name
//           TextFormField(
//             decoration: InputDecoration(
//               labelText: 'Full name',
//               prefixIcon: const Icon(Icons.account_circle),
//               border: border,
//             ),
//             onSaved: (val) {
//               name = val;
//             },
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Please enter some name';
//               }
//               return null;
//             },
//           ),

//           Row(
//             children: <Widget>[
//               Checkbox(
//                 onChanged: (_) {
//                   setState(() {
//                     agree = !agree;
//                   });
//                 },
//                 value: agree,
//               ),
//               const Flexible(
//                 child: Text(
//                     'By creating account, I agree to Terms & Conditions and Privacy Policy.'),
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 10,
//           ),

//           // signUP button
//           SizedBox(
//             height: 50,
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: () {
//                 if (_formKey.currentState!.validate()) {
//                   _formKey.currentState!.save();

//                   AuthenticationHelper()
//                       .signUp(email: email!, password: password!)
//                       .then((result) {
//                     if (result == null) {
//                       Navigator.pushReplacement(context,
//                           MaterialPageRoute(builder: (context) => LoginPage()));
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                         content: Text(
//                           result,
//                           style: const TextStyle(fontSize: 16),
//                         ),
//                       ));
//                     }
//                   });
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                   shape: const RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(24.0)))),
//               child: const Text('Sign Up'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
