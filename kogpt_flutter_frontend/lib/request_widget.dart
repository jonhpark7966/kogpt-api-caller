import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kogpt_flutter_frontend/kogpt_provider.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;

import 'kogpt.dart';

class RequestWidget extends StatefulWidget{
  Map paramsMap;

  RequestWidget({Key? key, required this.paramsMap}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RequestWidgetState createState()  => _RequestWidgetState();
}

class _RequestWidgetState extends State<RequestWidget> {
  late koGPTProvider _koGPTProvider;
  Map<String, TextEditingController> controllers = {};

  @override
  void initState() {
    //init text controllers
    widget.paramsMap.forEach(((key, value){
      controllers[key] = TextEditingController(text:value.defaultValue);
    }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> textEditors = [];
    widget.paramsMap.forEach((key, value) {
      textEditors.add(
        Container(
          padding:EdgeInsets.all(10),
          child:
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          SizedBox(
            width: value.isMultiline?( (MediaQuery.of(context).size.width < 820)?
             (MediaQuery.of(context).size.width - 120) :700):250,
            child: TextField(
              keyboardType: TextInputType.multiline,
              minLines:value.isMultiline?3:1,
              maxLines:value.isMultiline?5:1,
              autofocus: false,
              controller: controllers[key],
          decoration: InputDecoration(
            labelText: key,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            helperText: value.hintText,
            border: const OutlineInputBorder(),
                ),
            ),
          ),
          value.helpUrl.isEmpty?const SizedBox(width:1):
          IconButton(icon:const Icon(Icons.help_outline_rounded), onPressed: () {
            html.window.open(value.helpUrl,"_blank");
          },)
          ],))
      );
     });

     List<Widget> requestButton = [
      Container(
        padding: const EdgeInsets.all(20),
        child:
      ElevatedButton(
        onPressed: (){
          context.read<koGPTProvider>().state.errorMsg = "";

          if(controllers["REST API Key"]!.text.isEmpty){
            _popupAPIKeyInfo();
          }


          // prepare values
          Map<String, String> values = {};
          controllers.forEach((key, value) {
            values[key] = value.text;
           });

          // http request
          context.read<koGPTProvider>().request(values);

        },
        style: ElevatedButton.styleFrom(
          primary: Colors.amber.shade900
        ),
       child: const Text(" ??????! ")))

     ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: textEditors + requestButton,);
  }

  _popupAPIKeyInfo() {
    showDialog(
        context: context,
        barrierDismissible: true, // ?????? ?????? ????????? ????????? ??????
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const Text("REST API KEY ??? ???????????? ???????????????!"),
              const Text("3????????? ????????? ???????????????."),
                TextButton(
                  onPressed: () {
                    html.window.open(
                        koGPT.koGPTParams["REST API Key"]!.helpUrl, "_blank");
                  },
                  child: const Text("* ?????? ??????"),
                )
              ],
            ),
            insetPadding: const EdgeInsets.fromLTRB(0, 80, 0, 80),
            actions: [
              TextButton(
                child: const Text('??????'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}