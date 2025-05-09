import 'package:flutter/material.dart';
import 'package:ebon_circuit/color.dart';

class CustomWidgets {
  static Widget elevatedButtonCustom(
      {String hintText = "",
      Color colour = primaryColor,
      double fontSize = 20.0,
      var width = 250.0,
      var height = 55.0,
      VoidCallback? onPressedButton}) {
    return SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(colour)),
          child: Text(hintText,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize)),
          onPressed: () {
            if (onPressedButton != null) {
              onPressedButton();
            }
          },
        ));
  }

  static Widget iconButtonCustom(
      {String hintText = "",
      Color colour = primaryColor,
      required String imageIconpath,
      Widget? icon,
      double fontSize = 20.0,
      VoidCallback? onPressedButton,
      Color fontColour = primaryColor}) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            boxShadow: const [
              BoxShadow(
                blurRadius: 2,
                color: primaryColor,
                spreadRadius: 0.1,
                offset: Offset(1, 1),
              )
            ]),
        width: 250,
        height: 55,
        child: TextButton.icon(
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(colour)),
          icon: (icon == null)
              ? CircleAvatar(
                  backgroundColor: primaryColor,
                  radius: 15,
                  child: Image.asset(
                    imageIconpath,
                    width: 25.0,
                    height: 25.0,
                  ),
                )
              : icon,
          label: Text(hintText,
              style: TextStyle(color: fontColour, fontSize: fontSize)),
          onPressed: () {
            if (onPressedButton != null) {
              onPressedButton();
            }
          },
        ));
  }

  static Widget textFormFieldCustom(
      {String text = "",
      dynamic maxLine,
      TextEditingController? controller,
      validatorFunction,
      bool enabled = true,
      keyboardType = TextInputType.text,
      suffixText,
      double width = 250.0,
      dynamic onchanged,
      double? height}) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        maxLines: maxLine,
        controller: controller,
        keyboardType: keyboardType,
        enabled: enabled,
        validator: validatorFunction,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: onchanged,
        decoration: InputDecoration(
            suffixText: suffixText,
            filled: true,
            fillColor: const Color(0xFFF2F2F2),
            hintText: text,
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: primaryColor),
              borderRadius: BorderRadius.circular(100),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: primaryColor),
              borderRadius: BorderRadius.circular(100),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: primaryColor),
              borderRadius: BorderRadius.circular(100),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: primaryColor),
              borderRadius: BorderRadius.circular(100),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: primaryColor),
              borderRadius: BorderRadius.circular(100),
            )),
      ),
    );
  }

  static Future pageRouteCustom(BuildContext context,
      {pageName, onlyPush = false}) {
    if (onlyPush) {
      return Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return pageName;
        },
      ));
    }
    return Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return pageName;
      },
    ));
  }

  static Future CustomPageRouteAnimation(BuildContext context,
      {required Widget pageName, bool onlyPush = false}) {
    if (onlyPush) {
      return Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => pageName,
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
      );
    } else {
      return Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => pageName,
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
      );
    }
  }

  static dynamic snackBarCustom(context, {massage}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(massage),
      duration: const Duration(
          seconds: 2), // Duration for which the SnackBar is displayed
    ));
  }

  static dynamic bottomAppBarCustom() {
    return const BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 20.0,
        surfaceTintColor: primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [Icon(Icons.menu), Text("Menu")],
                  ),
                  SizedBox(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [Icon(Icons.shop), Text("Offer")],
                  )
                ],
              ),
            ),
            Expanded(child: SizedBox()),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [Icon(Icons.person), Text("Profile")],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [Icon(Icons.read_more), Text("More")],
                  )
                ],
              ),
            ),
          ],
        ));
  }

  static String? nameValidity(String? value) {
    if (value!.isEmpty) {
      return "this field required";
    } else if (!(RegExp(r'^[a-z A-Z]{2,}$').hasMatch(value))) {
      return "invalid name";
    } else {
      return null;
    }
  }

  static String? numberValidity(String? value) {
    if (value!.isEmpty) {
      return "this field required";
    }
    if (value.length < 11 && value.isNotEmpty) {
      return "Enter valid number";
    } else {
      return null;
    }
  }

  static String? emailValidity(String? value) {
    if (value!.isEmpty) {
      return "this field required";
    }
    if (!(RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value))) {
      return "invalid email";
    } else {
      return null;
    }
  }

  static String? passwordValidity(String? value) {
    RegExp capitalLetterPattern = RegExp(r'[A-Z]');
    RegExp smallLetterPattern = RegExp(r'[a-z]');
    RegExp numberPattern = RegExp(r'\d');

    if (!capitalLetterPattern.hasMatch(value!) ||
        !smallLetterPattern.hasMatch(value) ||
        !numberPattern.hasMatch(value) ||
        value.length <= 8) {
      return "weak password";
    } else {
      null;
    }
    return null;
  }

  static dynamic progressBarCustom(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  static Future<dynamic> slideNavigationLeftToRightPush(
      Widget page, BuildContext context) {
    return Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }
}

class RatingStar extends StatelessWidget {
  final double rating;
  final int maxRating;
  final IconData filledStar;
  final IconData emptyStar;
  final Color starColor;

  const RatingStar({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.filledStar = Icons.star,
    this.emptyStar = Icons.star_border,
    this.starColor = Colors.yellow,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        maxRating,
        (index) {
          if (index < rating) {
            return Icon(
              filledStar,
              color: starColor,
            );
          } else {
            return Icon(
              emptyStar,
              color: starColor,
            );
          }
        },
      ),
    );
  }
}
