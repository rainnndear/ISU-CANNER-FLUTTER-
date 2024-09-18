import 'package:flutter/material.dart';

class ClientCustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const ClientCustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: selectedIndex == 0 ? 1 : 0),
              duration: const Duration(milliseconds: 300),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, -value * 10),
                  child:const Icon(Icons.home, size: 30,),
                );
              },
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: selectedIndex == 1 ? 1 : 0),
              duration: const Duration(milliseconds: 300),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, -value * 10),
                  child:const Icon(Icons.notifications, size: 30,),
                );
              },
            ),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: selectedIndex == 2 ? 1 : 0),
              duration:const Duration(milliseconds: 300),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, -value * 10),
                  child:const Icon(Icons.menu,size: 30,),
                );
              },
            ),
            label: 'Menu',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.green,
        onTap: onItemTapped,
        backgroundColor: Colors.grey[200],
      ),
    );
  }
}









class SupplierCustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const SupplierCustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: selectedIndex == 0 ? 1 : 0),
              duration:const Duration(milliseconds: 300),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, -value * 10),
                  child:const Icon(Icons.home, size: 30,),
                );
              },
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: selectedIndex == 1 ? 1 : 0),
              duration:const Duration(milliseconds: 300),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, -value * 10),
                  child: const Icon(Icons.notifications, size: 30,),
                );
              },
            ),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: selectedIndex == 2 ? 1 : 0),
              duration:const Duration(milliseconds: 300),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, -value * 10),
                  child:const Icon(Icons.menu,size: 30,),
                );
              },
            ),
            label: 'Menu',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.green,
        onTap: onItemTapped,
        backgroundColor: Colors.grey[200],
      ),
    );
  }
}