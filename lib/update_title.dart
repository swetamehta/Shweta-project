import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shweta_project/api_call.dart';

class UpdateTitle extends StatefulWidget {
  final int id;
  final String title;
  const UpdateTitle(
    this.id,
    this.title, {
    Key? key,
  }) : super(key: key);

  @override
  State<UpdateTitle> createState() => _UpdateTitleState();
}

class _UpdateTitleState extends State<UpdateTitle> {
  late TextEditingController txtTitle;

  @override
  void initState() {
    super.initState();

    txtTitle = TextEditingController(text: widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Title'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Id:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  widget.id.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Enter New Title',
                border: OutlineInputBorder(),
              ),
              controller: txtTitle,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 100,
                  color: Colors.blue,
                  child: MaterialButton(
                    child: const Text('SUBMIT'),
                    onPressed: () {
                      ApiCall apiCall =
                          Provider.of<ApiCall>(context, listen: false);

                      int? index = apiCall.apiModelList
                          ?.indexWhere((item) => item.id == widget.id);

                      if (index != null &&
                          index >= 0 &&
                          apiCall.apiModelList != null) {
                        apiCall.apiModelList![index].title =
                            txtTitle.value.text;
                      }

                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
