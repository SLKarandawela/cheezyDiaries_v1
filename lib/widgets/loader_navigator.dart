import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LoadingWidget extends StatelessWidget {
  final String imageAsset;
  final String loadingText;

  const LoadingWidget({
    Key? key,
    required this.imageAsset,
    required this.loadingText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imageAsset,
          width: 100.0,
          height: 100.0,
        ),
        SizedBox(height: 20.0),
        Text(
          loadingText,
          style: TextStyle(fontSize: 24.0),
        ),
        SizedBox(height: 20.0),
        CupertinoActivityIndicator(),
      ],
    );
  }
}

class LoadingPage extends StatefulWidget {
  final Widget nextPage;
  final String imageAsset;
  final String loadingText;

  const LoadingPage({
    Key? key,
    required this.nextPage,
    this.imageAsset = 'assets/images/my_image.png',
    this.loadingText = 'Loading...',
  }) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    // Wait for 3 seconds before navigating to the next page
    Future.delayed(Duration(seconds: 6)).then((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => widget.nextPage),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingWidget(
          imageAsset: widget.imageAsset,
          loadingText: widget.loadingText,
        ),
      ),
    );
  }
}


