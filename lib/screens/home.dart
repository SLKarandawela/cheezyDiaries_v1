
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cheezy_diary_recipie_app/loader.dart';
import 'package:cheezy_diary_recipie_app/screens/login.dart';
import '../models/recipies.dart';
import 'package:cheezy_diary_recipie_app/repositories/recipieRepo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController recipieItemController = TextEditingController();
  TextEditingController recipieDescription = TextEditingController();
  TextEditingController recipieIngredients = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Recipe App"),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: const Text("Confirmation Required"),
                      content: const Text("Are you sure to Log-out? "),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: const Text("No"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            FirebaseAuth.instance.signOut();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return const LoginScreen();
                            }));
                          },
                          child: const Text("Yes"),
                        ),
                      ],
                    );
                  });
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder<List<Recipies>>(
            stream: RecipiesRepository().listRecipies(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Loader();
              }
              List<Recipies>? listRecipies = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "All Recipies",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Divider(
                      color: Color.fromARGB(255, 1, 15, 134),
                    ),
                    const SizedBox(height: 20),
                    ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.grey[600],
                      ),
                      shrinkWrap: true,
                      itemCount: listRecipies!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () => {
                            showDialog(
            builder: (context) => SimpleDialog(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 20,
              ),
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Row(
                children: [
                  const Text(
                    "Add Recipie",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.grey,
                      size: 30,
                    ),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
              children: [
                const Divider(),
                TextFormField(
                  controller: recipieItemController,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.5,
                    color: Colors.white,
                  ),
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "Type the recipie here",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                ),
                TextFormField(
                  controller: recipieIngredients,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.5,
                    color: Colors.white,
                  ),
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "Type the ingredients here",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                ),
                TextFormField(
                  controller: recipieDescription,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.5,
                    color: Colors.white,
                  ),
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "type the description here",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                ),
                
                const SizedBox(height: 20),
                SizedBox(
                  width: width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (recipieItemController.text.isNotEmpty) {
                        await RecipiesRepository()
                            .editRecipie(listRecipies[index].id,recipieItemController.text.trim(),recipieDescription.text.trim(),recipieIngredients.text.trim());
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      minimumSize: const Size(60, 60),
                      elevation: 10,
                    ),
                    child: const Text("Add"),
                  ),
                )
              ],
            ),
            context: context,
          ),
                          },
                          leading: Text(
                            listRecipies[index].title,
                                  style: const TextStyle(
                                    fontSize: 25,
                                    color: Color.fromARGB(255, 2, 135, 168),
                                    fontWeight: FontWeight.w600,
                                  ),
                            
                          ),
                          title:Text(
                                  listRecipies[index].ingredients +' '+ listRecipies[index].description,
                                  style: const TextStyle(
                                    fontSize: 25,
                                    color: Color.fromARGB(255, 59, 59, 59),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                          
                          trailing: TextButton(
                            onPressed: () async {
                              await RecipiesRepository()
                                  .removeRecipie(listRecipies[index].id);
                            },
                            child: const Icon(Icons.delete),
                          ),
                        );
                      },
                    )
                  ],
                ),
              );
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          showDialog(
            builder: (context) => SimpleDialog(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 20,
              ),
              backgroundColor: Colors.grey[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Row(
                children: [
                  const Text(
                    "Add Your Recipie",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.grey,
                      size: 30,
                    ),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
              children: [
                const Divider(),
                TextFormField(
                  controller: recipieItemController,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.5,
                    color: Colors.white,
                  ),
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "Type the recipie here",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                ),
                TextFormField(
                  controller: recipieIngredients,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.5,
                    color: Colors.white,
                  ),
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "Type the ingredients here",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                ),
                TextFormField(
                  controller: recipieDescription,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.5,
                    color: Colors.white,
                  ),
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "Type the description here",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                ),
                
                const SizedBox(height: 20),
                SizedBox(
                  width: width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (recipieItemController.text.isNotEmpty) {
                        await RecipiesRepository()
                            .addRecipie(recipieItemController.text.trim(),recipieDescription.text.trim(),recipieIngredients.text.trim());
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      minimumSize: const Size(60, 60),
                      elevation: 10,
                    ),
                    child: const Text("Add"),
                  ),
                )
              ],
            ),
            context: context,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
