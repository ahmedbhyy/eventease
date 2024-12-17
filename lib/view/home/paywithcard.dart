import 'package:eventease/controller/home/paywithcard_controller.dart';
import 'package:eventease/view/auth/authwidgets/button_auth.dart';

import 'package:eventease/view/commonwidgets/common_appbar.dart';
import 'package:eventease/view/commonwidgets/commonloading.dart';

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';

class PayWithCard extends StatelessWidget {
  final double total;
  final String name;
  final String phone;
  final String adress;
  const PayWithCard({super.key, required this.total, required this.name, required this.phone, required this.adress});

  @override
  Widget build(BuildContext context) {
    Get.put(PayWithCardControllerImp());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CommonAppBar(
          title: "Pay with card",
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: GetBuilder<PayWithCardControllerImp>(
        builder: (controller) => ListView(
          children: [
            CreditCardWidget(
              cardNumber: controller.controller1!.text,
              expiryDate: controller.controller2!.text,
              cardHolderName: controller.controller3!.text,
              cvvCode: controller.controller4!.text,
              showBackView: false,
              onCreditCardWidgetChange: (CreditCardBrand brand) {},
            ),
            CreditCardForm(
              formKey: controller.formState,
              cardNumber: controller.controller1!.text,
              expiryDate: controller.controller2!.text,
              cardHolderName: controller.controller3!.text,
              cvvCode: controller.controller4!.text,
              onCreditCardModelChange: (CreditCardModel data) {
                controller.updateCardData(data);
              },
              obscureCvv: true,
              obscureNumber: true,
              isHolderNameVisible: true,
              isCardNumberVisible: true,
              isExpiryDateVisible: true,
              enableCvv: true,
              cvvValidationMessage: 'Please input a valid CVV',
              dateValidationMessage: 'Please input a valid date',
              numberValidationMessage: 'Please input a valid number',
              autovalidateMode: AutovalidateMode.always,
              disableCardNumberAutoFillHints: false,
              cardNumberValidator: (String? cardNumber) {
                return;
              },
              expiryDateValidator: (String? expiryDate) {
                return;
              },
              cvvValidator: (String? cvv) {
                return;
              },
              cardHolderValidator: (String? cardHolderName) {
                return;
              },
              inputConfiguration: const InputConfiguration(
                cardNumberDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Number',
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: 'XXXX XXXX XXXX XXXX',
                ),
                expiryDateDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Expired Date',
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: 'XX/XX',
                ),
                cvvCodeDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'CVV',
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: 'XXX',
                ),
                cardHolderDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Card Holder',
                  labelStyle: TextStyle(color: Colors.white),
                ),
                cardNumberTextStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
                cardHolderTextStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
                expiryDateTextStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
                cvvCodeTextStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            controller.isloading
                ? const CommonLoading()
                : ButtonAuth(
                    mytitle: "Pay",
                    myfunction: () async {
                      controller.pay(total,name,adress,phone);
                    })
          ],
        ),
      ),
    );
  }
}
