import 'package:country_calling_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({Key? key}) : super(key: key);

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String dialCodeDigits = '+00';
  String countryName = "";
  String plateNumber = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: (plateNumber == "" && plateNumber.length == 0)
          ? Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.grey,
              ),
              width: 60,
              height: 60,
              child: Center(
                  child: Icon(
                Icons.arrow_forward_sharp,
                size: 30,
                color: AppColors.white,
              )),
            )
          : GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.appblue,
                ),
                width: 60,
                height: 60,
                child: Center(
                    child: Icon(
                  Icons.arrow_forward_sharp,
                  size: 30,
                  color: AppColors.white,
                )),
              ),
            ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      child: Icon(Icons.close, size: 30, color: AppColors.appblue),
                      onTap: () {
                        Navigator.pop(context);
                      }),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 40, bottom: 40),
                    child: Text(
                      "Phone Number",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, bottom: 10),
                              child: Text(
                                "Country",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            CountryCodePicker(
                              textStyle: TextStyle(
                                fontSize: 25,
                                color: AppColors.black,
                              ),
                              onChanged: (country) {
                                setState(() {
                                  dialCodeDigits = country.dialCode!;
                                  countryName = country.name!;
                                });
                              },
                              initialSelection: 'IN',
                              showCountryOnly: true,
                              showOnlyCountryWhenClosed: true,
                              alignLeft: true,
                              favorite: const ["+91", "IN"], //"+1", "US",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      controller: _phoneNumberController,
                      textAlign: TextAlign.left,
                      cursorColor: AppColors.grey,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "+91 8686780567",
                        floatingLabelStyle:
                            const TextStyle(height: 4, color: AppColors.grey),
                        filled: true,
                        fillColor:AppColors.greyshade200,
                      ),
                      onChanged: (value) {
                        setState(() {
                          plateNumber = value;
                        });
                      },
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

class PickerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: AppColors.appblue),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: AppColors.white,
      ),
      body: SafeArea(
        child: Container(
          child: CountryPickerWidget(
            onSelected: (country) => Navigator.pop(context, country),
          ),
        ),
      ),
    );
  }
}
