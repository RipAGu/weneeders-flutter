import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/MainBottomNavigationBar.dart';
import 'package:winit/view/feed/FeedListPage.dart';
import 'package:winit/view/project/Detail/DetailPartnerPage.dart';
import 'package:winit/view/project/Detail/DetailProjectPage.dart';
import 'package:winit/view/project/Detail/DetailViewModel.dart';
import 'package:winit/view/project/Register/RegisterPartnerPage.dart';
import 'package:winit/view/project/Register/RegisterProjectPage.dart';
import 'package:winit/view/skillData/SkillDataListPage.dart';
import 'package:winit/view/widget/BigGrayBtn.dart';
import 'package:winit/view/widget/CustomDialogSelect.dart';
import 'package:winit/view/widget/CustomDrawer.dart';
import 'package:winit/view/widget/MainAppBar.dart';
import 'package:winit/view/widget/ProjectCard.dart';

import '../account/SignInPage.dart';
import 'MainViewModel.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final String logo = "assets/icons/logo.svg";
  final String profile = "assets/icons/icon_profile.svg";
  final String menu = "assets/icons/menu.svg";
  final String searchImage = "assets/images/search.svg";
  final String whiteLogo = "assets/icons/white_logo.svg";
  final String searchIcon = "assets/icons/project_search.svg";
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    final mainContext = context;
    return ChangeNotifierProvider(
      create: (context) => MainViewModel(),
      child: Consumer<MainViewModel>(
        builder: (context, viewModel, child) => Scaffold(
          endDrawer: CustomDrawer(
            onLogout: () {
              showDialog(
                  context: context,
                  builder: (context) => CustomDialogSelect(
                      title: "로그아웃",
                      content: "로그아웃 하시겠습니까?",
                      cancelText: "취소",
                      confirmText: "확인",
                      cancelPressed: () {
                        Navigator.pop(context);
                      },
                      confirmPressed: () async {
                        print("로그아웃");
                        await storage.delete(key: "token");
                        if (!mounted) return;
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const SignInPage()),
                            (route) => false);
                      }));
            },
            registerProject: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterProjectPage()));
            },
            registerPartner: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterPartnerPage()));
            },
          ),
          backgroundColor: Colors.white,
          appBar: const MainAppBar(),
          body: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: SingleChildScrollView(
                child: Column(children: [
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  SvgPicture.asset(
                    searchImage,
                    width: MediaQuery.of(context).size.width * 1,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 1,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      //클릭시 로그 출력
                      BigGrayBtn(
                        text: '프로젝트 검색',
                        image: searchIcon,
                        onPressed: () {
                          BottomNavigationBar navigationBar = bottomNavBarKey
                              .currentWidget as BottomNavigationBar;
                          navigationBar.onTap!(1);
                        },
                        textColor: Colors.black,
                        fontSize: 12,
                      ),
                      BigGrayBtn(
                        text: '파트너 검색',
                        image: "assets/icons/partner_search.svg",
                        onPressed: () {
                          BottomNavigationBar navigationBar = bottomNavBarKey
                              .currentWidget as BottomNavigationBar;
                          navigationBar.onTap!(2);
                        },
                        textColor: Colors.black,
                        fontSize: 12,
                      ),
                      BigGrayBtn(
                        text: '파트너 등록',
                        image: "assets/icons/partner_register.svg",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RegisterPartnerPage()));
                        },
                        textColor: Colors.black,
                        fontSize: 12,
                      ),
                      BigGrayBtn(
                        text: '프로젝트 등록',
                        image: "assets/icons/project_register.svg",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RegisterProjectPage()));
                        },
                        textColor: Colors.black,
                        fontSize: 12,
                      ),
                      BigGrayBtn(
                        text: '기술 공유',
                        image: "assets/icons/share.svg",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FeedListPage()));
                        },
                        textColor: Colors.black,
                        fontSize: 12,
                      ),
                      BigGrayBtn(
                        text: '위닛의 기술 자료',
                        image: "assets/icons/tech.svg",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SkillDataListPage()));
                        },
                        textColor: Colors.black,
                        fontSize: 12,
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Fluttertoast.showToast(
                        msg: "준비중인 기능입니다.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey[500],
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.43,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: ShapeDecoration(
                        color: const Color(0xff2d8cf4),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999)),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x332D8DF4),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            whiteLogo,
                          ),
                          const Padding(padding: EdgeInsets.only(left: 13)),
                          const Text(
                            "위닛헌터 요청",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 40)),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "우수 파트너스",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              BottomNavigationBar navigationBar =
                                  bottomNavBarKey.currentWidget
                                      as BottomNavigationBar;
                              navigationBar.onTap!(2);
                            },
                            child: SvgPicture.asset(
                                "assets/icons/add_and_text.svg")),
                      ]),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 1,
                    color: Colors.grey[300],
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: viewModel.partnerList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(top: 10),
                              height: MediaQuery.of(context).size.height * 0.13,
                              child: ProjectCard(
                                image: Provider.of<MainViewModel>(context)
                                        .partnerList[index]
                                        .PartnerImg
                                        .isEmpty
                                    ? null
                                    : Provider.of<MainViewModel>(context)
                                        .partnerList[index]
                                        .PartnerImg[0]
                                        .img,
                                content: Provider.of<MainViewModel>(context)
                                    .partnerList[index]
                                    .method,
                                writer: Provider.of<MainViewModel>(context)
                                    .partnerList[index]
                                    .User
                                    .name,
                                location: Provider.of<MainViewModel>(context)
                                    .partnerList[index]
                                    .Depth2Region
                                    .Depth1Region
                                    .name,
                                date: Provider.of<MainViewModel>(context)
                                    .partnerList[index]
                                    .createdAt,
                                onPressed: () {
                                  Navigator.push(
                                      mainContext,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailPartnerPage(
                                                idx: viewModel
                                                    .partnerList[index].idx,
                                              ))).then((value) {
                                    if (value == true) {
                                      viewModel.getPartnerList();
                                    }
                                  });
                                },
                              ),
                            );
                          })),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "실시간 프로젝트",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                BottomNavigationBar navigationBar =
                                    bottomNavBarKey.currentWidget
                                        as BottomNavigationBar;
                                navigationBar.onTap!(1);
                              },
                              child: SvgPicture.asset(
                                  "assets/icons/add_and_text.svg")),
                        ]),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 1,
                    color: Colors.grey[300],
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: Provider.of<MainViewModel>(context)
                              .projectList
                              .length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(top: 10),
                              height: MediaQuery.of(context).size.height * 0.13,
                              child: ProjectCard(
                                image: Provider.of<MainViewModel>(context)
                                    .projectList[index]
                                    .ProjectImg[0]
                                    .imgPath,
                                content: Provider.of<MainViewModel>(context)
                                    .projectList[index]
                                    .method,
                                writer: Provider.of<MainViewModel>(context)
                                    .projectList[index]
                                    .User
                                    .nickname,
                                location: Provider.of<MainViewModel>(context)
                                    .projectList[index]
                                    .Depth2Region
                                    .Depth1Region
                                    .name,
                                date: Provider.of<MainViewModel>(context)
                                    .projectList[index]
                                    .createdAt,
                                onPressed: () {
                                  Navigator.push(
                                      mainContext,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailProjectPage(
                                                  idx: viewModel
                                                      .projectList[index]
                                                      .idx))).then((value) {
                                    if (value == true) {
                                      viewModel.getProjectList();
                                    }
                                  });
                                },
                              ),
                            );
                          })),
                  const Padding(padding: EdgeInsets.only(bottom: 30)),
                ]),
              )),
        ),
      ),
    );
  }
}
