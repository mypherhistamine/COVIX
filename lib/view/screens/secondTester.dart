import 'package:COVIX/controller/locationController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnotherScreen extends StatelessWidget {
  final TesterController c = Get.find();

  @override
  Widget build(BuildContext context) {
    // print('run again');
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => Text('Count is ${c.count}')),
              RaisedButton(
                onPressed: () {
                  c.reset();
                },
                child: Text('Reeeeset'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
