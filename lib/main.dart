import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Homebrew note editor",
      home: ListPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
List<NoteModel> all =[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(child: Icon(Icons.create),
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>EditPage())).then(
          (note){
            setState(() {
             all.add(note) ;
            });
          }
        );
      },),
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: all.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(all[index].title),
            subtitle: Text(all[index].text),
            onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>EditPage(all[index])));
            },
            trailing: IconButton(icon: Icon(Icons.delete), onPressed: () {
              setState(() {
               all.removeAt(index);
              });
              }, ),
          );
        }
    )
      );
      
  }
}

class NoteModel{
  String text;
  String title;

  NoteModel({this.title="", this.text=""});
}

class EditPage extends StatefulWidget {
    NoteModel note;
    EditPage({this.note});
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
TextEditingController _titleContr;
TextEditingController _textContr;
  bool editable = false;
  
  @override
  void initState() {
    super.initState();
    _titleContr = TextEditingController(text: widget.note.title);
    _textContr = TextEditingController(text: widget.note.text);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
         crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(controller: _titleContr, onChanged: (String t){
            widget.note.title = t; 
          }),
           TextField(controller: _textContr, onChanged: (String tt){
            widget.note.text = tt;
           }),
           FloatingActionButton(child: Icon(Icons.save) ,onPressed: () {
            Navigator.pop(context, widget.note);
          }, ),
          ],
      ),
    );
  }
}

