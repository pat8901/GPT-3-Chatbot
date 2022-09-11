import 'package:flutter/material.dart';

class ReadMe extends StatelessWidget {
  ReadMe({Key? key}) : super(key: key);

  String instructions = '                   Welcome to OpenAI Demo!\n'
      '\nThe AI used in this project is GPT-3 using the davinci model.\n'
      '\nThe AI specializes in telling stories, but can also talk about a variety of subjects.\n'
      '\nFor the AI to tell a story ask, "Tell me a story about ____ and make it ____."\n'
      '\nIf you want the AI to change the story you can ask, "Tell me a different story about ____."\n'
      '\nSometimes the AI responds in short sentences. For the story to continue just ask the AI to continue or inquire about the subject at hand.\n';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Instructions"),
        //backgroundColor: Colors.deepPurple,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/spacemoon_backround.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      instructions,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: 40,
                      style: const TextStyle(
                        fontFamily: 'roboto',
                        fontSize: 17,
                        //color: Colors.white,
                        //fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
