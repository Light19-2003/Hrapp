import 'package:flutter/material.dart';
import 'package:hrapp/view/pages/Leavebalance.dart';

class Balancescreen extends StatelessWidget {
  const Balancescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text(
          "Leave Balance",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        elevation: 5,
        excludeHeaderSemantics: true,
        centerTitle: true,
      ),
      body: Leavebulider(),
    );
  }
}
