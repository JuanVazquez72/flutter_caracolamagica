import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_no_answer.dart';

import '../../domain/entities/message.dart';

class ChatProvider extends ChangeNotifier{


  final GetYesNoAnswer getYesNoAnswer = GetYesNoAnswer();
  final ScrollController chatScrollController = ScrollController();




  List<Message> messageList = [];

  Future<void> sendMessage( String text )async {
    // implementar metdodo

    if (text.isEmpty) return;

    final newMessage = Message(text: text, fromWho: FromWho.me);
    messageList.add(newMessage);


    if(text.trimRight().endsWith('?')){
     herReply();
    }
    
    notifyListeners();
    moveScrollBottom();

  }

  Future<void> herReply() async {
    final herMesagge = await getYesNoAnswer.getAnswer();
    messageList.add(herMesagge);
    notifyListeners();
    moveScrollBottom();
  }

   Future<void> moveScrollBottom() async{

    await Future.delayed(const Duration(milliseconds: 100));
    chatScrollController.animateTo(chatScrollController.position.maxScrollExtent, 
    duration: const Duration(milliseconds: 300), 
    curve: Curves.easeOut);
  }

}