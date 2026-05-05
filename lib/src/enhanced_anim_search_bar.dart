import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EnhancedAnimSearchBar extends StatefulWidget {
  /// Enhanced animated search bar with gradient background and fade effects
  ///
  /// Required parameters:
  /// - width: double - Width of the expanded search bar
  /// - textController: TextEditingController - Controller for the text field
  /// - onSuffixTap: Function - Callback when suffix icon is tapped
  /// - onSubmitted: Function(String) - Callback when search is submitted
  ///
  /// Optional parameters with enhanced features:
  /// - gradientColors: List<Color> - Colors for gradient background
  /// - fadeAnimation: bool - Enable fade animation effects
  /// - glowEffect: bool - Enable glow effect around the search bar
  /// - borderGradient: bool - Enable gradient border
  /// - pulseAnimation: bool - Enable pulse animation on focus

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

  // Enhanced features
  final List<Color> gradientColors;
  final bool fadeAnimation;
  final bool glowEffect;
  final bool borderGradient;
  final bool pulseAnimation;
  final double borderWidth;
  final double glowRadius;
  final double pulseScale;
  final Color? prefixIconBackgroundColor;
  final bool hidePrefixIconBackground;

  const EnhancedAnimSearchBar({
    super.key,
    required this.width,
    required this.textController,
    required this.onSuffixTap,
    required this.onSubmitted,
    this.suffixIcon,
    this.prefixIcon,
    this.helpText = "Search...",
    this.color = Colors.white,
    this.textFieldColor = Colors.white,
    this.searchIconColor = Colors.black,
    this.textFieldIconColor = Colors.black,
    this.animationDurationInMilli = 375,
    this.rtl = false,
    this.autoFocus = false,
    this.style,
    this.closeSearchOnSuffixTap = false,
    this.boxShadow = true,
    this.inputFormatters,
    // Enhanced features with defaults
    this.gradientColors = const [
      Color(0xFF667eea),
      Color(0xFF764ba2),
      Color(0xFFf093fb),
    ],
    this.fadeAnimation = true,
    this.glowEffect = true,
    this.borderGradient = true,
    this.pulseAnimation = true,
    this.borderWidth = 2.0,
    this.glowRadius = 20.0,
    this.pulseScale = 1.1,
    this.prefixIconBackgroundColor,
    this.hidePrefixIconBackground = false,
  });

  @override
  State<EnhancedAnimSearchBar> createState() => _EnhancedAnimSearchBarState();
}

class _EnhancedAnimSearchBarState extends State<EnhancedAnimSearchBar>
    with TickerProviderStateMixin {
  late AnimationController _expandController;
  late AnimationController _fadeController;
  late AnimationController _pulseController;
  late AnimationController _rotationController;

  late Animation<double> _expandAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotationAnimation;

  FocusNode focusNode = FocusNode();
  bool _isExpanded = false;
  String _textFieldValue = '';

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _setupFocusListener();
  }

  void _initializeAnimations() {
    // Main expand/collapse animation
    _expandController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.animationDurationInMilli),
    );
    _expandAnimation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeInOut,
    );

    // Fade animation for enhanced effects
    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );

    // Pulse animation for focus effect
    _pulseController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: widget.pulseScale).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Rotation animation for suffix icon
    _rotationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.animationDurationInMilli),
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 2.0 * pi).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.easeInOut),
    );
  }

  void _setupFocusListener() {
    focusNode.addListener(() {
      if (widget.pulseAnimation) {
        if (focusNode.hasFocus) {
          _pulseController.repeat(reverse: true);
        } else {
          _pulseController.stop();
          _pulseController.reset();
        }
      }
    });
  }

  @override
  void dispose() {
    _expandController.dispose();
    _fadeController.dispose();
    _pulseController.dispose();
    _rotationController.dispose();
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
        _expandController.forward();
        if (widget.fadeAnimation) _fadeController.forward();
        if (widget.autoFocus) {
          FocusScope.of(context).requestFocus(focusNode);
        }
      } else {
        _isExpanded = false;
        _expandController.reverse();
        if (widget.fadeAnimation) _expandController.reverse();
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
        _expandController.reverse();
        if (widget.fadeAnimation) _fadeController.reverse();
      }

      widget.textController.clear();
      _textFieldValue = '';

      if (widget.closeSearchOnSuffixTap) {
        _unfocusKeyboard();
        setState(() {
          _isExpanded = false;
        });
        _expandController.reverse();
        if (widget.fadeAnimation) _fadeController.reverse();
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
    _expandController.reverse();
    if (widget.fadeAnimation) _fadeController.reverse();
    widget.textController.clear();
    _textFieldValue = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      alignment: widget.rtl ? Alignment.centerRight : Alignment(-1.0, 0.0),
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _expandAnimation,
          _fadeAnimation,
          _pulseAnimation,
        ]),
        builder: (context, child) {
          return Transform.scale(
            scale: widget.pulseAnimation && focusNode.hasFocus
                ? _pulseAnimation.value
                : 1.0,
            child: _buildSearchBarContainer(),
          );
        },
      ),
    );
  }

  Widget _buildSearchBarContainer() {
    return Container(
      height: 48.0,
      width: _isExpanded ? widget.width : 48.0,
      decoration: _buildContainerDecoration(),
      child: Stack(
        children: [_buildSuffixIcon(), _buildTextField(), _buildPrefixIcon()],
      ),
    );
  }

  BoxDecoration _buildContainerDecoration() {
    if (widget.borderGradient && _isExpanded) {
      return BoxDecoration(
        gradient: LinearGradient(
          colors: widget.gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: _buildBoxShadow(),
      );
    } else {
      return BoxDecoration(
        color: _isExpanded ? widget.textFieldColor : widget.color,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: _buildBoxShadow(),
        border: widget.borderGradient && _isExpanded
            ? Border.all(width: widget.borderWidth, color: Colors.transparent)
            : null,
      );
    }
  }

  List<BoxShadow>? _buildBoxShadow() {
    if (!widget.boxShadow) return null;

    List<BoxShadow> shadows = [
      BoxShadow(
        color: Colors.black26,
        spreadRadius: -10.0,
        blurRadius: 10.0,
        offset: Offset(0.0, 10.0),
      ),
    ];

    if (widget.glowEffect && _isExpanded) {
      shadows.add(
        BoxShadow(
          color: widget.gradientColors.first.withValues(alpha: 0.3),
          spreadRadius: 2.0,
          blurRadius: widget.glowRadius,
          offset: Offset(0.0, 0.0),
        ),
      );
    }

    return shadows;
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
            gradient: widget.borderGradient
                ? LinearGradient(
                    colors: widget.gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
          ),
          child: AnimatedBuilder(
            animation: _rotationAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationAnimation.value,
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
              _expandController.reverse();
              if (widget.fadeAnimation) _fadeController.reverse();
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
      child: Container(
        width: 48.0,
        height: 48.0,
        decoration:
            widget.borderGradient &&
                !_isExpanded &&
                !widget.hidePrefixIconBackground
            ? BoxDecoration(
                gradient: LinearGradient(
                  colors: widget.gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30.0),
              )
            : null,
        child: InkWell(
          borderRadius: BorderRadius.circular(30.0),
          onTap: _toggleSearchBar,
          child: Container(
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
      ),
    );
  }
}
