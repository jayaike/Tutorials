import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:listanimations/klasses_body.dart';
import 'package:listanimations/klasses_list_row.dart';
import 'package:listanimations/state/klass.dart';
import 'package:listanimations/state/klass_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<KlassListState>(
      create: (_) => KlassListState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: GoogleFonts.quicksand().fontFamily
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  ScrollController scrollController;
  AnimationController animationController;
  Animation transformAnimation;
  Animation opacityAnimation;

  @override
  void initState() {
    // Initialise `scrollController`
    scrollController = ScrollController();

    // Initialise `animationController`
    animationController =  AnimationController(
      vsync: this, duration: Duration(milliseconds: 200));

    // Add `animationController` to the Transform Animation
    transformAnimation = Matrix4Tween(
        begin: Matrix4.translationValues(0, 0, 0),
        end: Matrix4.translationValues(0, 300, 0)
    ).animate(animationController);

    // Add `animationController` to the Opacity Animation
    opacityAnimation = Tween<double>(begin: 1, end: 0)
        .animate(animationController);

    // Add listener to call `setState` during animation ***Required
    animationController.addListener(() => setState(() {}));

    super.initState();
  }

  void statusListener(AnimationStatus status, KlassState klass) {
      if(status == AnimationStatus.completed) {
        Provider
            .of<KlassListState>(context, listen: false)
            .selectedKlassId = klass.id;
        animationController.reverse();
      }
  }

  void onTabTapped(int index, KlassState klass) {
    final double center = 150 * index.toDouble() - (150 / 4) + 20;
    scrollController.animateTo(
      center,
      duration: Duration(milliseconds: 300), curve: Curves.easeIn
    );

    if(Provider
        .of<KlassListState>(context, listen: false)
        .selectedKlassId == klass.id) return;

    AnimationStatusListener listener = (AnimationStatus status) => statusListener(status, klass);

    animationController.addStatusListener(listener);
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            KlassesListRow(onTabTapped: onTabTapped, scrollController: scrollController),
            Expanded(
              child: KlassesBody(
                opacityAnimation: opacityAnimation,
                transformAnimation: transformAnimation,
              )
            )
          ],
        ),
      )
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
