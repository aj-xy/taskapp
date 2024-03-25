import 'package:flutter/material.dart';

class display extends StatelessWidget {
  var user;
   display({this.user,super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: 600,
              width: 400,
              child: Column(
                        children: [
                          Text(user['Title']),
                          Text(user['Task'])
                        ],
                      )
                    
                  )
            
          ],
        )),
      ),
    );
  }
}
