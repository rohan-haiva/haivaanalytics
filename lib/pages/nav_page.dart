import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haivanalytics/pages/agent_chat_page.dart';
import 'package:haivanalytics/pages/haiva-flow/flow_chat_haiva.dart';
import 'package:haivanalytics/pages/profile_page.dart';
import 'package:haivanalytics/pages/settings_page.dart';
import 'package:haivanalytics/theme/colortheme.dart';
import 'package:provider/provider.dart';
import '../models/agent.dart';
import '../providers/agent_provider.dart';
import 'chat_page.dart';

class MainNavigationPage extends StatefulWidget {
  final String agentId;
  const MainNavigationPage({Key? key, required this.agentId}) : super(key: key);

  @override
  _MainNavigationPageState createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  late final PageController _pageController;
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {

    print("agentid from main nav page = ${widget.agentId}");
    super.initState();
    _pageController = PageController(initialPage: 0);
    _pages = [
      HaivaChatScreen(agentId: widget.agentId),

      SettingsPage(agentId: widget.agentId),

      ProfilePage(agentId: widget.agentId),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(

          backgroundColor: ColorTheme.primary,
          actions: [
            CupertinoSegmentedControl<int>(
         selectedColor: ColorTheme.accent,

          borderColor:ColorTheme.secondary ,
            children: const {
              0: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text('Chat'),
              ),
              1: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text('Settings'),
              ),

              2: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text('Profile'),
              ),
            },
            onValueChanged: (int index) {
              setState(() {
                _selectedIndex = index;
                _pageController.jumpToPage(index);
              });
            },
            groupValue: _selectedIndex,
          )],
        ),
        body: SafeArea(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            children: _pages,
          ),
        ),
      ),
    );
  }
}