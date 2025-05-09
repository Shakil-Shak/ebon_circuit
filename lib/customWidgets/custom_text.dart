import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../color.dart';

Widget customText(String text,
    {Color color = primaryColor,
    double size = 14.0,
    dynamic fontWeigth,
    dynamic softWrap,
    maxline,
    overflow,
    dynamic alinment}) {
  return Text(
    text,
    maxLines: maxline,
    softWrap: softWrap,
    textAlign: alinment,
    overflow: overflow,
    style: GoogleFonts.merienda(
      letterSpacing: .5,
      color: color,
      fontSize: size,
      fontWeight: fontWeigth,
    ),
  );
}

Widget customTextMain(String text,
    {Color color = primaryColor, double size = 14.0}) {
  return Text(
    text,
    style: GoogleFonts.ubuntu(letterSpacing: .5, color: color, fontSize: size),
  );
}

// Widget customTextBold(String text,
//     {Color color = primaryColor, double size = 14}) {
//   return Text(text)
//       .text
//       .size(size)
//       .color(color)
//       .bold
//       .textStyle(GoogleFonts.openSans(letterSpacing: .5))
//       .make();
// }
