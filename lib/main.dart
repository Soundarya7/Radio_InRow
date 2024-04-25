import 'package:flutter/material.dart';
import 'package:date_formatter/date_formatter.dart';
import 'package:toggle_switch/toggle_switch.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Bank Form'),
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
  TextEditingController _edtxtName = TextEditingController();
  TextEditingController _edtxtAge = TextEditingController();

  String _res ="";
  int _Age=15;
  int _SelectedRadio = 0;
  String sDate ="";

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
        body: Container(
            padding: EdgeInsets.all(32.0),
            child: Center(
                child: Column(
                  children: [Image.asset('images/flutter.jpg',height: 100,width: 100,),
                    
                    Row(children: [ const Text("Name",style: TextStyle(fontSize: 18,color: Colors.pink)),
                      Expanded(child: TextField(controller: _edtxtName))],),
                    SizedBox(height: 10),
                    Row(children: [ const Text("AGE",style: TextStyle(fontSize: 18,color: Colors.pink)),
                      IconButton(onPressed: addAge, icon: Icon(Icons.add)),
                      Text(_res),
                      IconButton(onPressed: removeAge, icon: Icon(Icons.remove)),],),
                    SizedBox(height: 10),
                    Row(children: [TextButton(onPressed: onPressedDate, child:Text("DOB")),Expanded(child:Text(sDate))],),
                    SizedBox(height: 10),
                     Container(child: Row(children: [Text("Gender",style: TextStyle(fontSize: 18,color: Colors.pink)),  makeRadiosListTile(), ],),), // Row
                      //Error Throwing here

                   /*(children: [Text("Gender",style: TextStyle(fontSize: 18,color: Colors.pink)),
                     Expanded(child:  RadioListTile(value: 0, groupValue: 0, onChanged: _setSelectedRadio,title: Text('Male'))),
                      Expanded(child:  RadioListTile(value: 1, groupValue: 0, onChanged: _setSelectedRadio,title: Text('FeMale'),)),
                    ],)*/

                    const Row(children: [Text("Education",style: TextStyle(fontSize: 18,color: Colors.blue)), ],), // Row
                    SizedBox(height: 10),
                    Row(children: [Text("Married?",style: TextStyle(fontSize: 18,color: Colors.blue)), ToggleSwitch(
                      customWidths: [90.0, 50.0],
                      cornerRadius: 20.0,
                      activeBgColors: [[Colors.cyan], [Colors.redAccent]],
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      totalSwitches: 2,
                      labels: ['YES', 'NO'],
                      onToggle: (index) {
                        print('switched to: $index');
                      },
                    ),
                    ],),



                   ],)
            )
        )
    );
  }

  void addAge(){
    setState(() {
      _Age++;
      _res = _Age.toString();
    });
  }
  void removeAge(){
    setState(() {
      _Age--;
      _res = _Age.toString();
    });
  }

  Future onPressedDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime(1992),
        lastDate: DateTime(2099),
        initialDate: DateTime.now());
    if (picked != null) {
      setState(() {
        //sDate = picked.toString();
        sDate= DateFormatter.formatDateTime(dateTime: picked,outputFormat: 'dd/MM/yyyy',);
      });
    }
  }


  Widget makeRadiosListTile(){
    List<Widget>list=[];
    for(int i=0;i<3;i++){

      list.add(RadioListTile(value:i,groupValue:_SelectedRadio,
          onChanged: _setSelectedRadio,subtitle: Text('sub Title'),title:Text("item $i")));
    }
    Row column=Row(children:list);
    return column;
  }
  void _setSelectedRadio(int?SelectedRadio){setState(() {
    _SelectedRadio=SelectedRadio!;
  });
  }
}
