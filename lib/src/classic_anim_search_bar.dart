import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Classic animated search bar with smooth rotation animations
/// This is the original implementation with beautiful icon rotation effects
class ClassicAnimSearchBar extends StatefulWidget {
  /// Classic animated search bar with smooth animations and icon rotations
  ///
  /// Required parameters:
  /// - width: double - Width of the expanded search bar
  /// - textController: TextEditingController - Controller for the text field
  /// - onSuffixTap: Function - Callback when suffix icon is tapped
  /// - onSubmitted: Function(String) - Callback when search is submitted

  final double width;
  final TextEditingController textController;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final String helpText;
  final int animationDurationInMilli;
  final VoidCallback onSuffixTap;
  final bool rtl;
  final bool autoFocus;
  final TextStyle? style;
  final bool closeSearchOnSuffixTap;
  final Color? color;
  final Color? textFieldColor;
  final Color? searchIconColor;
  final Color? textFieldIconColor;
  final List<TextInputFormatter>? inputFormatters;
  final bool boxShadow;
  final Function(String) onSubmitted;
  final Color? prefixIconBackgroundColor;
  final bool hidePrefixIconBackground;

  const ClassicAnimSearchBar({
    super.key,
    required this.width,
    required this.textController,
    this.suffixIcon,
    this.prefixIcon,
    this.helpText = "Search...",
    this.color = Colors.white,
    this.textFieldColor = Colors.white,
    this.searchIconColor = Colors.black,
    this.textFieldIconColor = Colors.black,
    required this.onSuffixTap,
    this.animationDurationInMilli = 375,
    required this.onSubmitted,
    this.rtl = false,
    this.autoFocus = false,
    this.style,
    this.closeSearchOnSuffixTap = false,
    this.boxShadow = true,
    this.inputFormatters,
    this.prefixIconBackgroundColor,
    this.hidePrefixIconBackground = false,
  });

  @override
  State<ClassicAnimSearchBar> createState() => _ClassicAnimSearchBarState();
}

class _ClassicAnimSearchBarState extends State<ClassicAnimSearchBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  FocusNode focusNode = FocusNode();
  bool _isExpanded = false;
  String _textFieldValue = '';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.animationDurationInMilli),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _unfocusKeyboard() {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  void _toggleSearchBar() {
    setState(() {
      if (!_isExpanded) {
        _isExpanded = true;
        _animationController.forward();
        if (widget.autoFocus) {
          FocusScope.of(context).requestFocus(focusNode);
        }
      } else {
        _isExpanded = false;
        _animationController.reverse();
        if (widget.autoFocus) _unfocusKeyboard();
      }
    });
  }

  void _handleSuffixTap() {
    try {
      widget.onSuffixTap();

      if (_textFieldValue.isEmpty) {
        _unfocusKeyboard();
        setState(() {
          _isExpanded = false;
        });
        _animationController.reverse();
      }

      widget.textController.clear();
      _textFieldValue = '';

      if (widget.closeSearchOnSuffixTap) {
        _unfocusKeyboard();
        setState(() {
          _isExpanded = false;
        });
        _animationController.reverse();
      }
    } catch (e) {
      debugPrint('Error in suffix tap: $e');
    }
  }

  void _handleSubmitted(String value) {
    widget.onSubmitted(value);
    _unfocusKeyboard();
    setState(() {
      _isExpanded = false;
    });
    _animationController.reverse();
    widget.textController.clear();
    _textFieldValue = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      alignment: widget.rtl ? Alignment.centerRight : Alignment(-1.0, 0.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: widget.animationDurationInMilli),
        height: 48.0,
        width: _isExpanded ? widget.width : 48.0,
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: _isExpanded ? widget.textFieldColor : widget.color,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: !widget.boxShadow
              ? null
              : [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: -10.0,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  ),
                ],
        ),
        child: Stack(
          children: [_buildSuffixIcon(), _buildTextField(), _buildPrefixIcon()],
        ),
      ),
    );
  }

  Widget _buildSuffixIcon() {
    return AnimatedPositioned(
      duration: Duration(milliseconds: widget.animationDurationInMilli),
      top: 6.0,
      right: widget.rtl ? null : 7.0,
      left: widget.rtl ? 7.0 : null,
      curve: Curves.easeOut,
      child: AnimatedOpacity(
        opacity: _isExpanded ? 1.0 : 0.0,
        duration: Duration(milliseconds: 200),
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.rotate(
                angle: _animationController.value * 2.0 * pi,
                child: GestureDetector(
                  onTap: _handleSuffixTap,
                  child:
                      widget.suffixIcon ??
                      Icon(
                        Icons.close,
                        size: 20.0,
                        color: widget.textFieldIconColor,
                      ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return AnimatedPositioned(
      duration: Duration(milliseconds: widget.animationDurationInMilli),
      left: widget.rtl ? null : (_isExpanded ? 40.0 : 20.0),
      right: widget.rtl ? (_isExpanded ? 40.0 : 20.0) : null,
      curve: Curves.easeOut,
      top: 11.0,
      child: AnimatedOpacity(
        opacity: _isExpanded ? 1.0 : 0.0,
        duration: Duration(milliseconds: 200),
        child: Container(
          padding: const EdgeInsetsDirectional.only(start: 10),
          alignment: Alignment.topCenter,
          width: widget.width / 1.7,
          child: TextField(
            controller: widget.textController,
            inputFormatters: widget.inputFormatters,
            focusNode: focusNode,
            cursorRadius: Radius.circular(10.0),
            cursorWidth: 2.0,
            onChanged: (value) {
              setState(() {
                _textFieldValue = value;
              });
            },
            onSubmitted: _handleSubmitted,
            onEditingComplete: () {
              _unfocusKeyboard();
              setState(() {
                _isExpanded = false;
              });
              _animationController.reverse();
            },
            style: widget.style ?? TextStyle(color: Colors.black),
            cursorColor: Colors.black,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(bottom: 5),
              isDense: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: widget.helpText,
              labelStyle: TextStyle(
                color: Color(0xff5B5B5B),
                fontSize: 17.0,
                fontWeight: FontWeight.w500,
              ),
              alignLabelWithHint: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPrefixIcon() {
    // Determine background color
    Color backgroundColor;
    if (widget.hidePrefixIconBackground) {
      backgroundColor = Colors.transparent;
    } else if (widget.prefixIconBackgroundColor != null) {
      backgroundColor = widget.prefixIconBackgroundColor!;
    } else {
      backgroundColor = _isExpanded ? widget.textFieldColor! : widget.color!;
    }

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(30.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(30.0),
        onTap: _toggleSearchBar,
        child: Container(
          width: 48.0,
          height: 48.0,
          alignment: Alignment.center, // Center the icon properly
          child: widget.prefixIcon != null
              ? _isExpanded
                    ? Icon(
                        Icons.arrow_back_ios,
                        color: widget.textFieldIconColor,
                        size: 20.0,
                      )
                    : widget.prefixIcon!
              : Icon(
                  _isExpanded ? Icons.arrow_back_ios : Icons.search,
                  color: _isExpanded
                      ? widget.textFieldIconColor
                      : widget.searchIconColor,
                  size: 20.0,
                ),
        ),
      ),
    );
  }
}
