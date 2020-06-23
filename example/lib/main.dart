import 'package:flutter/material.dart';
import 'package:native_draggable/native_draggable.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = GlobalKey<NativeDraggableState>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, dimens) {
        _controller?.currentState?.updateImage();
        print('dimens: $dimens');
        return Scaffold(
          appBar: AppBar(title: Text('Draggable Example')),
          body: Center(
            child: SizedBox.fromSize(
              size: const Size(100, 100),
              child: NativeDraggable(
                key: _controller,
                renderKey: 'flutter_logo',
                child: FlutterLogo(),
                feedback: PreferredSize(
                  preferredSize: const Size(100, 100),
                  child: FlutterLogo(textColor: Colors.red),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
