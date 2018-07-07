import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

@override
Widget build(BuildContext context){
  return new MaterialApp(
     title: "example_apps",
      home: MyRandomWord(),
      theme: new ThemeData(
        primaryColor: Colors.blue
      ),
  );
}
}

class MyRandomWord extends StatefulWidget {
  
  @override
  RandomState createState() => new RandomState();


}


class RandomState extends State<MyRandomWord>{

  final List<WordPair> _suggestion = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();
  final TextStyle _fontBig = const TextStyle( fontSize: 18.0);

  @override
  Widget build(BuildContext contex){
    return new Scaffold(
       appBar: new AppBar(
         title: const Text("MyApps"),
       ),
       body: _buildSuggestion() ,
    );
  }

  Widget _buildRow(WordPair pair){

    final bool alreadySaved = _saved.contains(pair);

    return ListTile(
       title: new Text(pair.asPascalCase, style: _fontBig,),
       trailing: new Icon(
         alreadySaved ? Icons.favorite : Icons.favorite_border,
         color: Colors.orange,
       ),
       onTap: () {
         setState(() {
                    if(alreadySaved){
                      _saved.remove(pair);                    
                    } else {
                      _saved.add(pair);
                    }
                  });
       },
    );
  }

  Widget _buildSuggestion(){
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (BuildContext context, int i){

        if(i.isOdd){
          return const Divider();
        }

        final int index = i ~/ 2;
        if(index >= _suggestion.length){
          _suggestion.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_suggestion[index]);



      },
    );
  }
}