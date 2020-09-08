import 'package:flutter/material.dart';

class NoNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '\"If you give people nothingness, they can ponder what can be achieved from that nothingness\"',
            style: TextStyle(
              color: Colors.grey,
              fontStyle: FontStyle.italic,
              fontSize: 18,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: Text(
              '-Tadao Ando',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
