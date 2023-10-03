import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_131_flutterfire/firebase_options.dart';
import 'package:firebase_131_flutterfire/note_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FirebaseFirestore db;

  @override
  void initState() {
    super.initState();
    db = FirebaseFirestore.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: FutureBuilder(
        future: db.collection("notes").get(),
        builder: (_, snapshot){

          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          } else if(snapshot.hasError){

          } else if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
                itemBuilder: (_, index){
                var model = NoteModel.fromJson(snapshot.data!.docs[index].data());
              return ListTile(
                title: Text('${model.title}'),
                subtitle: Text('${model.body}'),
              );
            });
          }


          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          //add
          /*db.collection("students").add({
            "name": "Rajveer",
            "class": "X",
            "rollno": 12345
          }).then((value){
            print(value.id);

          });*/

          db
              .collection("notes")
              .add(NoteModel(title: "Flutter", body: "My First Firebase app")
                  .toJson())
              .then((value) {
            print(value.id);
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
