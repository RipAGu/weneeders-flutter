import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/account/register/RegisterSuccessPage.dart';
import 'package:winit/view/account/register/RegisterViewModel.dart';
import 'package:winit/view/widget/CustomConfirmBtn.dart';
import 'package:winit/view/widget/CustomConfirmBtnBorder.dart';
import 'package:winit/view/widget/CustomTextField.dart';

class CustomerRegisterPage extends StatefulWidget {
  const CustomerRegisterPage({Key? key}) : super(key: key);

  @override
  State<CustomerRegisterPage> createState() => _CustomerRegisterPageState();
}

class _CustomerRegisterPageState extends State<CustomerRegisterPage> {
  final TextEditingController _userEmail = TextEditingController();
  final TextEditingController _userPassword = TextEditingController();
  final TextEditingController _userPasswordCheck = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _userNickname = TextEditingController();
  final TextEditingController _userPhone = TextEditingController();
  final TextEditingController _verifyCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterViewModel(),
      child: Consumer<RegisterViewModel>(
        builder: (context, viewModel, child) => Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
                child: SizedBox(
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
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
                                    "업체 회원가입",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                        fontSize: 16),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(top: 10)),
                          Container(
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.63,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        child: CustomTextField(
                                            isEditable: !viewModel.isEmailCheck,
                                            hintText: "이메일",
                                            obscureText: false,
                                            controller: _userEmail,
                                            keyboardType: TextInputType.name,
                                            textFontSize: 12),
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          child: CustomConfirmBtnBorder(
                                            text: "중복확인",
                                            onPressed: () async {
                                              if (viewModel.emailRegexCheck(
                                                  _userEmail.text)) {
                                                await viewModel.emailDupleCheck(
                                                    _userEmail.text);
                                                if (!mounted) return;
                                                if (viewModel.isEmailCheck) {
                                                  showSnackBar(
                                                      context, "사용가능한 이메일입니다.");
                                                } else {
                                                  showSnackBar(context,
                                                      "이미 사용중인 이메일입니다.");
                                                }
                                              } else {
                                                showSnackBar(context,
                                                    "이메일 형식이 올바르지 않습니다.");
                                              }
                                            },
                                            backgroundColor: Colors.white,
                                            textColor: Colors.black,
                                            textSize: 12,
                                          ))
                                    ],
                                  )),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: CustomTextField(
                                    hintText: "비밀번호",
                                    obscureText: true,
                                    controller: _userPassword,
                                    keyboardType: TextInputType.visiblePassword,
                                    textFontSize: 12),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: CustomTextField(
                                    hintText: "비밀번호 확인",
                                    obscureText: true,
                                    controller: _userPasswordCheck,
                                    keyboardType: TextInputType.visiblePassword,
                                    textFontSize: 12),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: CustomTextField(
                                    hintText: "이름",
                                    obscureText: false,
                                    controller: _userName,
                                    keyboardType: TextInputType.visiblePassword,
                                    textFontSize: 12),
                              ),
                              Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.63,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        child: CustomTextField(
                                            hintText: "닉네임 최대12글자",
                                            obscureText: false,
                                            isEditable:
                                                !viewModel.nickNameCheck,
                                            controller: _userNickname,
                                            keyboardType: TextInputType.name,
                                            textFontSize: 12),
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          child: CustomConfirmBtnBorder(
                                            text: "중복확인",
                                            onPressed: () async {
                                              if (_userNickname.text.isEmpty) {
                                                showSnackBar(
                                                    context, "닉네임을 입력해주세요.");
                                                return;
                                              } else if (_userNickname
                                                      .text.length >
                                                  12) {
                                                showSnackBar(context,
                                                    "닉네임은 최대 12글자입니다.");
                                                return;
                                              }
                                              await viewModel
                                                  .nickNameDupleCheck(
                                                      _userNickname.text);
                                              if (!mounted) return;
                                              if (viewModel.nickNameCheck) {
                                                showSnackBar(
                                                    context, "사용가능한 닉네임입니다.");
                                              } else {
                                                showSnackBar(
                                                    context, "이미 사용중인 닉네임입니다.");
                                              }
                                            },
                                            backgroundColor: Colors.white,
                                            textColor: Colors.black,
                                            textSize: 12,
                                          ))
                                    ],
                                  )),
                              Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.63,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        child: CustomTextField(
                                            hintText: "연락처",
                                            isEditable: !viewModel.isSendPhone,
                                            obscureText: false,
                                            controller: _userPhone,
                                            keyboardType: TextInputType.name,
                                            textFontSize: 12),
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          child: CustomConfirmBtn(
                                            text: "인증요청",
                                            onPressed: () {
                                              if (viewModel.isSendPhone) {
                                                return;
                                              } else if (_userPhone
                                                  .text.isEmpty) {
                                                showSnackBar(
                                                    context, "전화번호를 입력해주세요.");
                                              } else {
                                                viewModel.phoneVerify(
                                                    _userPhone.text);
                                              }
                                            },
                                            backgroundColor:
                                                viewModel.isSendPhone
                                                    ? const Color(0xffA9B0B8)
                                                    : const Color(0xFF2D8CF4),
                                            textColor: Colors.white,
                                            textSize: 12,
                                          ))
                                    ],
                                  )),
                              Visibility(
                                visible: viewModel.isSendPhone,
                                child: Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.63,
                                          child: CustomTextField(
                                              hintText: "인증번호",
                                              obscureText: false,
                                              controller: _verifyCode,
                                              keyboardType:
                                                  TextInputType.number,
                                              textFontSize: 12),
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            child: CustomConfirmBtn(
                                              text: "인증확인",
                                              onPressed: () async {
                                                viewModel.isPhoneCheck
                                                    ? null
                                                    : await viewModel
                                                        .phoneVerifyCheck(
                                                            _userPhone.text,
                                                            _verifyCode.text);
                                                if (!mounted) return;
                                                print(viewModel.isPhoneCheck);
                                                if (viewModel.isPhoneCheck) {
                                                  showSnackBar(
                                                      context, "인증되었습니다.");
                                                } else {
                                                  showSnackBar(context,
                                                      "인증번호가 일치하지 않습니다.");
                                                }
                                              },
                                              backgroundColor:
                                                  viewModel.isPhoneCheck
                                                      ? const Color(0xffA9B0B8)
                                                      : const Color(0xFF2D8CF4),
                                              textColor: Colors.white,
                                              textSize: 12,
                                            ))
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
                                text: "회원가입",
                                onPressed: () async {
                                  if (!viewModel.dupleCheck()) {
                                    showSnackBar(context, "중복확인을 해주세요.");
                                  } else if (_userPassword.text !=
                                      _userPasswordCheck.text) {
                                    showSnackBar(context, "비밀번호가 일치하지 않습니다.");
                                  } else if (!viewModel
                                      .passwordRegexCheck(_userPassword.text)) {
                                    showSnackBar(context,
                                        "비밀번호는 8자리 이상, 영문, 숫자, 특수문자를 포함해야 합니다.");
                                  } else if (!viewModel.isPhoneCheck) {
                                    showSnackBar(context, "휴대폰 인증을 해주세요.");
                                  } else if (_userEmail.text == '' ||
                                      _userPassword.text == '' ||
                                      _userPasswordCheck.text == '' ||
                                      _userName.text == '' ||
                                      _userNickname.text == '' ||
                                      _userPhone.text == '' ||
                                      _verifyCode.text == '') {
                                    showSnackBar(context, "빈칸을 모두 채워주세요.");
                                  } else {
                                    await viewModel.register(
                                        _userEmail.text,
                                        _userPassword.text,
                                        _userName.text,
                                        _userNickname.text,
                                        1);
                                    if (!mounted) return;
                                    if (viewModel.isRegisterSuccess) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const RegisterSuccessPage()));
                                    } else {
                                      showSnackBar(context, "회원가입에 실패하였습니다.");
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
                  )
                ],
              ),
            ))),
      ),
    );
  }

  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      duration: const Duration(milliseconds: 1000),
    ));
  }
}
