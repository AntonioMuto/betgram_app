import 'package:betgram_app/Utility/TextFacility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitRing(color: Colors.white),
          Text(
            'Caricamento...',
            style: TextFacility.getBoldStyleText(20),
          ),
        ],
      ),
    );
  }
}
