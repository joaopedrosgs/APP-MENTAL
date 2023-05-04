import 'dart:async';

import 'package:app_mental/Services/chatService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import '../../constants.dart';
import '../../helper/helperfuncions.dart';
import '../../model/channel.dart';
import 'localization.dart';

class ChatPage extends StatefulWidget {
  final Channel channel;
  const ChatPage({
    required this.channel,
  }) : super();

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late String _email;
  List<types.Message> _messages = [];
  int? messageId;

  @override
  void initState() {
    getUserEmail();
    Timer.periodic(Duration(seconds: 30), (_) {
      getChatHistory();
    });
    super.initState();
  }

  getUserEmail() async {
    await HelperFunctions.getUserEmailInSharedPreference().then((email) {
      setState(() {
        this._email = email;
        this.getChatHistory();
      });
    });
  }

  void getChatHistory() {
    ChatService()
        .getChatHistory(this._email, widget.channel.idChannel)
        .then((value) {
      setState(() {
        this._messages = value;
        messageId = null;
      });
    });
  }

  void _handleSendPressed(types.PartialText message) {
    ChatService()
        .sendMessage(message.text, widget.channel.idUser.toString(),
            widget.channel.idChannel)
        .then((value) {
      getChatHistory();
    });
  }

  _goBackPage(BuildContext context) {
    Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
    Navigator.of(context).pushNamed("/chat-room-screen");
  }

  void _handleLongPress(BuildContext context, types.Message message) {
    HapticFeedback.vibrate();
    setState(() {
      messageId = int.parse(message.id);
    });
  }

  void _removeDeleteIcon() {
    setState(() {
      messageId = null;
    });
  }

  void _deleteMessage() {
    ChatService().deleteMessage(messageId!, _email).then((_) {
      getChatHistory();
    }).catchError((error) {
      final snackBar = SnackBar(
          content:
              Text(error.toString(), style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      _removeDeleteIcon();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Chat"),
          backgroundColor: kTextColorGreen,
          shadowColor: Color.fromRGBO(1, 1, 1, 0),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => _goBackPage(context),
          ),
          actions: messageId != null
              ? [
                  IconButton(
                    onPressed: () => _deleteMessage(),
                    icon: Icon(Icons.delete, color: Colors.red),
                  )
                ]
              : null),
      body: StreamBuilder<types.Room>(
        builder: (context, snapshot) {
          return StreamBuilder<List<types.Message>>(
            initialData: const [],
            builder: (context, snapshot) {
              return SafeArea(
                bottom: false,
                child: Chat(
                  onBackgroundTap: _removeDeleteIcon,
                  onMessageLongPress: _handleLongPress,
                  messages: _messages,
                  l10n: ChatL10nBr(),
                  onSendPressed: _handleSendPressed,
                  user: types.User(
                    id: widget.channel.idUser.toString(),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
