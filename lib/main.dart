import 'package:connect/models/contacts.dart';

import 'package:connect/pages/add_post.dart';
import 'package:connect/pages/post.dart';
import 'package:connect/services/authentication_service.dart';
import 'package:connect/services/upload_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Import the generated file
//import 'firebase_options.dart';

import 'pages/sign_in_page.dart';
import 'services/download_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyCpBGZylbeUOb50CqSsDdjd-yh6mIi8WVc',
          appId: 'com.social.connect',
          messagingSenderId: 'messagingSenderId',
          projectId: 'social-media-demo-cf706.appspot.com'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  //
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //custom mine*****************/

    //******************my code */
//    return MultiProvider(
//       //provider paer to remove return directly child:material remove multiprov

//       providers: [
//         ChangeNotifierProvider<AuthenticationService>(
//             create: (context) => AuthenticationService(FirebaseAuth.instance)),
//         Provider<UploadService>(create: (context) => UploadService()),
//         Provider<DownloadService>(create: (context) => DownloadService()),
//         Provider<Contact>(
//           create: (context) => Contact(),
//         ),
//         StreamProvider<User?>(
//           create: (context) =>
//               context.read<AuthenticationService>().authStateChanges,
//           initialData: null,
//         ),
//       ],
//       //end of provider
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Flutter Database',
//         theme: ThemeData(
//           primaryColor: Colors.deepPurple,
//           // accentColor: Colors.red[100];
//         ),
//         home: Post(),
//       ),
//     );
//   }
// }

    //custom mine************************

    //theam related start

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationService>(
            create: (context) => AuthenticationService(FirebaseAuth.instance)),
        Provider<UploadService>(create: (context) => UploadService()),
        Provider<DownloadService>(create: (context) => DownloadService()),
        Provider<Contact>(
          create: (context) => Contact(),
        ),
        StreamProvider<User?>(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          // fontFamily:
        ),
        home: Consumer<User?>(builder: (context, value, child) {
          final firebaseUser = context.watch<User?>();
          if (firebaseUser != null) {
            return const Post();
          } else {
            return const SignIn();
          }
        }),
      ),
    );
  }
}

//therm matter starts
