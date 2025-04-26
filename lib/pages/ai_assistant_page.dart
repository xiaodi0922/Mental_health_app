import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import '../AI_services/gemini_service.dart';

class AiAssistantPage extends StatefulWidget {
  @override
  _AiAssistantPageState createState() => _AiAssistantPageState();
}

class _AiAssistantPageState extends State<AiAssistantPage> {
  final GeminiService _geminiService = GeminiService();

  final ChatUser _user = ChatUser(id: "1", firstName: "You");
  final ChatUser _aiUser = ChatUser(id: "2", firstName: "Gemini AI");

  List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();

    // Show introduction and then suggestion after
    Future.delayed(Duration(milliseconds: 500), () {
      String introMessage =
          "Hi there! 👋 I'm Gemini, your personal AI assistant.\n\n"
          "I'm here to support your mental health journey.";

      ChatMessage intro = ChatMessage(
        text: introMessage,
        user: _aiUser,
        createdAt: DateTime.now(),
      );

      ChatMessage suggestionBubble = ChatMessage(
        text: "💬 You can try asking me things like:",
        user: _aiUser,
        createdAt: DateTime.now(),
        customProperties: {
          'suggested': true,
        },
      );

      // Add messages in reverse so suggestion stays below
      setState(() {
        _messages.insertAll(0, [suggestionBubble, intro]);
      });
    });
  }


  void _sendMessage(ChatMessage message) async {
    setState(() {
      _messages.insert(0, message); // Add user message
    });

    // Loading placeholder
    ChatMessage loadingMessage = ChatMessage(
      text: "Thinking...",
      user: _aiUser,
      createdAt: DateTime.now(),
    );

    setState(() {
      _messages.insert(0, loadingMessage);
    });

    String aiResponse = await _geminiService.getResponse(message.text);

    // Replace loading with AI response
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
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: DashChat(
                currentUser: _user,
                onSend: _sendMessage,
                messages: _messages,
                inputOptions: InputOptions(
                  inputDecoration: InputDecoration(
                    hintText: "Ask something...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    hintStyle: const TextStyle(fontSize: 18),
                  ),
                  inputTextStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  sendButtonBuilder: (onSend) {
                    return IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: onSend,
                    );
                  },
                ),
                messageOptions: MessageOptions(
                  currentUserContainerColor: Colors.white,
                  containerColor: Theme.of(context).colorScheme.primary,
                  messagePadding: const EdgeInsets.symmetric(
                      horizontal: 13, vertical: 10),
                  messageTextBuilder:
                      (message, previousMessage, nextMessage) {
                    final bool isCurrentUser = message.user.id == _user.id;

                    // Check for suggested questions
                    if (message.customProperties?['suggested'] == true) {
                      List<String> suggestions = [
                        "How can I manage stress?",
                        "Give me a self-care tip",
                        "What to do when I feel anxious?",
                        "How to improve sleep quality?",
                        "How can I stay motivated?",
                      ];

                      return Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: suggestions.map((question) {
                          return ActionChip(
                            label: Text(question),
                            backgroundColor: Colors.white,
                            labelStyle: TextStyle(
                                color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            onPressed: () {
                              final userMsg = ChatMessage(
                                text: question,
                                user: _user,
                                createdAt: DateTime.now(),
                              );
                              _sendMessage(userMsg);
                            },
                          );
                        }).toList(),
                      );
                    }

                    // Normal text
                    return Text(
                      message.text,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isCurrentUser ? Colors.black : Colors.white,
                      ),
                    );
                  },
                ),
                scrollToBottomOptions: ScrollToBottomOptions(
                  disabled: false,
                  scrollToBottomBuilder: (scrollController) {
                    return Positioned(
                      right: 10,
                      bottom: 70,
                      child: FloatingActionButton(
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.arrow_downward, color: Colors.black),
                        onPressed: () {
                          scrollController.animateTo(
                            0.0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
