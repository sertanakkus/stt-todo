import 'package:flutter/material.dart';
import 'package:voice_todo/pages/item_page.dart';
import 'package:voice_todo/storage/storage_functions.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final TextEditingController listNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith());

    // Map<String, List> data = {
    //   "To-Do": [
    //     "To-Do Item 1",
    //     "To-Do Item 2",
    //     "To-Do Item 3",
    //   ],
    //   "Groceries": [
    //     "Groceries Item 1",
    //     "Groceries Item 2",
    //     "Groceries Item 3",
    //   ],
    //   "Home": [
    //     "Home Item 1",
    //     "Home Item 2",
    //     "Home Item 3",
    //   ],
    //   "Places to eat": [
    //     "Places to eat Item 1",
    //     "Places to eat Item 2",
    //     "Places to eat Item 3",
    //   ],
    // };

    Map data = StorageFunctions().getAllLists();

    return Scaffold(
      // backgroundColor: const Color.fromARGB(235, 255, 255, 255),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              // <a href="https://www.freepik.com/free-photo/white-painted-wall-texture-background_18416494.htm#query=background&position=1&from_view=keyword&track=sph&uuid=6a64bba8-e2c9-4c43-88b7-636b877afb20">Image by rawpixel.com</a> on Freepik
              image: AssetImage("images/background.jpg"),
              fit: BoxFit.cover,
              opacity: 0.6),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 80, left: 10, right: 10),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Icon(
                      Icons.wb_sunny_outlined,
                    ),
                    Text(
                      " Good Morning, John",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = data.entries.elementAt(index);

                      return Dismissible(
                        key: UniqueKey(),
                        background: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(left: 20.0),
                          child: const Padding(
                            padding: EdgeInsets.only(right: 20.0),
                            child:
                                Icon(Icons.delete_outline, color: Colors.white),
                          ),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          // data.remove(item.key);
                          StorageFunctions().deleteList(item.key);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                padding: const EdgeInsets.only(top: 10),
                                backgroundColor: Colors.grey[700],
                                duration: Durations.extralong2,
                                content: Align(
                                    child: Text(
                                  '"${item.key}" deleted',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ))),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color: Colors.grey.shade400, width: 1),
                            ),
                            child: ListTile(
                                onTap: () {
                                  print(item.value);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ItemPage(items: item),
                                      ));
                                },
                                leading: const Icon(Icons.list),
                                title: Text(
                                  item.key,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton.icon(
                        style: const ButtonStyle(
                            foregroundColor:
                                MaterialStatePropertyAll(Colors.black),
                            alignment: Alignment.bottomCenter,
                            padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                        onPressed: () {
                          _dialogBuilder(context);
                        },
                        icon: const Icon(Icons.add),
                        label: const Text(
                          'New List',
                          style: TextStyle(fontSize: 16),
                        )),
                    // IconButton(
                    //   color: Colors.black87,
                    //   onPressed: () {},
                    //   icon: const Icon(Icons.settings),
                    //   padding: EdgeInsets.zero,
                    //   alignment: Alignment.bottomCenter,
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400, width: 2),
            borderRadius: BorderRadius.circular(15)),
        width: 80,
        height: 80,
        child: FloatingActionButton(
          // backgroundColor: Colors.white12,
          // backgroundColor: Colors.grey[850],
          backgroundColor: Colors.grey.shade50,
          onPressed: () {
            setState(() {});
          },
          child: Icon(
            Icons.mic,
            size: 40,
            color: Colors.grey.shade700,
          ),
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(
    BuildContext context,
  ) {
    return showDialog<void>(
      context: context,
      useSafeArea: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          alignment: Alignment.center,
          scrollable: true,
          content: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: listNameController,
                  cursorColor: Colors.black87,
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black87))),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: SizedBox(
                width: 200,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    StorageFunctions().addList(listNameController.text);
                    listNameController.text = "";
                    Navigator.pop(context);
                    setState(() {});
                  },
                  style: ButtonStyle(
                    side: const MaterialStatePropertyAll(
                      BorderSide(color: Colors.white, width: 2),
                    ),
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.grey.shade800),
                    foregroundColor:
                        const MaterialStatePropertyAll(Colors.white),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0))),
                  ),
                  child: const Text(
                    "Add",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
