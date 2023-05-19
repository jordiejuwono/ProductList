// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final TextStyle kHeading5 = GoogleFonts.poppins(
  fontSize: 24.0,
  fontWeight: FontWeight.w600,
);
final TextStyle kHeading6 = GoogleFonts.poppins(
  fontSize: 20.0,
  fontWeight: FontWeight.w600,
);
final TextStyle kBodyText = GoogleFonts.poppins(
  fontSize: 18.0,
  fontWeight: FontWeight.w400,
);
final TextStyle kTextSmallBold = GoogleFonts.poppins(
  fontSize: 14.0,
  fontWeight: FontWeight.w600,
);
final TextStyle kTextSmallMediumBold = GoogleFonts.poppins(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
);
final TextStyle kTextMediumNormal = GoogleFonts.poppins(
  fontSize: 16.0,
  fontWeight: FontWeight.w400,
);
final TextStyle kTextMediumBold = GoogleFonts.poppins(
  fontSize: 16.0,
  fontWeight: FontWeight.w600,
);
final TextStyle kTextMediumMediumBold = GoogleFonts.poppins(
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
);
final TextStyle kTextSmallNormal = GoogleFonts.poppins(
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
);
final TextStyle kTextExtraSmallNormal = GoogleFonts.poppins(
  fontSize: 12.0,
  fontWeight: FontWeight.w400,
);

final kThemeText = TextTheme(
  bodyLarge: kBodyText,
  bodyMedium: kTextMediumNormal,
  bodySmall: kTextSmallNormal,
  titleMedium: kHeading6,
  titleLarge: kHeading5,
);

class Constants {
  Constants();
  static const productUrl = "products";
}
