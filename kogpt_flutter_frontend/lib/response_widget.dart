import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'kogpt_provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ResponseWidget extends StatefulWidget{
  @override
  // ignore: library_private_types_in_public_api
  _ResponseWidgetState createState()  => _ResponseWidgetState();
}

class _ResponseWidgetState extends State<ResponseWidget> {
  @override
  Widget build(BuildContext context) {
    KoGPTState currentState = context.watch<koGPTProvider>().state;
    if(currentState.isWaiting){
      return Center(child: LoadingAnimationWidget.twistingDots(
          leftDotColor: const Color(0xFF1A1A3F),
          rightDotColor: const Color(0xFFEA3799),
          size: 100,
        ),);
    }else{

      List<Widget> outputs = [];
      outputs.add(const Text("결과!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),));
      outputs.add(const Divider());

      outputs.add(
       Text("ID: ${currentState.id}"),
      );
      outputs.add(
       Text("입력 토큰 사용량: ${currentState.prompt_tokens}"),);
      outputs.add(
       Text("결과 토큰 사용량: ${currentState.generated_tokens}"),);
      outputs.add(
       Text("총 토큰 사용량: ${currentState.total_tokens}"),);
      outputs.add(Text("에러 메세지: ${currentState.errorMsg}"));
      for(String gen in currentState.generations){
        outputs.add(const Divider());
        outputs.add(Text(gen));
      }
      if(currentState.generations.isEmpty){
        outputs.add(const Divider());
        outputs.add(Text("KoGPT 는 과연 뭐라고 할까?!"));
      }

      return
       Container(
        padding: EdgeInsets.all(10),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: outputs));
       
    }
  }
}
