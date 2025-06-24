import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ChatScreen extends StatelessWidget {
   ChatScreen({super.key});
 
 FirebaseFirestore firestore = FirebaseFirestore.instance;
 CollectionReference messages = FirebaseFirestore.instance.collection('messages');
 TextEditingController controller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatAt).snapshots(),
      
      builder: (context,snapshot)
    {
      if (snapshot.hasData){
        List<Message> messagesList =[];
        for(int i=0;i<snapshot.data!.docs.length ;i++){
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
        }
      return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Row(
          children: [
            // الصورة بشكل دائري
            CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage("assets/images/person.png"),
            ),
            const SizedBox(width: 8),
            const Text(
              "Rawan",
              style: TextStyle(color: Colors.white,fontSize: 18),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // action for phone call
            },
            icon: const Icon(Icons.videocam,color: Colors.white,),
          ),
          IconButton(
            onPressed: () {
              // action for video call
            },
            icon: const Icon(Icons.call,color: Colors.white,),
          ),
          
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messagesList.length,
              itemBuilder: (context, index) {
                bool isMe = index % 2 == 0; 
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isMe ? kPrimaryColor : Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(12),
                        topRight: const Radius.circular(12),
                        bottomLeft: isMe ? const Radius.circular(12) : Radius.zero,
                        bottomRight: isMe ? Radius.zero : const Radius.circular(12),
                      ),
                    ),
                    child: Text(
                      //isMe ? "Hello from me!" : "Hi from the other side!",
                      messagesList[index].messages,
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(

                    onSubmitted: (data){
                        messages.add({
                          kMessage:data,
                          kCreatAt :DateTime.now()
                        }
                        );
                        controller.clear();
                    },
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 24,
                  backgroundColor: kPrimaryColor,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      // action to send message
                    },
                  ),
                ),
              ],
            ),
          ),
      
        ],
      ),
    );
      }else{
        return Text("Loading....");
      }
    }
    
    )
  
    ;
  }
}
