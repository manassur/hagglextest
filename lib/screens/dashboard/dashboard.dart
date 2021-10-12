import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hagglextest/utility/colors.dart';
import 'package:hagglextest/utility/styles.dart';
import 'package:hagglextest/widgets/custom_switch.dart';

import 'fragments/home_fragment.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => new _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _cIndex = 0;

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }

  List<Widget> fragments = [
    HomeFragment(),
    Container(),
    Container(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: fragments[_cIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _cIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg/home.svg',
                color: _cIndex == 0 ? AppColors.primaryColor : Colors.grey,
              ),
              title: new Text('Home')),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg/wallet.svg',
                color: _cIndex == 1 ? AppColors.primaryColor : Colors.grey,
              ),
              title: new Text('Wallet')),
          BottomNavigationBarItem(
            title: Text(''),
            icon: SizedBox(
              height: 50,
              width: 50,
              child: FloatingActionButton(
                onPressed: () {},
                elevation: 0,
                backgroundColor: AppColors.primaryColor,
                child: new Icon(Icons.add),
              ),
            ),
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg/cryptosave.svg',
                color: _cIndex == 3 ? AppColors.primaryColor : Colors.grey,
              ),
              title: new Text('Cryptosave')),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg/more.svg',
                color: _cIndex == 4 ? AppColors.primaryColor : Colors.grey,
              ),
              title: new Text('More'))
        ],
        onTap: (index) {
          _incrementTab(index);
        },
      ),
    );
  }
}
