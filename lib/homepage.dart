import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shweta_project/api_call.dart';
import 'package:shweta_project/api_model.dart';
import 'package:shweta_project/update_title.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ApiCall>(builder: (context, data, child) {
      List<ApiModel>? apiList = data.apiModelList;

      if (apiList == null) {
        data.getList();
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      return Scaffold(
        appBar: AppBar(
          title: const Text('Api List'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateTitle(
                            apiList[index].id ?? 0,
                            apiList[index].title ?? '',
                          ),
                        ),
                      );
                    },
                    child: Material(
                      elevation: 1,
                      child: Card(
                          color: index % 2 == 0
                              ? Colors.cyanAccent
                              : Colors.orangeAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text('User Id:'),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(apiList[index].userId.toString()),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    const Text('Id:'),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(apiList[index].id.toString()),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    const Text('Title:'),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                        child: Text(
                                      apiList[index].title.toString(),
                                      maxLines: 1,
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          )),
                    ),
                  );
                },
                itemCount: apiList.length,
              ),
            ),
          ),
        ),
      );
    });
  }
}
