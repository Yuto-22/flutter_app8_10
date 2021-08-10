import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body:SlidePage(),
      ),
    );
  }
}



class SlidePage extends StatefulWidget {
  @override
  _SlideshowState createState() => _SlideshowState();
}


class _SlideshowState extends State<SlidePage> {

  final PageController controller = PageController(viewportFraction: 0.8);

  int currentPage = 0;
  final List<String> _imageList = [
    "assets/image01.png",
    "assets/image02.jpg"
  ];


  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      int next = controller.page!.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
  }

  AnimatedContainer _createCardAnimate(String imagePath, bool active) {
    final double top = active ? 100 : 200;
    final double side = active ? 0 : 40;

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top: top, bottom: 50.0, right: side, left: side),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: Image
              .asset(imagePath)
              .image,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            child: TextButton(
              onPressed: () {},
              child: Text("SKIP"),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: controller,
              itemCount: _imageList.length,
              itemBuilder: (context, int currentIndex){
                bool active = currentIndex == currentPage;
                return _createCardAnimate(
                  _imageList[currentIndex],
                  active,
                );
              },
            ),
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 100,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Sign up'),
                ),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Log in'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}