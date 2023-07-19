import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constant.dart';
import 'package:scholar_chat/models/message.dart';
import 'package:scholar_chat/screens/login_page.dart';
import 'package:scholar_chat/widgets/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);

  static String id = 'ChatPage';
  var controller = TextEditingController();
  final  _controller = ScrollController();
  CollectionReference messages = FirebaseFirestore.instance.collection(kMessagesCollection);    // Access Collection

  @override
  Widget build(BuildContext context) {
    // var name = ModalRoute.of(context)!.settings.arguments;
    // String? email = ModalRoute.of(context)!.settings.arguments as String;
    // String? name = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('time', descending: true).snapshots(),
      builder: (context, snapshot)
            {
              if(snapshot.hasData)
                {
                  List<Message> messagesList = [];
                  for(int i =0 ; i<snapshot.data!.docs.length; i++)
                    {
                      messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
                    }
                  return Scaffold(
                    appBar: AppBar(
                      backgroundColor: kPrimaryColor,
                      centerTitle: true,
                      actions:
                      [
                        IconButton(
                            onPressed: ()
                            async {
                              await FirebaseAuth.instance.signOut();
                              Navigator.pushNamedAndRemoveUntil(context, LoginPage.id, (route) => false);
                            }, icon: Icon(Icons.login_rounded)
                        ),
                      ],
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          Image.asset(kLogo, width: 50,),
                          Text(
                            'Chat',
                            style: TextStyle(
                              fontFamily: ('pacifico'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    body: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            reverse: true,
                            controller: _controller,
                            itemCount: messagesList.length,
                              itemBuilder: (context, index) {
                                return messagesList[index].id == FirebaseAuth.instance.currentUser!.email ? ChatBubble(message: messagesList[index])
                                    : ChatBubbleForFriend(message: messagesList[index]);
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextField(
                            controller : controller,
                            onSubmitted: (data)
                            {
                              String? email = FirebaseAuth.instance.currentUser!.email;
                              String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

                              messages.add({
                                'message' : data,
                                'time' : DateTime.now(),
                                'hour' : DateFormat('hh:mm a').format(DateTime.now()),
                                'id' : FirebaseAuth.instance.currentUser!.email,
                                'name' : capitalize(FirebaseAuth.instance.currentUser!.email!.substring(0, email!.indexOf("@"))),
                              });
                              controller.clear();
                              _controller.animateTo(
                                  0,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeIn,
                              );
                            },
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: kPrimaryColor,
                                  )
                              ),
                              suffixIcon: Icon(
                                Icons.send_rounded,
                                color: kPrimaryColor,
                              ),
                              hintText: 'Send Message',
                              focusedBorder: OutlineInputBorder (
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: kPrimaryColor,
                                  )
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              else
                {
                  return Scaffold(
                    body: ModalProgressHUD(
                      inAsyncCall: true,
                      child: Text(''),
                    ),
                  );
                }
            },
    );
  }

}


