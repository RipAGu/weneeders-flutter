import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/account/find/ChangePasswordPage.dart';
import 'package:winit/view/account/find/PasswordChangeSuccessPage.dart';

import '../../widget/CustomConfirmBtn.dart';
import '../../widget/CustomTextField.dart';
import 'FindViewModel.dart';
import 'PrintEmailPage.dart';

class FindPasswordPage extends StatefulWidget {
  const FindPasswordPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _FindPasswordPageState();
}

class _FindPasswordPageState extends State<FindPasswordPage> {
  final TextEditingController _userEmail = TextEditingController();
  final TextEditingController _verifyCode = TextEditingController();
  final TextEditingController _userPhone = TextEditingController();
  final TextEditingController _userPassword = TextEditingController();
  final TextEditingController _userPasswordCheck = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => FindViewModel(),
        child: Consumer<FindViewModel>(
          builder: (context, viewModel, child) => Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
                child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Text(
                              "비밀번호 변경",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width * 0.9,
                      //구분선
                      height: 1,
                      color: Colors.grey[300],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 26),
                      child: Column(children: [
                        Container(
                            margin: const EdgeInsets.only(top: 10),
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: CustomTextField(
                                  hintText: "이메일",
                                  obscureText: false,
                                  controller: _userEmail,
                                  keyboardType: TextInputType.emailAddress,
                                  isEditable: !viewModel.isPhoneSend,
                                  textFontSize: 12),
                            )),
                      ]),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 26),
                      child: Column(children: [
                        Container(
                            margin: const EdgeInsets.only(top: 10),
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.63,
                                  child: CustomTextField(
                                      hintText: "연락처",
                                      obscureText: false,
                                      controller: _userPhone,
                                      keyboardType: TextInputType.number,
                                      isEditable: !viewModel.isPhoneSend,
                                      textFontSize: 12),
                                ),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    child: CustomConfirmBtn(
                                      text: "인증요청",
                                      onPressed: () async {
                                        if (_userPhone.text.isEmpty) {
                                          showSnackBar(context, "연락처를 입력해주세요.");
                                        } else {
                                          await viewModel.sendPhone(
                                              _userPhone.text, 3);
                                          if (!mounted) return;
                                          if (viewModel.isPhoneSend) {
                                            showSnackBar(
                                                context, "인증번호가 전송되었습니다.");
                                          } else {
                                            showSnackBar(
                                                context, "올바르지 않은 번호입니다.");
                                          }
                                        }
                                      },
                                      backgroundColor: viewModel.isPhoneSend
                                          ? const Color(0xffA9B0B8)
                                          : const Color(0xFF2D8CF4),
                                      textColor: Colors.white,
                                      textSize: 12,
                                    )),
                              ],
                            )),
                        Visibility(
                          visible: viewModel.isPhoneSend,
                          child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.63,
                                    child: CustomTextField(
                                      hintText: "인증번호",
                                      obscureText: false,
                                      controller: _verifyCode,
                                      keyboardType: TextInputType.number,
                                      textFontSize: 12,
                                      isEditable: !viewModel.isPhoneChecked,
                                    ),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      child: CustomConfirmBtn(
                                        text: "인증확인",
                                        onPressed: () async {
                                          viewModel.isPhoneChecked
                                              ? null
                                              : await viewModel
                                                  .phoneVerifyCheck(
                                                      _userPhone.text,
                                                      _verifyCode.text,
                                                      3);
                                          if (!mounted) return;
                                          if (viewModel.isPhoneChecked) {
                                            showSnackBar(context, "인증되었습니다.");
                                          } else {
                                            showSnackBar(
                                                context, "인증번호가 일치하지 않습니다.");
                                          }
                                        },
                                        backgroundColor:
                                            viewModel.isPhoneChecked
                                                ? const Color(0xffA9B0B8)
                                                : const Color(0xFF2D8CF4),
                                        textColor: Colors.white,
                                        textSize: 12,
                                      ))
                                ],
                              )),
                        ),
                        Visibility(
                          visible: viewModel.isPhoneChecked,
                          child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.86,
                                    child: CustomTextField(
                                      hintText: "비밀번호",
                                      obscureText: true,
                                      controller: _userPassword,
                                      keyboardType: TextInputType.text,
                                      textFontSize: 12,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        Visibility(
                          visible: viewModel.isPhoneChecked,
                          child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.86,
                                    child: CustomTextField(
                                      hintText: "비밀번호 확인",
                                      obscureText: true,
                                      controller: _userPasswordCheck,
                                      keyboardType: TextInputType.text,
                                      textFontSize: 12,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ]),
                    ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: CustomConfirmBtn(
                          text: "비밀번호 변경",
                          onPressed: () async {
                            if (!viewModel.isPhoneChecked) {
                              showSnackBar(context, "인증을 완료해주세요.");
                            } else if (_userPassword.text !=
                                _userPasswordCheck.text) {
                              showSnackBar(context, "비밀번호가 일치하지 않습니다.");
                            } else {
                              await viewModel.changePassword(
                                  _userEmail.text, _userPassword.text);
                              if (!mounted) return;
                              if (viewModel.isChangePassword) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PasswordChangeSuccessPage()));
                              } else {
                                showSnackBar(context, "비밀번호 변경에 실패하였습니다.");
                              }
                            }
                          },
                          backgroundColor: const Color(0xFF2D8CF4),
                          textColor: Colors.white,
                          textSize: 12),
                    ),
                  ],
                ),
              ),
            )),
          ),
        ));
  }

  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      duration: const Duration(milliseconds: 1000),
    ));
  }
}
