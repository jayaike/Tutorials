import 'dart:math';

import 'package:flutter/material.dart';


double _kFontSize = 18.0;
double _kHeight = 2.0;
double _kLineHeight = _kFontSize * _kHeight;
double _kInitialHeight = _kLineHeight * 5;


class PaperField extends StatefulWidget {
  final String initialText;

  PaperField({this.initialText});

  @override
  State<StatefulWidget> createState() {
    return _PaperFieldState();
  }
}

class _PaperFieldState extends State<PaperField> {
  GlobalKey _textFieldKey;
  TextEditingController _controller;
  double lastKnownHeight = _kInitialHeight;

  @override
  initState() {
    super.initState();
    _textFieldKey = GlobalKey();
    _controller = new TextEditingController();
    _controller.text = widget.initialText;
  
    // Wait for all widgets to be drawn before 
    WidgetsBinding.instance.addPostFrameCallback((_) => _setLastKnownHeight());
  }


  void _setLastKnownHeight() {
    final RenderBox renderBoxTextField = _textFieldKey.currentContext.findRenderObject();
    final size = renderBoxTextField.size;

    if (lastKnownHeight != size.height) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Causes the widget to rebuild
        // (so the lines get redrawn)
        setState(() {
          lastKnownHeight = size.height;
        });
      });
    }
  }


  Widget _buildLines() {
    // Calculate the number of lines that need to be built
    int nLines = max(_kInitialHeight, lastKnownHeight) ~/ _kLineHeight;

    return Column(
      children: List.generate(
        nLines,
        (index) => Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: Colors.grey[400]
              )
            )
          ),
          height: _kLineHeight,
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Stack(
            children: [
              // Add before TextField so it appears under it
              _buildLines(),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: _kInitialHeight,
                ),
                child: Container(
                  child: NotificationListener<SizeChangedLayoutNotification>(
                    onNotification: (SizeChangedLayoutNotification notification) {
                      // Set the new TextField height whenever it changes
                      _setLastKnownHeight();
                      return true;
                    },
                    child: SizeChangedLayoutNotifier( // Listen for when the TextField's height changes
                      child: TextField(
                        key: _textFieldKey,
                        controller: _controller,
                        cursorHeight: _kLineHeight * 0.6,
                        cursorWidth: 4,
                        maxLines: null,
                        decoration: _inputDecoration(),
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                          fontSize: _kFontSize,
                          height: _kHeight,
                          color: Colors.grey[600]
                        ),
                      ),
                    ),
                  ),
                )
              ),
            ]
          ),
        ]
      )
    );
  }
  
  // Flatten out and "plainify" the TextField so it doesn't have any
  // unwanted dimensions. VERY IMPORTANT!
  InputDecoration _inputDecoration() {
    return InputDecoration(
      contentPadding: EdgeInsets.zero,
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      errorBorder: InputBorder.none
    );
  }
}
