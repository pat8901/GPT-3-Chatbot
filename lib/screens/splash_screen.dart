import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    navigateToHome(); // Calls splash screen function
  }

  // Shows splash screen for a specified amount of time and then redirects to root screen
  navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey.shade800,
      body: Container(
        //Could be better if  it was 'Stack'?
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/spacemoon_backround.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 250,
                width: 250,
                //color: Colors.blue,
                child: Image.asset('images/pikachu_running.gif'),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                //color: Colors.red,
                child: const Text(
                  'OpenAI Demo',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Container(
                    child: const CircularProgressIndicator(
                      color: Color(0xff8f79c1),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Loading',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
