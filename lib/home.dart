import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FisicaUmg'),
      ),
      body: Column(
        children: [
          Container(
            width: 500,
            height: 200,
            padding: EdgeInsets.all(10),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              color: Colors.white,
              elevation: 15,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTile(  
                    leading:  Icon(Icons.calculate, size: 60, color: Colors.redAccent),  
                    title: Text(  
                      'Problema 1',  
                      style: TextStyle(fontSize: 30.0)  
                    ),  
                    subtitle: Text(  
                      'Una pelota se deja caer, a un piso con una velocidad de v1 = 23.',  
                      style: TextStyle(fontSize: 18.0)  
                    ),  
                  ),
                  SizedBox(),
                  ButtonBar(  
                    alignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[  
                    Container(
                      child: ElevatedButton(
                          
                        child: Text('Play'),  
                        onPressed: () {/* ... */},  
                      ),
                    ),  
                    Container(
                      color: Colors.yellow,
                      child: ElevatedButton(
                          
                        child: Text('Pause'),  
                        onPressed: () {/* ... */},  
                      ),
                    ),  
                  ],  
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

