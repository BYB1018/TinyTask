import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // 定义主题色和透明度
  static const primaryColor = Color(0xFF41BE57);
  static const backgroundColor = Color(0xFFF7F7F7);
  
  static ThemeData get lightTheme {
    // 使用 Noto Sans JP 作为主字体，这是一个优雅的日式字体
    final baseTextTheme = GoogleFonts.notoSansJpTextTheme();
    
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      useMaterial3: true,
      
      // 更新文字主题
      textTheme: baseTextTheme.copyWith(
        headlineLarge: baseTextTheme.headlineLarge?.copyWith(
          fontSize: 28,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.5,
        ),
        titleLarge: baseTextTheme.titleLarge?.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.15,
        ),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.5,
        ),
      ),
      
      // 更新卡片主题
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Colors.white.withOpacity(0.9),
      ),
      
      // 更新按钮主题
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: primaryColor.withOpacity(0.9),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      
      // 更新 AppBar 主题
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0.95),
        foregroundColor: Colors.black87,
        centerTitle: true,
        titleTextStyle: baseTextTheme.titleLarge?.copyWith(
          color: Colors.black87,
          fontWeight: FontWeight.w300,
          letterSpacing: 1,
        ),
      ),
      
      // 更新浮动按钮主题
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor.withOpacity(0.9),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      
      // 更新底部导航栏主题
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white.withOpacity(0.95),
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.black45,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
} 