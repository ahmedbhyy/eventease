import 'package:eventease/controller/home/checkout_controller.dart';
import 'package:eventease/core/constant/color.dart';
import 'package:eventease/core/constant/imageasset.dart';
import 'package:eventease/view/auth/authwidgets/button_auth.dart';
import 'package:eventease/view/auth/authwidgets/textfieldauth.dart';
import 'package:eventease/view/commonwidgets/common_appbar.dart';
import 'package:eventease/view/commonwidgets/commonloading.dart';
import 'package:eventease/view/home/cart.dart';
import 'package:eventease/view/home/paywithcard.dart';
import 'package:eventease/view/slides/slide_right.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckOut extends StatelessWidget {
  final double total;
  const CheckOut({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    CheckOutControllerImp controller = Get.put(CheckOutControllerImp());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CommonAppBar(
          title: "Check Out",
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Form(
        key: controller.formState,
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: [
            Image.asset(
              AppImageAsset.checkout,
              height: 250.0,
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFieldAuth(
              hint: "Name",
              mycontroller: controller.controller1!,
              myicon: const Icon(
                Icons.person_2_outlined,
                color: AppColor.secondcolor,
              ),
              ispass: false,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "Can't to be empty ";
                }
                return null;
              },
              mytype: TextInputType.text,
              readonly: false,
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFieldAuth(
              hint: "Place",
              mycontroller: controller.controller2!,
              myicon: const Icon(
                Icons.place_outlined,
                color: AppColor.secondcolor,
              ),
              ispass: false,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "Can't to be empty ";
                }
                return null;
              },
              mytype: TextInputType.text,
              readonly: false,
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFieldAuth(
              hint: "Phone number",
              mycontroller: controller.controller3!,
              myicon: const Icon(
                Icons.phone,
                color: AppColor.secondcolor,
              ),
              prefixtext: "+216 ",
              ispass: false,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "Can't to be empty ";
                }
                return null;
              },
              mytype: TextInputType.text,
              readonly: false,
            ),
            const SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200.0,
                  child: ButtonAuth(
                    mytitle: "Pay with card",
                    myfunction: () {
                      if (controller.formState.currentState!.validate()) {
                        Navigator.of(context).push(
                          SlideRight(
                            page: PayWithCard(
                              total: total,
                              adress: controller.controller2!.text,
                              name: controller.controller2!.text,
                              phone: controller.controller3!.text,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => PaypalCheckoutView(
                        sandboxMode: true,
                        clientId:
                            "AQ4Ha5CUSrPsQSowfFEO7R0cWMptqhzbUMzNmsE6GmzFOTCVQWeOcDzyaRd1U20FPN2E-zW4lQaSKkp_",
                        secretKey:
                            "EEAPTxGspvouXD7saRhoI2PfN9vt83SPSRt24eua2gw17M4NgmA158akPgevhqTgeDLRBQm8BuNFIUML",
                        transactions: const [
                          {
                            "amount": {
                              "total": "70",
                              "currency": "USD",
                              "details": {
                                "subtotal": "70",
                                "shipping": '0',
                                "shipping_discount": 0
                              }
                            },
                            "description":
                                "The payment transaction description.",
                            // "payment_options": {
                            //   "allowed_payment_method":
                            //       "INSTANT_FUNDING_SOURCE"
                            // },
                            "item_list": {
                              "items": [
                                {
                                  "name": "Apple",
                                  "quantity": 4,
                                  "price": '5',
                                  "currency": "USD"
                                },
                                {
                                  "name": "Pineapple",
                                  "quantity": 5,
                                  "price": '10',
                                  "currency": "USD"
                                }
                              ],

                              // shipping address is not required though
                              //   "shipping_address": {
                              //     "recipient_name": "tharwat",
                              //     "line1": "Alexandria",
                              //     "line2": "",
                              //     "city": "Alexandria",
                              //     "country_code": "EG",
                              //     "postal_code": "21505",
                              //     "phone": "+00000000",
                              //     "state": "Alexandria"
                              //  },
                            }
                          }
                        ],
                        note: "Contact us for any questions on your order.",
                        onSuccess: (Map params) async {
                          Get.off(
                            () => const CartScreen(),
                          );
                        },
                        onError: (error) {
                          Navigator.pop(context);
                        },
                        onCancel: () {
                          return;
                        },
                      ),
                    ));
                  },
                  label: const Text("Or"),
                  iconAlignment: IconAlignment.end,
                  icon: Image.asset(
                    AppImageAsset.paypal,
                    height: 30.0,
                  ),
                )
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  "Or",
                  style: GoogleFonts.mulish(
                    fontSize: 20.0,
                    color: AppColor.secondcolor,
                  ),
                ),
              ),
            ),
            controller.isloading
                ? const CommonLoading()
                : ButtonAuth(
                    mytitle: "Cash on Delivery",
                    myfunction: () {
                      if (controller.formState.currentState!.validate()) {
                        controller.pay(total);
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
