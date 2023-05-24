import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: View1(),
    );
  }
}

// Object class
class MyObject {
  // String data;
  List<int> data;
  MyObject(this.data);
}

// View1
class View1 extends StatefulWidget {
  @override
  State<View1> createState() => _View1State();
}

class _View1State extends State<View1> {
  // MyObject object = MyObject([1, 2, 3, 4]);
  final View1ViewModel _viewModel = View1ViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                    scrollDirection: Axis.vertical,
                    children: _viewModel.object.data
                        .map((e) => Text('DATA : ${e}'))
                        .toList()),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => View2(
                        object: _viewModel.object,
                        onUpdateDataView1: () {
                          setState(() {});
                        },
                      ),
                    ),
                  );
                },
                child: const Text('To View 2'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class View1ViewModel extends ChangeNotifier {
  MyObject object = MyObject([1, 2, 3, 4]);
}

// View2
class View2 extends StatefulWidget {
  final MyObject object;
  final Function() onUpdateDataView1;

  View2({required this.object, required this.onUpdateDataView1});

  @override
  State<View2> createState() => _View2State();
}

class _View2State extends State<View2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                    scrollDirection: Axis.vertical,
                    children: widget.object.data
                        .map((e) => Text('DATA : ${e}'))
                        .toList()),
              ),
              Text(
                'HELLO',
                style: TextStyle(fontSize: 50.0),
              ),
              ElevatedButton(
                onPressed: () {
                  widget.object.data[0] = 100;
                  widget.onUpdateDataView1();
                  setState(() {});
                },
                child: Text('Update Object Data'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Update the data in view2
                },
                child: Text('Back To View 1'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => View3(
                        object: widget.object,
                        onUpdateDataView2: () {
                          widget.onUpdateDataView1();
                          setState(() {});
                        },
                      ),
                    ),
                  );
                },
                child: const Text('To View 3'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class View3 extends StatefulWidget {
  final MyObject object;
  final Function() onUpdateDataView2;

  View3({required this.object, required this.onUpdateDataView2});

  @override
  State<View3> createState() => _View3State();
}

class _View3State extends State<View3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                    scrollDirection: Axis.vertical,
                    children: widget.object.data
                        .map((e) => Text('DATA : ${e}'))
                        .toList()),
              ),
              ElevatedButton(
                onPressed: () {
                  widget.object.data[0] = 300;
                  widget.onUpdateDataView2();
                  setState(() {});
                },
                child: Text('Update Object Data'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Update the data in view2
                },
                child: Text('Back To View 2'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => View1(),
                  //   ),
                  //   (route) => false,
                  // ); // Update the data in view2
                },
                child: Text('Back To View 1'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
