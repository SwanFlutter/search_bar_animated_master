# Enhanced Animated Search Bar 🔍✨

A beautiful and highly customizable animated search bar for Flutter with gradient backgrounds, glow effects, smooth animations, and perfect icon centering. This package provides both classic and enhanced versions with extensive customization options.

## 🆕 What's New in Latest Version

- ✅ **Fixed Icon Centering** - Icons are now perfectly centered
- ✅ **Customizable Icon Background** - Control or hide the white circle around search icon
- ✅ **Improved Rotation Animation** - Close icon rotates only during transitions
- ✅ **Better Visual Appeal** - Cleaner look with more customization options

![Before vs After](https://via.placeholder.com/600x200/f0f0f0/333333?text=Before%3A+Off-center+icons+%7C+After%3A+Perfect+centering)

## Features 🌟

### Core Features
- 🎯 **Smooth Animations** - Fluid expand/collapse animations with rotating close icon
- 📱 **RTL Support** - Right-to-left language support
- ⚡ **Auto-focus** - Automatic keyboard focus when expanded
- 🎪 **Custom Icons** - Support for custom prefix and suffix icons
- 🔧 **Highly Customizable** - Extensive customization options

### Visual Enhancements
- 🎨 **Gradient Background Colors** - Beautiful gradient backgrounds with customizable colors
- ✨ **Fade Animation Effects** - Smooth fade in/out animations
- 💫 **Glow Effect** - Glowing effect around the search bar when expanded
- 🔄 **Pulse Animation** - Pulse effect when the search bar is focused
- 🌈 **Gradient Borders** - Customizable gradient borders

### Icon Customization (New!)
- 🎨 **Customizable Prefix Icon Background** - Control the background color of the search icon
- 👻 **Hide Prefix Icon Background** - Option to completely hide the background circle
- 📍 **Perfectly Centered Icons** - Icons are properly centered for better visual appeal
- 🔄 **Smooth Icon Rotation** - Close icon rotates only during open/close transitions

## Quick Start 🚀

### 1. Installation
Add this to your `pubspec.yaml`:
```yaml
dependencies:
  search_bar_animated_master: ^1.1.0
```

### 2. Import
```dart
import 'package:search_bar_animated_master/search_bar_animated_master.dart';
```

### 3. Use it!
```dart
ClassicAnimSearchBar(
  width: MediaQuery.of(context).size.width - 40,
  textController: _searchController,
  onSuffixTap: () {},
  onSubmitted: (value) => print('Search: $value'),
  hidePrefixIconBackground: true, // 🆕 Clean look!
)
```

## Usage 🚀

### Basic Usage

```dart
import 'package:search_bar_animated_master/search_bar_animated_master.dart';

// Classic Search Bar (Simple and Clean)
ClassicAnimSearchBar(
  width: MediaQuery.of(context).size.width - 40,
  textController: _searchController,
  onSuffixTap: () {
    // Handle suffix icon tap
  },
  onSubmitted: (value) {
    // Handle search submission
    print('Searched for: $value');
  },
  helpText: "Search anything...",
)

// Enhanced Search Bar (With Gradient Effects)
EnhancedAnimSearchBar(
  width: MediaQuery.of(context).size.width - 40,
  textController: _searchController,
  onSuffixTap: () {
    // Handle suffix icon tap
  },
  onSubmitted: (value) {
    // Handle search submission
    print('Searched for: $value');
  },
  helpText: "Search with effects...",
  gradientColors: [Colors.blue, Colors.purple],
  glowEffect: true,
)
```

### Advanced Usage with Custom Styling

```dart
EnhancedAnimSearchBar(
  width: MediaQuery.of(context).size.width - 40,
  textController: _searchController,
  onSuffixTap: () {},
  onSubmitted: (value) {
    print('Search: $value');
  },
  // Custom gradient colors
  gradientColors: [
    Colors.purple,
    Colors.blue,
    Colors.cyan,
  ],
  // Enable all effects
  fadeAnimation: true,
  glowEffect: true,
  borderGradient: true,
  pulseAnimation: true,
  // Customization
  helpText: "Search with style...",
  autoFocus: true,
  animationDurationInMilli: 500,
  glowRadius: 25.0,
  pulseScale: 1.2,
)
```

### Customizing Prefix Icon Background (New Feature!)

```dart
// Option 1: Custom background color for the search icon
ClassicAnimSearchBar(
  width: MediaQuery.of(context).size.width - 40,
  textController: _searchController,
  onSuffixTap: () {},
  onSubmitted: (value) => print('Search: $value'),
  helpText: "Search with custom icon background...",
  // Custom background color for the prefix icon
  prefixIconBackgroundColor: Colors.blue[100],
)

// Option 2: Hide the background circle completely (Clean Look)
ClassicAnimSearchBar(
  width: MediaQuery.of(context).size.width - 40,
  textController: _searchController,
  onSuffixTap: () {},
  onSubmitted: (value) => print('Search: $value'),
  helpText: "Search without background circle...",
  // Hide the background circle completely for a cleaner look
  hidePrefixIconBackground: true,
)

// Option 3: Enhanced version with custom background
EnhancedAnimSearchBar(
  width: MediaQuery.of(context).size.width - 40,
  textController: _searchController,
  onSuffixTap: () {},
  onSubmitted: (value) => print('Search: $value'),
  helpText: "Enhanced search with custom background...",
  gradientColors: [Colors.purple, Colors.blue],
  // Custom background color that works with gradients
  prefixIconBackgroundColor: Colors.purple[100],
  glowEffect: true,
)
```

## ClassicAnimSearchBar vs EnhancedAnimSearchBar 🆚

| Feature | ClassicAnimSearchBar | EnhancedAnimSearchBar |
|---------|---------------------|----------------------|
| **Performance** | ⚡ Lightweight & Fast | 🎨 Feature-rich |
| **Animations** | ✅ Smooth expand/collapse | ✅ Smooth + Fade + Pulse |
| **Icon Rotation** | ✅ Close icon rotation | ✅ Close icon rotation |
| **Gradient Background** | ❌ Solid colors only | ✅ Full gradient support |
| **Glow Effect** | ❌ Not available | ✅ Customizable glow |
| **Border Gradient** | ❌ Not available | ✅ Gradient borders |
| **Icon Background Control** | ✅ Full control | ✅ Full control |
| **Best for** | Simple, clean designs | Rich, modern UIs |

### When to use ClassicAnimSearchBar:
- ✅ You want a lightweight, fast search bar
- ✅ Simple, clean design is preferred
- ✅ Performance is critical
- ✅ Minimal visual effects needed

### When to use EnhancedAnimSearchBar:
- ✅ You want rich visual effects
- ✅ Gradient backgrounds and borders
- ✅ Glow and pulse animations
- ✅ Modern, eye-catching design

### Dark Theme Example

```dart
EnhancedAnimSearchBar(
  width: MediaQuery.of(context).size.width - 40,
  textController: _searchController,
  onSuffixTap: () {},
  onSubmitted: (value) {
    print('Dark search: $value');
  },
  gradientColors: [
    Colors.grey[800]!,
    Colors.grey[700]!,
    Colors.grey[600]!,
  ],
  color: Colors.grey[800],
  textFieldColor: Colors.grey[700],
  searchIconColor: Colors.white,
  textFieldIconColor: Colors.white,
  style: TextStyle(color: Colors.white),
  helpText: "Dark search...",
)
```

## Parameters 📋

### Required Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `width` | `double` | Width of the expanded search bar |
| `textController` | `TextEditingController` | Controller for the text field |
| `onSuffixTap` | `VoidCallback` | Callback when suffix icon is tapped |
| `onSubmitted` | `Function(String)` | Callback when search is submitted |

### Common Optional Parameters (Both Classes)

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `helpText` | `String` | `"Search..."` | Placeholder text |
| `autoFocus` | `bool` | `false` | Auto-focus when expanded |
| `rtl` | `bool` | `false` | Right-to-left support |
| `animationDurationInMilli` | `int` | `375` | Animation duration in milliseconds |
| `color` | `Color?` | `Colors.white` | Background color when collapsed |
| `textFieldColor` | `Color?` | `Colors.white` | Background color when expanded |
| `searchIconColor` | `Color?` | `Colors.black` | Color of search icon |
| `textFieldIconColor` | `Color?` | `Colors.black` | Color of icons when expanded |
| `prefixIconBackgroundColor` | `Color?` | `null` | 🆕 Custom background color for prefix icon |
| `hidePrefixIconBackground` | `bool` | `false` | 🆕 Hide the background circle of prefix icon |

### EnhancedAnimSearchBar Exclusive Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `gradientColors` | `List<Color>` | `[Color(0xFF667eea), Color(0xFF764ba2), Color(0xFFf093fb)]` | Colors for gradient background |
| `fadeAnimation` | `bool` | `true` | Enable fade animation effects |
| `glowEffect` | `bool` | `true` | Enable glow effect around search bar |
| `borderGradient` | `bool` | `true` | Enable gradient border |
| `pulseAnimation` | `bool` | `true` | Enable pulse animation on focus |
| `glowRadius` | `double` | `20.0` | Radius of glow effect |
| `pulseScale` | `double` | `1.1` | Scale factor for pulse animation |
| `borderWidth` | `double` | `2.0` | Width of gradient border |

## Examples 📱

Check out the `/example` folder for a complete demo app showing different usage scenarios:

### Available Examples:
- 🎯 **Classic Search Bar** - Simple and clean with smooth rotation animation
- 🔍 **No Background Circle** - Clean look without the white background
- ✨ **Enhanced Search Bar** - With gradient effects and glow
- 🌈 **Rainbow Gradient** - Multi-color gradient example
- 🌙 **Dark Theme** - Perfect for dark mode applications
- 🆚 **Side by Side Comparison** - Compare both versions
- 🎨 **Custom Icon Backgrounds** - Different background color options

### Running the Example:
```bash
cd example
flutter run
```

## Migration from Original AnimSearchBar 🔄

If you're migrating from the original `AnimSearchBar`, the enhanced version is mostly compatible. Just replace:

```dart
// Old
AnimSearchBar(...)

// New
EnhancedAnimSearchBar(...)
```

The enhanced version includes all original features plus new gradient and animation effects.

## Troubleshooting 🔧

### Common Issues and Solutions:

#### Issue: White circle around search icon looks bad
**Solution:** Use the new icon background customization:
```dart
// Option 1: Hide it completely
hidePrefixIconBackground: true,

// Option 2: Change the color
prefixIconBackgroundColor: Colors.blue[100],
```

#### Issue: Search icon is not centered
**Solution:** This has been fixed in the latest version. Update to the latest version for perfectly centered icons.

#### Issue: Close icon rotates continuously
**Solution:** The rotation now only happens during open/close transitions, not continuously.

#### Issue: Animation is too slow/fast
**Solution:** Adjust the animation duration:
```dart
animationDurationInMilli: 500, // Adjust as needed (default: 375)
```

## Performance Tips 🚀

1. **Use ClassicAnimSearchBar** for better performance if you don't need gradient effects
2. **Disable unused effects** in EnhancedAnimSearchBar:
   ```dart
   glowEffect: false,
   pulseAnimation: false,
   fadeAnimation: false,
   ```
3. **Optimize animation duration** based on your needs
4. **Use appropriate colors** that match your app theme

## Contributing 🤝

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Development Setup:
```bash
git clone https://github.com/your-repo/search_bar_animated_master.git
cd search_bar_animated_master
flutter pub get
cd example
flutter run
```

## License 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Changelog 📝

### Version 1.1.0 (Latest)
- 🆕 Added `prefixIconBackgroundColor` parameter
- 🆕 Added `hidePrefixIconBackground` parameter
- 🔧 Fixed icon centering issues
- 🔧 Improved close icon rotation animation
- 📚 Enhanced documentation and examples

### Version 1.0.0
- 🎉 Initial release with ClassicAnimSearchBar and EnhancedAnimSearchBar
- ✨ Gradient backgrounds and effects
- 🎯 Smooth animations and transitions

## Support 💬

If you like this package, please give it a ⭐ on GitHub and consider supporting the development!

For questions or issues, please open an issue on GitHub.

## Contributing 🤝

Contributions are welcome! Please feel free to submit a Pull Request.

## License 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Changelog 📝

### Version 0.0.1
- Initial release with enhanced features
- Added gradient backgrounds
- Added glow effects
- Added pulse animations
- Added fade animations
- Improved customization options
