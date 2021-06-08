import 'dart:io';

import 'package:chat_app_flutter/pages/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();
  List<ChatMessage> _messages = [
    ChatMessage(uid: '123', text: 'Hola mundo'),
    ChatMessage(
        uid: '123',
        text:
            'Non aliqua occaecat fugiat dolor nostrud aute id dolore amet cillum qui ipsum est.'),
    ChatMessage(
        uid: '12w1w13',
        text:
            'Irure consectetur irure eiusmod mollit. Sit ex consequat dolore anim dolore do mollit voluptate cupidatat laborum. Adipisicing non pariatur labore officia. Proident cillum sint ad Lorem occaecat sunt commodo in excepteur deserunt excepteur.'),
    ChatMessage(uid: '123', text: 'Hola mundo'),
    ChatMessage(
        uid: '123',
        text:
            'Irure consectetur irure eiusmod mollit. Sit ex consequat dolore anim dolore do mollit voluptate cupidatat laborum. Adipisicing non pariatur labore officia. Proident cillum sint ad Lorem occaecat sunt commodo in excepteur deserunt excepteur.'),
    ChatMessage(uid: '123', text: 'Hola mundo'),
    ChatMessage(
        uid: '1232121',
        text:
            'Irure consectetur irure eiusmod mollit. Sit ex consequat dolore anim dolore do mollit voluptate cupidatat laborum. Adipisicing non pariatur labore officia. Proident cillum sint ad Lorem occaecat sunt commodo in excepteur deserunt excepteur.'),
    ChatMessage(uid: '123', text: 'Hola mundo'),
    ChatMessage(uid: '123', text: 'Hola mundo'),
    ChatMessage(
        uid: '123',
        text:
            'Irure consectetur irure eiusmod mollit. Sit ex consequat dolore anim dolore do mollit voluptate cupidatat laborum. Adipisicing non pariatur labore officia. Proident cillum sint ad Lorem occaecat sunt commodo in excepteur deserunt excepteur.'),
    ChatMessage(uid: '123', text: 'Hola mundo'),
    ChatMessage(
        uid: '1232121',
        text:
            'Irure consectetur irure eiusmod mollit. Sit ex consequat dolore anim dolore do mollit voluptate cupidatat laborum. Adipisicing non pariatur labore officia. Proident cillum sint ad Lorem occaecat sunt commodo in excepteur deserunt excepteur.'),
    ChatMessage(uid: '123', text: 'Hola mundo'),
    ChatMessage(uid: '123', text: 'Hola mundo'),
  ];
  bool _isWriting = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              child: Text('Te', style: TextStyle(fontSize: 12)),
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
            ),
            SizedBox(height: 3),
            Text(
              'Melisa Flores',
              style: TextStyle(color: Colors.black87, fontSize: 12),
            )
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (_, i) => _messages[i],
                reverse: true,
              ),
            ),
            Divider(height: 1),
            // TODO: Caja de texto
            SafeArea(
                child: Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
              decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(20)),
              /* color: Colors.blue[100],
              height: 50, */
              child: _inputChat(),
            )),
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmit,
              onChanged: (String text) {
                setState(() {
                  if (text.trim().length > 0) {
                    _isWriting = true;
                  } else {
                    _isWriting = false;
                  }
                });
              },
              decoration: InputDecoration.collapsed(
                hintText: 'Send Message',
              ),
              focusNode: _focusNode,
            ),
          ),
          // Send Button
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 0),
              child: IconTheme(
                data: IconThemeData(color: Colors.blue[400]),
                child: IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: Icon(Icons.send),
                  onPressed: _isWriting
                      ? () => _handleSubmit(_textController.text.trim())
                      : null,
                ),
              ),
            ),

            /* Platform.isIOS
                ? CupertinoButton(
                    child: Text('Send'),
                    onPressed: _isWriting
                        ? () => _handleSubmit(_textController.text.trim())
                        : null,
                  )
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 0),
                    child: IconTheme(
                      data: IconThemeData(color: Colors.blue[400]),
                      child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        icon: Icon(Icons.send),
                        onPressed: _isWriting
                            ? () => _handleSubmit(_textController.text.trim())
                            : null,
                      ),
                    ),
                  ), */
          ),
        ],
      ),
    ));
  }

  _handleSubmit(String texto) {
    print(texto);
    _textController.clear();
    _focusNode.requestFocus();
    setState(() {
      _isWriting = false;
    });
  }
}
