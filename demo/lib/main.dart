import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pulltorefresh/pulltorefresh.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Pulltorefresh Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Pulltorefresh'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool loading,refreshing;

  List<Widget> _getDatas(){
    List<Widget> data = [];
    for(int i = 0;i<25;i++){
      data.add(new Text('Data $i'));
    }
    return data;
  }

  Widget _buildHeader(context,mode){
    return new Container(
      height: 50.0,
      alignment: Alignment.center,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const CupertinoActivityIndicator(),
          new Text(mode == RefreshMode.canRefresh
              ? 'Refresh when releaseaa'
              : mode == RefreshMode.completed
              ? 'Refresh Completed'
              : mode == RefreshMode.refreshing
              ? 'Refreshing....'
              : 'pull down refresh')
        ],
      ),
    );
  }

  void _onLoadMore(){
    setState(() {
      loading = true;
    });
    new Future<Null>.delayed(const Duration(milliseconds: 2000),(){

      return null;
    }).then((Null val){
      setState(() {
        loading = false;
      });
      print("LoadComplete!!!");
    });

  }

  void _onRefresh(){
    setState(() {
      refreshing = true;
    });
    new Future.delayed(const Duration(milliseconds: 2000),(){
      setState(() {
        refreshing = false;
      });
      print("Refreshed!!!");
    });

  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: new SmartRefresher(
        headerBuilder: _buildHeader,
        footerBuilder: _buildHeader,
        refreshing: this.refreshing,
        loading: this.loading,
        completDuration: 10000,
        child: new Container(
          color: const Color(0xffffffff),
          child: new ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemExtent: 40.0,
              children: _getDatas()
          ),
        ),
        onRefresh: _onRefresh,
        onLoadmore: _onLoadMore,
      )
    );
  }
}
