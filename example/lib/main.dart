import 'package:flutter/material.dart';
import 'package:responsivebility/responsivebility.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsivebility.of(
      context,
      range: ResponsiveRange({
        360: 24,
        500: 48,
        800: 65,
      }),
      breakpointSize: (size, visualDensity) {
        return size.width;
      },
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        toolbarHeight: responsive.size(
          range: ResponsiveRange({
            360: kToolbarHeight,
            800: 100,
          }),
        ),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(
              // This will return a value between 24 and 48.
              // It'll have a value that is linear interpolated between 360 and 800
              // depending upon the screen's shortest width (by default).
              size: responsive.size(
                range: ResponsiveRange({
                  360: 24,
                  500: 48,
                }),
              ),
              // Change properties based on conditions
              style: responsive.valueOf<FlutterLogoStyle>(
                when: (size) {
                  if (size > 80) return FlutterLogoStyle.horizontal;
                  if (size > kToolbarHeight) return FlutterLogoStyle.stacked;
                  return FlutterLogoStyle.markOnly;
                },
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ActionButton(responsive: responsive),
          ),
        ],
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.responsive,
  });

  final Responsivebility responsive;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          // This will return a value between 24 and 48.
          // It'll have a value that is linear interpolated between 360 and 800
          // depending upon the screen's shortest width (by default).
          height: responsive.size(
            range: ResponsiveRange({
              360: 24,
              500: 48,
            }),
          ),
          width: responsive.size(
            range: ResponsiveRange({
              360: 24,
              500: 48,
            }),
          ),
          // Change properties based on conditions
          color: responsive.valueOf<Color>(
            when: (size) {
              if (size > 80) return Colors.red;
              if (size > kToolbarHeight) return Colors.orange;
              return Colors.blue;
            },
          ),
        ),
      ],
    );
  }
}
