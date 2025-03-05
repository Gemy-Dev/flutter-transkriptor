
import 'dart:developer';
import 'dart:io';

import 'package:dart_openai/dart_openai.dart';
import 'package:transkriptor/core/errors/exceptions.dart';

abstract class RemoteDataSource{
Future<String> createTranscription(String path);
}

class RemoteDataSourceImpl implements RemoteDataSource{
  RemoteDataSourceImpl(){
 OpenAI.requestsTimeOut = const Duration(minutes: 60); // 60 seconds.
}
// 60 seconds.
  @override
 Future<String> createTranscription(String path)async {
    log(path);
try{

     OpenAI.showResponsesLogs = true;
    final transcription =await OpenAI.instance.audio.createTranscription(
  file: File(path),
  model: "whisper-1",
  responseFormat: OpenAIAudioResponseFormat.json,


) ;

return    transcription.text;
}catch (e){
 throw ServerException();
}
  }
}