import 'package:flutter/material.dart';

import '../../../shared/constants.dart';

class CartCounter extends StatefulWidget {
  const CartCounter({super.key});

  @override
  State<CartCounter> createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int numOfItem = 1;

  @override
  Widget build(BuildContext context) {
    return Row(

      children: <Widget>[
        SizedBox(width: kDefaultPaddin,),

        SizedBox(
          width: 40,
          height: 32,

          child: OutlinedButton(
            onPressed: () {
              if(numOfItem > 1){
                setState(() {
                  numOfItem--;
                });
              }
            },
            child: Icon(
              Icons.remove,
            ),
            style: OutlinedButton.styleFrom(padding: EdgeInsets.zero),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin /2),
          child: Text(
            numOfItem.toString().padLeft(2,"0"),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        SizedBox(
          width: 40,
          height: 32,

          child: OutlinedButton(
            onPressed: () {
              setState(() {
                numOfItem++;
              });
            },
            child: Icon(
              Icons.add,
            ),
            style: OutlinedButton.styleFrom(padding: EdgeInsets.zero),
          ),
        ),
      ],
    );
  }
}
