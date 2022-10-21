import 'package:flutter/material.dart';
import 'kogpt.dart';

class KoGPTState{
  bool isWaiting = false;
  String id = "";
  List generations = [];
  int prompt_tokens = 0;
  int generated_tokens = 0;
  int total_tokens = 0;
  String errorMsg = "";

  parse(Map response){
    if(response.containsKey("msg")){
      errorMsg = response["msg"];
      return;
    }

    id = response["id"];
    generations = [];
    for(var gen in response["generations"]){
      generations.add(gen["text"]);
    }

    var usage = response["usage"];
    prompt_tokens = usage["prompt_tokens"];
    generated_tokens = usage["generated_tokens"];
    total_tokens = usage["total_tokens"];
  }
}

class koGPTProvider extends ChangeNotifier{

  KoGPTState state = KoGPTState();

  void request(values) async {
    state.isWaiting = true;
    notifyListeners();

    var responseBody = await koGPT.request(values);
    print(responseBody);
    state.parse(responseBody);
    state.isWaiting = false;
    notifyListeners();
  }


}