import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ThemeData.dark().colorScheme,
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
          bodyText2: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
          headline1: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
          headline2: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          headline3: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          headline4: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          headline5: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          headline6: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const TutorialScreen(),
        '/main': (context) => const MainScreen(),
      },
    );
  }
}

List<bool> isOnThisPage = [true, false, false, false, false];
List<String> pageTitle = [
  'Tutorial page 1',
  'Tutorial page 2',
  'Tutorial page 3',
  'Tutorial page 4',
  'Tutorial page 5',
];

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({Key? key}) : super(key: key);

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> with TickerProviderStateMixin {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  void _onPageViewChange(int value) {
    int indexOfTrue = isOnThisPage.indexOf(true);
    isOnThisPage[indexOfTrue] = false;
    setState(() {
      isOnThisPage[value] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageViewChange,
            itemCount: pageTitle.length,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Center(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          pageTitle.elementAt(
                            index,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {
                            _pageController.animateToPage(index + 1,
                                duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                          },
                          icon: const Icon(Icons.keyboard_arrow_right_sharp),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (index == pageTitle.length - 1) {
                return Center(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          pageTitle.elementAt(
                            index,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {
                            _pageController.animateToPage(index - 1,
                                duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                          },
                          icon: const Icon(
                            Icons.keyboard_arrow_left_sharp,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            child: const Text(
                              'I understood',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/main');
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {
                            _pageController.animateToPage(index - 1,
                                duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                          },
                          icon: const Icon(Icons.keyboard_arrow_left_sharp),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          pageTitle.elementAt(
                            index,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {
                            _pageController.animateToPage(index + 1,
                                duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                          },
                          icon: const Icon(Icons.keyboard_arrow_right_sharp),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: size.height * 0.2,
              child: Wrap(
                children: [
                  for (int i = 0; i < pageTitle.length; i++) ...{
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(
                        isOnThisPage.elementAt(i) ? Icons.circle_outlined : Icons.circle_sharp,
                        size: size.height * 0.0225,
                      ),
                    ),
                  },
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade900,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Home Screen',
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: const Center(
          child: Text(
            'Your main page',
            style: TextStyle(
              fontSize: 26,
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(12.0),
          child: FloatingActionButton(
            backgroundColor: Colors.deepOrange,
            child: const Icon(
              Icons.chevron_left_sharp,
              size: 32,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
