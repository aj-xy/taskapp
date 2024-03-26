import 'package:flutter/material.dart';

class display extends StatelessWidget {
  var user;
   display({this.user,super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor:  Color.fromRGBO(214, 238, 255, 1),
      appBar: AppBar(toolbarOpacity: 1,backgroundColor:  Color.fromRGBO(214, 238, 255, 1),),
      body: Center(
        child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                        children: [
              SizedBox(
                height: 600,
                width: 400,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              
                                Text(user['Title'],style:TextStyle(color:  Color.fromRGBO(0, 29, 74, 1),fontSize: 40,fontWeight: FontWeight.bold),),
                                
                            ],
                          ),
                          SizedBox(height: 40,),
                            Text(user['Task'],style: TextStyle(color: Color.fromRGBO(0, 29, 74, 1),fontSize: 20,))
                          ],
                        )
                      
                    )
              
                        ],
                      ),
            )),
      ),
    );
  }
}
