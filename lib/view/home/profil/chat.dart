import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventease/core/constant/color.dart';
import 'package:eventease/view/commonwidgets/common_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final _firestore = FirebaseFirestore.instance;
late User signedInUser;

class ChatScreen extends StatefulWidget {
  static const String screenRoute = 'chat_screen';
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;

  final messagetextcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
      }
    } catch (e) {
      return;
    }
  }

  String? messagetext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CommonAppBar(
          title: "Support",
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MessageStreamBuilder(),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.red,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messagetext = value;
                      },
                      controller: messagetextcontroller,
                      style: const TextStyle(
                        color: AppColor.secondcolor,
                      ),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        hintText: 'Write your message here...',
                        hintStyle: TextStyle(color: AppColor.secondcolor),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _firestore
                          .collection("users")
                          .doc(signedInUser.uid)
                          .collection("messages")
                          .add({
                        "sender": signedInUser.uid,
                        "text": messagetext,
                        'time': FieldValue.serverTimestamp(),
                      });
                      messagetextcontroller.clear();
                    },
                    child: Text(
                      'send',
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageLine extends StatelessWidget {
  final String text;
  final bool isme;
  final String messageid;
  const MessageLine(
      {super.key,
      required this.text,
      required this.isme,
      required this.messageid});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            isme ? "You" : "Support",
            style: const TextStyle(fontSize: 13.0, color: AppColor.greycolor),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              isme
                  ? _firestore
                      .collection("users")
                      .doc(signedInUser.uid)
                      .collection("messages")
                      .doc(messageid)
                      .delete()
                  : null;
            },
            background: Container(
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.red,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            child: Material(
              elevation: 5.0,
              borderRadius: isme
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    )
                  : const BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
              color:
                  isme ? Colors.blue : const Color.fromARGB(255, 230, 218, 218),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: isme ? AppColor.secondcolor : AppColor.primarycolor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection("users")
          .doc(signedInUser.uid)
          .collection("messages")
          .orderBy('time')
          .snapshots(),
      builder: (context, snapshot) {
        List<MessageLine> messagewidgets = [];
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
            ),
          );
        }

        final messages = snapshot.data!.docs.reversed;

        for (var message in messages) {
          final messagetext = message.get("text");
          final messagesender = message.get("sender");
          final currentuserid = signedInUser.uid;
          final messagewidget = MessageLine(
            text: messagetext,
            messageid: message.id,
            isme: currentuserid == messagesender,
          );
          messagewidgets.add(messagewidget);
        }
        return Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15.0),
            reverse: true,
            children: messagewidgets,
          ),
        );
      },
    );
  }
}
