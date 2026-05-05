// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:search_bar_animated_master/search_bar_animated_master.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search Bar Demo - Classic & Enhanced',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Default cursor color in theme
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.red,
        ),
      ),
      home: SearchBarDemo(),
    );
  }
}

class SearchBarDemo extends StatefulWidget {
  const SearchBarDemo({super.key});

  @override
  _SearchBarDemoState createState() => _SearchBarDemoState();
}

class _SearchBarDemoState extends State<SearchBarDemo> {
  final TextEditingController _searchController = TextEditingController();
  String _searchResult = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Search Bar Demo - Classic & Enhanced'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF667eea), Color(0xFF764ba2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Classic Search Bar with Beautiful Rotation Animation
            _buildSectionTitle('🎯 Classic Search Bar (Smooth Icon Rotation)'),
            SizedBox(height: 10),
            ClassicAnimSearchBar(
              width: MediaQuery.of(context).size.width - 40,
              textController: _searchController,
              animationDurationInMilli: 1500,
              onSuffixTap: () {
                setState(() {
                  _searchResult = '';
                });
              },
              onSubmitted: (value) {
                setState(() {
                  _searchResult = 'Classic search: $value';
                });
              },
              helpText: "Classic search with smooth animations...",
              autoFocus: true,
              color: Colors.white,
              textFieldColor: Colors.grey[50],
              // New parameters for prefix icon background control
              hidePrefixIconBackground: false, // Set to true to hide background
              prefixIconBackgroundColor:
                  Colors.blue[100], // Custom background color
              // Custom cursor color
              cursorColor: Colors.blue,
            ),

            SizedBox(height: 30),

            // Classic Search Bar with Hidden Background & RTL
            _buildSectionTitle('🔍 Classic Search Bar (RTL & Fixed Layout)'),
            SizedBox(height: 10),
            Directionality(
              textDirection: TextDirection.rtl,
              child: ClassicAnimSearchBar(
                width: MediaQuery.of(context).size.width - 40,
                textController: TextEditingController(),
                rtl: true,
                animationDurationInMilli: 1500,
                onSuffixTap: () {
                  setState(() {
                    _searchResult = '';
                  });
                },
                onSubmitted: (value) {
                  setState(() {
                    _searchResult = 'No background search: $value';
                  });
                },
                helpText: "جستجو بدون دایره پس‌زمینه...",
                autoFocus: false,
                color: Colors.grey[200],
                textFieldColor: Colors.grey[100],
                // Hide the background circle completely
                hidePrefixIconBackground: true,
                // Using default theme cursor color (Red in this demo)
              ),
            ),

            SizedBox(height: 30),

            // Enhanced Search Bar with Gradient Effects
            _buildSectionTitle('✨ Enhanced Search Bar (Gradient & Effects)'),
            SizedBox(height: 10),
            EnhancedAnimSearchBar(
              width: MediaQuery.of(context).size.width - 40,
              textController: TextEditingController(),
              onSuffixTap: () {
                setState(() {
                  _searchResult = '';
                });
              },
              onSubmitted: (value) {
                setState(() {
                  _searchResult = 'Enhanced search: $value';
                });
              },
              helpText: "Enhanced search with effects...",
              gradientColors: [
                Color(0xFF667eea),
                Color(0xFF764ba2),
                Color(0xFFf093fb),
              ],
              glowEffect: true,
              pulseAnimation: true,
              // Custom background color for prefix icon
              prefixIconBackgroundColor: Colors.purple[100],
              cursorColor: Colors.purple,
            ),

            SizedBox(height: 30),

            // Comparison Section
            _buildSectionTitle('🔄 Side by Side Comparison'),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Classic',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      ClassicAnimSearchBar(
                        animationDurationInMilli: 1500,
                        width: (MediaQuery.of(context).size.width - 60) / 2,
                        textController: TextEditingController(),
                        onSuffixTap: () {},
                        onSubmitted: (value) {
                          setState(() {
                            _searchResult = 'Classic: $value';
                          });
                        },
                        helpText: "Classic...",
                        color: Colors.blue[50],
                        textFieldColor: Colors.blue[100],
                        // Hide the white background circle
                        hidePrefixIconBackground: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Enhanced',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      EnhancedAnimSearchBar(
                        fadeAnimation: true,
                        animationDurationInMilli: 1500,
                        width: (MediaQuery.of(context).size.width - 60) / 2,
                        textController: TextEditingController(),
                        onSuffixTap: () {},
                        onSubmitted: (value) {
                          setState(() {
                            _searchResult = 'Enhanced: $value';
                          });
                        },
                        helpText: "Enhanced...",
                        gradientColors: [Colors.purple, Colors.blue],
                        glowEffect: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),

            // Custom Gradient Search Bar
            _buildSectionTitle('🌈 Custom Rainbow Gradient'),
            SizedBox(height: 10),
            EnhancedAnimSearchBar(
              width: MediaQuery.of(context).size.width - 40,
              textController: TextEditingController(),
              onSuffixTap: () {},
              onSubmitted: (value) {
                setState(() {
                  _searchResult = 'Rainbow search: $value';
                });
              },
              gradientColors: [
                Colors.red,
                Colors.orange,
                Colors.yellow,
                Colors.green,
                Colors.blue,
                Colors.purple,
              ],
              helpText: "Rainbow gradient search...",
              glowEffect: true,
              pulseAnimation: true,
              glowRadius: 25.0,
            ),

            SizedBox(height: 30),

            // Dark Theme Search Bar
            _buildSectionTitle('🌙 Dark Theme'),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(15),
              ),
              child: EnhancedAnimSearchBar(
                width: MediaQuery.of(context).size.width - 80,
                textController: TextEditingController(),
                onSuffixTap: () {},
                onSubmitted: (value) {
                  setState(() {
                    _searchResult = 'Dark theme search: $value';
                  });
                },
                gradientColors: [
                  Colors.grey[800]!,
                  Colors.grey[700]!,
                  Colors.grey[600]!,
                ],
                helpText: "Dark search...",
                color: Colors.grey[800],
                textFieldColor: Colors.grey[700],
                searchIconColor: Colors.white,
                textFieldIconColor: Colors.white,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
              ),
            ),

            SizedBox(height: 30),

            // Search Result Display
            if (_searchResult.isNotEmpty) ...[
              _buildSectionTitle('Search Result'),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Text(
                  _searchResult,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue[800],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],

            SizedBox(height: 50),

            // Features List
            _buildSectionTitle('📋 All Features'),
            SizedBox(height: 10),
            _buildFeaturesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.grey[800],
      ),
    );
  }

  Widget _buildFeaturesList() {
    final features = [
      '🎯 Classic: Smooth icon rotation animations',
      '✨ Enhanced: Gradient background colors',
      '💫 Enhanced: Glow effect around search bar',
      '🔄 Enhanced: Pulse animation on focus',
      '🌈 Enhanced: Customizable gradient borders',
      '🎨 Enhanced: Fade animation effects',
      '📱 Both: Full RTL support (Icons and Text)',
      '⚡ Both: Auto-focus capability',
      '🔍 Both: Custom icons support',
      '🔧 Both: Highly customizable colors & durations',
      '🚀 Both: Smooth expand/collapse animations',
      '🎵 Both: Beautiful ripple effects',
      '🌈 Both: Customizable prefix icon background',
      '👻 Both: Option to hide prefix icon background',
      '📍 Both: Perfectly centered icons in all modes',
      '🖍️ Both: Customizable Cursor Color (defaults to Theme)',
    ];

    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: features
            .map(
              (feature) => Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  feature,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
