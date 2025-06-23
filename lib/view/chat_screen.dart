import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
 
 
  @override
  Widget build(BuildContext context) {
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
              itemCount: 10,
              itemBuilder: (context, index) {
                bool isMe = index % 2 == 0; // نغير الشكل حسب المرسل
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
                      isMe ? "Hello from me!" : "Hi from the other side!",
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
  }
}
