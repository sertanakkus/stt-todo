import 'package:flutter/material.dart';

class ItemPage extends StatefulWidget {
  final MapEntry<String, List<dynamic>> items;

  const ItemPage({super.key, required this.items});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    MapEntry<String, List<dynamic>> items = widget.items;

    return Scaffold(
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
              Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      const BackButton(),
                      Text(
                        items.key.toString(),
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
              const Divider(),
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: items.value.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = items.value[index];

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
                          items.value.remove(index);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                padding: const EdgeInsets.only(top: 10),
                                backgroundColor: Colors.grey[700],
                                duration: Durations.long4,
                                content: Align(
                                    child: Text(
                                  '"$item" deleted',
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
                                  print(item);
                                },
                                leading: const Icon(Icons.list),
                                title: Text(
                                  item,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                      );
                    }),
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
          onPressed: () {},
          child: Icon(
            Icons.mic,
            size: 40,
            color: Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}
