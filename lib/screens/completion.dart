import 'dart:typed_data';
import 'package:bubble/bubble.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:openai/main.dart';
import 'package:share_plus/share_plus.dart';

// Message constructor
class Message {
  String text;
  bool byMe;  // Determines if the message was created by User or AI

  Message(this.text, this.byMe);
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key, key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String text = '';
  var textEditingController = TextEditingController();
  final screenController = ScreenshotController();

  String prompt =
      "Topic: humor: literary parodies and homages, pastiches, style parodies."
      "Parodies of the fantasy novel series Harry Potter in the style of various famous authors:"
      "By Ernest Hemingway:"
      "It was a cold day on Privet Drive. A child cried. Harry felt nothing.";
  String chatBotPrompt =
      "The following is a conversation with an AI assistant. The assistant is helpful, creative, clever, and very friendly."
      "Human: Hello, who are you?\n"
      "AI: I am an AI created by OpenAI. How can I help you today?";
  String chatBotPrompt2 =
      "The following is a conversation with an AI story teller. The story teller tells hilarious, creative and clever short stories."
      "Human: Hello, who are you?\n"
      "AI: I am an AI created by OpenAI. I tell stories.";

  // Holds messages
  List<Message> messages = [];

  // Constructs message prompts
  void sendMessage(String message) async {
    // Sets the structure for AI to follow and allows for AI to have memory of previous message
    chatBotPrompt2 += "\n"
        "Human: $message\n"
        "AI:";

    textEditingController.text = '';
    setState(() {
      messages.add(Message(message, true));
    });

    // Connects to OpenAI API using the davinci model
    var result = await http.post(
      Uri.parse('https://api.openai.com/v1/engines/davinci/completions'),
      headers: {
        'Authorization': 'Bearer $OPENAI_KEY',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'prompt': chatBotPrompt2,
        'max_tokens': 200,
        'temperature': .7,
        'top_p': 1,
        'stop': '\n',
      }),
    );

    //print(result.body);

    // Decodes json response and extracts AI's text
    var body = jsonDecode(result.body);
    text = body['choices'][0]['text'];
    // setState(() {
    //   text = body['choices'][0]['text'];
    // });

    // Adds text back into the prompt
    chatBotPrompt2 += text;

    setState(() {
      messages.add(Message(text.trim(), false));
    });

    //print(text);
  }

  // Saves a screenshot to local storage
  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();

    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = 'screenshot_$time';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);

    return result['filePath'];
  }

  // Shares screenshot. Does not work
  // Future shareImage(Uint8List bytes) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final image = await File('${directory.path}/flutter.png');
  //
  //   Share.shareFiles([image.path]);
  // }

  // Determines what function to run based on what was selected in dropdown applet
  void onSelected(BuildContext context, int item) async {
    switch (item) {
      case 0: // Navigates to settings page
        Navigator.pushNamed(context, '/second');
        break;
      case 1: // Saves screenshot
        print('Saving...');

        final image = await screenController.capture();
        if (image == null) return;
        await saveImage(image);

        print('Saved!');
        break;
      case 2: // Shares screenshot. This does not work, will have to work on it more inorder to implement.
        print('Sharing...');

        // final image = await screenController.capture();
        // if (image == null) return;
        // await shareImage(image);

        print('Shared!');
        break;
      case 3: // Navigates to readme page
        Navigator.pushNamed(context, '/third');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenController,
      child: Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.blue.shade700,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/spacemoon_backround.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: const Text('OpenAI Demo'),
          actions: [
            // Popup menu buttons that appear in appbar
            PopupMenuButton<int>(
              color: Colors.white,
              onSelected: (item) async => onSelected(context, item),
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'Settings',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(
                        Icons.save,
                        color: Colors.red.shade500,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text('Save', style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
                PopupMenuItem<int>(
                  value: 2,
                  child: Row(
                    children: [
                      Icon(
                        Icons.share,
                        color: Colors.blue.shade600,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text('Share',
                          style: const TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
                PopupMenuItem<int>(
                  value: 3,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.menu_book,
                        color: Colors.brown,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Instructions',
                          style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ],
            )
          ],
          //backgroundColor: Colors.deepPurple,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                reverse: true,  // Shows messages in reverse order
                padding: const EdgeInsets.all(20.0),
                children: messages.reversed.map((message) { // updates messages in reverse order so you see most recent message
                  // Creates chat bubbles of the messages
                  return Bubble(
                    color: message.byMe ? Colors.lightBlue : Colors.lightGreen, // Changes color of chat bubble based on who's message it is
                    nip: message.byMe // Determines if the chat bubble should be pointing left or right based on who sent the message
                        ? BubbleNip.rightBottom
                        : BubbleNip.leftBottom,
                    alignment:
                        message.byMe ? Alignment.topRight : Alignment.topLeft,
                    margin: const BubbleEdges.symmetric(vertical: 5),
                    child: Text(
                      message.text,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 17),
                    ),
                  );
                }).toList(),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(hintText: "Messasge"),
                        onSubmitted: sendMessage,
                        controller: textEditingController,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      color: Colors.blue.shade700,
                      onPressed: () {
                        sendMessage(textEditingController.text);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
