import 'package:flutter/material.dart';
import 'package:kogpt_flutter_frontend/kogpt.dart';
import 'package:kogpt_flutter_frontend/kogpt_provider.dart';
import 'package:kogpt_flutter_frontend/request_widget.dart';

import 'reponsive_decorator.dart';
import 'response_widget.dart';

import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'dart:html' as html;


void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "KoGPT",
      routes: {
        '/': (context) => ChangeNotifierProvider(
            create: (_) => koGPTProvider(),
            child: const MainPage()),
      },
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blueGrey.shade300,
              Colors.grey.shade300,
            ],
          )),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20,),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.grey.shade900
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        WavyAnimatedText(
                          'KoGPT',
                          speed:const Duration(milliseconds: 300)),
                      ],
                      onTap: () {},
                    ),
                  ),
                ),
             ResponsiveDecorator(
              color: Colors.amber.shade100,
              shadeColor: Colors.amber.shade900,
              child: RequestWidget(paramsMap: koGPT.koGPTParams,),
            ),
            ResponsiveDecorator(
              color: Colors.purple.shade100,
                  shadeColor: Colors.purple.shade900,
                  child: ResponseWidget(),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  const Text("made by Jong Hyun Park, Refer this"),
                  TextButton(
                    child: const Text("POST"),
                    onPressed: () {
                      html.window.open(
                          "https://tmmse.xyz/2022/10/22/kogpt-web-ui/",
                          "_blank");
                    },
                  ),
                ]),
              ],
            ),
          ),
        ));
  }
}