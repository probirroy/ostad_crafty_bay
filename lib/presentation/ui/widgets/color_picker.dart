import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({Key? key, required this.colors, required this.initialSelectedColor, required this.onSelectedColor}) : super(key: key);
  final List<Color>colors;
  final int initialSelectedColor;
  final Function (int index) onSelectedColor;
  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  int _selectedColorIndex = 0;

  @override
  void initState() {
    _selectedColorIndex = widget.initialSelectedColor;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: widget.colors.length,
      itemBuilder: (context,index){
        return InkWell(
          borderRadius: BorderRadius.circular(16.0),
          onTap: (){
            _selectedColorIndex = index;
            widget.onSelectedColor(index);
            if(mounted){
              setState(() {});
            }
          },
          child: CircleAvatar(
            radius: 18,
            backgroundColor: widget.colors[index],
            child: _selectedColorIndex == index ? const Icon(Icons.done,color: Colors.white,) : null,
          ),
        );
      }, separatorBuilder: (BuildContext context, int index) {
      return const SizedBox(width: 8.0);
    },
    );
  }
}
