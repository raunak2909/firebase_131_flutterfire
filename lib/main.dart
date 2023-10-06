import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_131_flutterfire/firebase_options.dart';
import 'package:firebase_131_flutterfire/note_model.dart';
import 'package:firebase_131_flutterfire/user_page.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: UserPage(),
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
  var titleController = TextEditingController();
  var bodyController = TextEditingController();

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
      body: StreamBuilder(
        stream: db.collection("notes").snapshots(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
          } else if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (_, index) {
                  var model =
                      NoteModel.fromJson(snapshot.data!.docs[index].data());
                  model.id = snapshot.data!.docs[index].id;
                  print("id: ${model.id}");
                  return InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (_) {
                            print(MediaQuery.of(context).viewInsets.bottom);
                            titleController.text = model.title!;
                            bodyController.text = model.body!;
                            return Container(
                              height:
                                  MediaQuery.of(context).viewInsets.bottom ==
                                          0.0
                                      ? 400
                                      : 800,
                              color: Colors.blue.shade100,
                              child: Column(
                                children: [
                                  Text('Add Note'),
                                  TextField(
                                    controller: titleController,
                                    onTap: () {},
                                    decoration: InputDecoration(
                                        label: Text('Title'),
                                        hintText: "Enter title here..",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(21))),
                                  ),
                                  TextField(
                                    controller: bodyController,
                                    decoration: InputDecoration(
                                        label: Text('Body'),
                                        hintText: "Write Desc here..",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(21))),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        //update

                                        db
                                            .collection("notes")
                                            .doc(model.id)
                                            .set(NoteModel(
                                                    title: titleController.text
                                                        .toString(),
                                                    body: bodyController.text
                                                        .toString())
                                                .toJson())
                                            .then((value) {});
                                      },
                                      child: Text('Update'))
                                ],
                              ),
                            );
                          });
                    },
                    child: ListTile(
                      title: Text('${model.title}'),
                      subtitle: Text('${model.body}'),
                      trailing: InkWell(
                          onTap: () {
                            //delete
                            db
                                .collection("notes")
                                .doc(model.id)
                                .delete()
                                .then((value) => print("${model.id} deleted"));
                          },
                          child: Icon(Icons.delete)),
                    ),
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

          showModalBottomSheet(
              context: context,
              builder: (_) {
                print(MediaQuery.of(context).viewInsets.bottom);
                return Container(
                  height: MediaQuery.of(context).viewInsets.bottom == 0.0
                      ? 400
                      : 800,
                  color: Colors.blue.shade100,
                  child: Column(
                    children: [
                      Text('Add Note'),
                      TextField(
                        controller: titleController,
                        onTap: () {},
                        decoration: InputDecoration(
                            label: Text('Title'),
                            hintText: "Enter title here..",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(21))),
                      ),
                      TextField(
                        controller: bodyController,
                        decoration: InputDecoration(
                            label: Text('Body'),
                            hintText: "Write Desc here..",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(21))),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            db
                                .collection("notes")
                                .add(NoteModel(
                                        title: titleController.text.toString(),
                                        body: bodyController.text.toString())
                                    .toJson())
                                .then((value) {
                              print(value.id);
                            });
                          },
                          child: Text('Submit'))
                    ],
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

//FutureBuilder(
//         future: db.collection("notes").get(),
//         builder: (_, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//           } else if (snapshot.hasData) {
//             return ListView.builder(
//                 itemCount: snapshot.data!.docs.length,
//                 itemBuilder: (_, index) {
//                   var model =
//                       NoteModel.fromJson(snapshot.data!.docs[index].data());
//                   return ListTile(
//                     title: Text('${model.title}'),
//                     subtitle: Text('${model.body}'),
//                   );
//                 });
//           }
//
//           return Container();
//         },
//       ),
