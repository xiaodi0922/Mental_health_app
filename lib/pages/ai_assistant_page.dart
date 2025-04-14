import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import '../AI_services/gemini_service.dart';

class AiAssistantPage extends StatefulWidget {
  @override
  _AiAssistantPageState createState() => _AiAssistantPageState();
}

class _AiAssistantPageState extends State<AiAssistantPage> {
  final GeminiService _geminiService = GeminiService();

  // Define users
  final ChatUser _user = ChatUser(
      id: "1",
      firstName: "You"

  );
  final ChatUser _aiUser = ChatUser(
      id: "2",
      firstName: "Gemini AI"
  );

  // Store messages
  List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();

    // AI welcome message
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _messages.add(
          ChatMessage(
            text:
            "Hi there! 👋 I'm Gemini, your personal AI assistant. I'm here to support your mental health journey. You can talk to me about how you're feeling, ask for self-care tips, or just chat when you're feeling low. How can I help you today?",
            user: _aiUser,
            createdAt: DateTime.now(),
          ),
        );
      });
    });
  }

  void _sendMessage(ChatMessage message) async {
    setState(() {
      _messages.insert(0, message); // Add user message to the chat
    });

    // Show a "typing" indicator
    ChatMessage loadingMessage = ChatMessage(
      text: "Thinking...",
      user: _aiUser,
      createdAt: DateTime.now(),
    );
    setState(() {
      _messages.insert(0, loadingMessage);
    });

    // Get AI response
    String aiResponse = await _geminiService.getResponse(message.text);

    // Remove the "Thinking..." message
    setState(() {
      _messages.remove(loadingMessage);
      _messages.insert(
        0,
        ChatMessage(
          text: aiResponse,
          user: _aiUser,
          createdAt: DateTime.now(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
              "AI Assistant",
            style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold
            ),
          )
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: DashChat(
          currentUser: _user,
          onSend: _sendMessage, // Handle message sending
          messages: _messages,

          //chat input box
          inputOptions: InputOptions(
            inputDecoration: InputDecoration(
                hintText: "Ask something...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              hintStyle: const TextStyle(fontSize: 18),

            ),

              inputTextStyle: const TextStyle(
                fontSize: 18,  // Adjust this to change user input font size
                fontWeight: FontWeight.bold,
              ),
            sendButtonBuilder: (onSend){
              return IconButton(
                icon: Icon(
                    Icons.send,
                    color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: onSend,
              );
            }
          ),

          messageOptions:MessageOptions(
            currentUserContainerColor: Colors.white, //User color
            containerColor: Theme.of(context).colorScheme.primary,// AI message color// User text color
            messagePadding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
            messageTextBuilder: (message, previousMessage, nextMessage){
              final bool CurrentUser = message.user.id == _user.id;

              return Text(
                message.text,
                style: TextStyle(
                  fontSize: 18, // Adjust this value for desired text size
                  fontWeight: FontWeight.bold,
                  color: CurrentUser
                      ? Colors.black // User message text color
                      : Colors.white, // AI message text color
                ),
              );
            }


          ),
          scrollToBottomOptions: ScrollToBottomOptions(
            disabled: false,
            scrollToBottomBuilder: (scrollController){
              return Positioned(
                  right: 10,
                  bottom: 70,
                  child: FloatingActionButton(
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.arrow_downward, color: Colors.black),
                      onPressed: (){
                        scrollController.animateTo(0.0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut
                        );
                      },
                  ),
              );
            },
          ),
        ),
      ),
    );
  }
}
