import 'rest_request.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class koGPT {

  static Map<String, Parameter> koGPTParams = {
    "prompt": Parameter(
        "인간처럼 생각하고, 행동하는 지능을 통해 인류가 이제까지 풀지 못했던", true, "전달할 제시어를 입력하세요.",
        helpUrl:
            "https://developers.kakao.com/docs/latest/ko/kogpt/rest-api#sample"),
    "max_tokens": Parameter("100", false, "KoGPT가 생성할 결과의 최대 토큰 수, (ex) 500",
        helpUrl:
            "https://developers.kakao.com/docs/latest/ko/kogpt/common#intro-glossary-token"),
    "temperature": Parameter(
        "1.0", false, "온도 설정, 0~1의 실수 값. 높을수록 창의적, default = 1",
        helpUrl:
            "https://developers.kakao.com/docs/latest/ko/kogpt/common#intro-glossary-temperature"),
    "top_p": Parameter(
        "1.0", false, "상위 확률 설정, 0~1의 실수 값. 높을수록 창의적, default = 1",
        helpUrl:
            "https://developers.kakao.com/docs/latest/ko/kogpt/common#intro-glossary-top-p"),
    "n": Parameter(
      "2",
      false,
      "생성할 결과 수, 1~16의 정수 값",
    ),
    "REST API Key": Parameter("", false, "Kakao Developers 에서 발급", helpUrl: "https://tmmse.xyz/2022/10/20/kakao_api_key/"),
  };

  static request(Map<String, String> values) async {
    Map<String, dynamic> bodyMap = {};

    // convert value types
    try{
    values.forEach(((key, value) {
      switch (key) {
        case "prompt":
          bodyMap[key] = value;
          break;
        case "max_tokens":
          bodyMap[key] = int.parse(value);
          break;
        case "temperature":
          bodyMap[key] = double.parse(value);
          break;
         case "top_p":
          bodyMap[key] = double.parse(value);
          break;
         case "n":
          bodyMap[key] = int.parse(value);
          break;
        default:
      }
    }));
    }catch(_){}

    // request http
    var url = Uri.https('thingproxy.freeboard.io',"/fetch/https://api.kakaobrain.com/v1/inference/kogpt/generation");
    var response = await http.post(url,
        headers: {
          "Authorization": "KakaoAK ${values["REST API Key"]}",
          "Content-Type": "application/json",
        },
        body: jsonEncode(bodyMap));

   return jsonDecode(response.body);
  }
}
