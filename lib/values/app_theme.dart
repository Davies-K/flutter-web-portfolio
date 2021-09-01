part of values;

class AppTheme {
  static const _lightFillColor = Colors.black;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: _textTheme,
      iconTheme: IconThemeData(color: Colors.white),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      accentColor: colorScheme.primary,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      focusColor: AppColors.primaryColor,
    );
  }

  static ColorScheme lightColorScheme = ColorScheme(
    primary: AppColors.primaryColor,
    primaryVariant: AppColors.primaryColor,
    secondary: AppColors.primaryColor,
    secondaryVariant: AppColors.primaryColor,
    background: Colors.white,
    surface: Color(0xFFFAFBFB),
    onBackground: AppColors.primaryColor,
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: Color(0xFF322942),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );

  static const _superBold = FontWeight.w900;
  static const _bold = FontWeight.w700;
  static const _semiBold = FontWeight.w600;
  static const _medium = FontWeight.w500;
  static const _regular = FontWeight.w400;
  static const _light = FontWeight.w300;

  static final TextTheme _textTheme = TextTheme(
    headline1: GoogleFonts.raleway(fontSize: 20, fontWeight: FontWeight.w600),
    // headline1: GoogleFonts.raleway(
    //   fontSize: Sizes.TEXT_SIZE_50,
    //   color: AppColors.primaryText,
    //   fontWeight: _bold,
    //   fontStyle: FontStyle.normal,
    // ),
    headline2: GoogleFonts.merriweather(
      fontSize: Sizes.TEXT_SIZE_60,
      color: AppColors.primaryText,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    headline3: GoogleFonts.merriweather(
      fontSize: Sizes.TEXT_SIZE_48,
      color: AppColors.primaryText,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    headline4: GoogleFonts.lato(
      fontSize: Sizes.TEXT_SIZE_34,
      color: AppColors.primaryText,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    headline5: GoogleFonts.lato(
      fontSize: Sizes.TEXT_SIZE_24,
      color: AppColors.primaryText,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    headline6: GoogleFonts.merriweather(
      fontSize: Sizes.TEXT_SIZE_20,
      color: AppColors.primaryText,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    subtitle1: GoogleFonts.lato(
      fontSize: Sizes.TEXT_SIZE_20,
      color: AppColors.primaryText,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    subtitle2: GoogleFonts.lato(
      fontSize: Sizes.TEXT_SIZE_14,
      color: AppColors.primaryText,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    bodyText1: GoogleFonts.lato(
      fontSize: Sizes.TEXT_SIZE_16,
      color: AppColors.primaryText,
      fontWeight: _regular,
      fontStyle: FontStyle.normal,
    ),
    bodyText2: GoogleFonts.lato(
      fontSize: Sizes.TEXT_SIZE_14,
      color: AppColors.primaryText,
      fontWeight: _light,
      fontStyle: FontStyle.normal,
    ),
    button: GoogleFonts.lato(
      fontSize: Sizes.TEXT_SIZE_16,
      color: AppColors.primaryText,
      fontStyle: FontStyle.normal,
      fontWeight: _regular,
    ),
    caption: GoogleFonts.lato(
      fontSize: Sizes.TEXT_SIZE_12,
      color: AppColors.primaryText,
      fontWeight: _regular,
      fontStyle: FontStyle.normal,
    ),
  );
}
