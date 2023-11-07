import 'package:flutter/material.dart';

class CircularButtonWidget extends StatelessWidget {
  const CircularButtonWidget({
    super.key, required this.textTitle,
  });
  final String textTitle;
  @override
  Widget build(BuildContext context) {
    return  Center(
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 4,
                )),
          ),
          const SizedBox(width: 30,),
          Text(textTitle,style: const TextStyle(
            color: Colors.white,
          ),),
        ],),
    );
  }
}