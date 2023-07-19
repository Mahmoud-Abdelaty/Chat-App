import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/constant.dart';
import 'package:scholar_chat/models/message.dart';



class ChatBubble extends StatelessWidget {
  ChatBubble({required this.message,
    super.key,
  });

  final Message message;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
      builder: (context, snapshot) {
        return Align(
          alignment: Alignment.centerRight,
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: kPrimaryColor,
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            child: Stack(
              children: [
                Positioned(
                  top: 6,
                  left: 7,
                  child: Text(
                    message.name,
                    style:const TextStyle(
                      fontSize: 13,
                      color: Colors.red,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 55,
                    right: 30,
                    top: 22,
                    bottom: 22,
                  ),
                  child: Text(
                    message.message,
                    style: const TextStyle(
                      fontSize: 16.5,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Text(
                    message.hour,
                    style:const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}


class ChatBubbleForFriend extends StatelessWidget {
  ChatBubbleForFriend({required this.message,
    super.key,
  });

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: Color(0xff006D84),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Stack(
          children: [
            Positioned(
              top: 5,
              left: 7,
              child: Text(
                message.name,
                style:const TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 55,
                right: 30,
                top: 22,
                bottom: 22,
              ),
              child: Text(
                message.message,
                style: const TextStyle(
                  fontSize: 16.5,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              bottom: 4,
              right: 4,
              child: Text(
                message.hour,
                style:const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



//
// class ChatBubble extends StatelessWidget {
//    ChatBubble({required this.message,
//     super.key,
//   });
//
//   final Message message;
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
//         padding: EdgeInsets.only(left: 16, top: 15, bottom: 15, right: 20),
//         decoration: BoxDecoration(
//           color: kPrimaryColor,
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(32),
//             topLeft: Radius.circular(32),
//             topRight: Radius.circular(32),
//           ),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               message.message,
//               style: TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//             Text(
//                 message.hour,
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 10
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// class ChatBubbleForFriend extends StatelessWidget {
//   ChatBubbleForFriend({required this.message,
//     super.key,
//   });
//
//   final Message message;
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//         padding: EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 32),
//         decoration: BoxDecoration(
//           color: Color(0xff006D84),
//           borderRadius: BorderRadius.only(
//             bottomRight: Radius.circular(32),
//             topLeft: Radius.circular(32),
//             topRight: Radius.circular(32),
//           ),
//         ),
//         child:  Column(
//           children: [
//             Text(
//               message.message,
//               style: TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//             Text(
//               message.hour,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 10,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

