import 'package:ostad_crafty_bay/presentation/ui/utility/color_palette.dart';
import 'package:flutter/material.dart';

class SizePicker extends StatefulWidget {
  const SizePicker({Key? key, required this.sizes, required this.onSelectedSize, required this.initialSelectedSize}) : super(key: key);

  final List<String>sizes;
  final Function(int index) onSelectedSize;
  final int initialSelectedSize;

  @override
  State<SizePicker> createState() => _SizePickerState();
}

class _SizePickerState extends State<SizePicker> {
  int _selectedSizeIndex = 0;

  @override
  void initState() {
    _selectedSizeIndex = widget.initialSelectedSize;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: widget.sizes.length,
      itemBuilder: (context,index){
        return InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: (){
              _selectedSizeIndex =index;
              widget.onSelectedSize(index);
              if(mounted){
                setState(() {});
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4.0),
                color: _selectedSizeIndex == index ? AppColors.primaryColor : null,
              ),
              child: Text(widget.sizes[index],style: TextStyle(
                fontSize: _selectedSizeIndex == index ? 14 : null,
                fontWeight: _selectedSizeIndex == index ? FontWeight.bold : null,
                color: _selectedSizeIndex == index ? Colors.white : null,
              ),),
            )
        );
      }, separatorBuilder: (BuildContext context, int index) {
      return const SizedBox(width: 8.0);
    },
    );
  }
}