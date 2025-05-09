import 'package:ebon_circuit/Admin%20Pages/app_amdin_helper.dart';
import 'package:ebon_circuit/color.dart';
import 'package:ebon_circuit/customWidgets/custom_widgets.dart';
import 'package:ebon_circuit/demo_for_today.dart';
import 'package:ebon_circuit/modelsPages/signup-model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebon_circuit/new%20requairments/new_login_screen.dart';

class PasskeyScreen extends StatefulWidget {
  @override
  _PasskeyScreenState createState() => _PasskeyScreenState();
}

class _PasskeyScreenState extends State<PasskeyScreen> {
  final _controller = TextEditingController();
  String? _errorText;

  Future<void> _checkPasskey() async {
    final inputKey = _controller.text.trim();
    if (inputKey.isEmpty) {
      return CustomWidgets.snackBarCustom(context, massage: "Enter a pin");
    }

    // Check if the input key matches the admin passkey.
    if (inputKey.toLowerCase() == 'i am admin') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminLoginScreen()),
      );
      return;
    } else {
      print(inputKey + "...........................");

      // Fetch the list of passkeys from Firestore
      await FirebaseFirestore.instance
          .collection('config')
          .doc('access')
          .get()
          .then(
        (value) async {
          if (value.exists) {
            // Get the list of passkeys from the document
            List<dynamic> passkeys = value['passkeys'] ?? [];
            print("Existing passkeys: $passkeys");

            if (passkeys.contains(inputKey)) {
              // If passkey exists, allow access
              setState(() => _errorText = null);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => DemoForToday()),
              );
            } else {
              // If passkey doesn't exist, add it to the list and update Firestore
              passkeys.add(inputKey);

              // Update the Firestore document with the new list of passkeys
              await FirebaseFirestore.instance
                  .collection('config')
                  .doc('access')
                  .update({
                'passkeys': passkeys,
              }).then(
                (value) async {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => DemoForToday()),
                  );
                  await storeUserId(inputKey);
                  (value) async {
                    String userId = await getUserId();
                    SignupModel signupModel =
                        SignupModel(id: userId, appId: appId);

                    DocumentReference database = FirebaseFirestore.instance
                        .collection("Users Collections")
                        .doc(userId);
                    database.set(signupModel.dataToMap());
                  };
                },
              );

              print("New passkey added: $inputKey");
            }
          } else {
            // If the document does not exist, create it and add the passkey
            await FirebaseFirestore.instance
                .collection('config')
                .doc('access')
                .set({
              'passkeys': [inputKey], // Store the first passkey in the list
            }).then(
              (value) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => DemoForToday()),
                );
              },
            );
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Admin Access",
                    style: TextStyle(
                      fontSize: 24,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _controller,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Enter Access Key',
                      errorText: _errorText,
                      hintStyle: TextStyle(color: primaryColor),
                      labelStyle: TextStyle(color: primaryColor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: primaryColor)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: primaryColor, width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: primaryColor, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: primaryColor, width: 2),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: primaryColor, width: 2),
                      ),
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 0,
                              spreadRadius: 2,
                              color: primaryColor)
                        ]),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.login),
                        label: const Text("Enter Site"),
                        onPressed: _checkPasskey,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
