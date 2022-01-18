import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PinterestButton {
  final Function onPressed;
  final IconData icon;

  PinterestButton({required this.icon, required this.onPressed});
}

class PinterestMenu extends StatelessWidget {
  final bool mostrar;
  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;
  final List<PinterestButton> items;

  PinterestMenu(
      {this.mostrar = true,
      this.backgroundColor = Colors.white,
      this.activeColor = Colors.black,
      this.inactiveColor = Colors.blueGrey,
      required this.items});

      
  // final List<PinterestButton> items = [
  //   PinterestButton(
  //       icon: Icons.pie_chart,
  //       onPressed: () {
  //         print("Icon pie_chart");
  //       }),
  //   PinterestButton(
  //       icon: Icons.search,
  //       onPressed: () {
  //         print("Icon search");
  //       }),
  //   PinterestButton(
  //       icon: Icons.notifications,
  //       onPressed: () {
  //         print("Icon notifications");
  //       }),
  //   PinterestButton(
  //       icon: Icons.supervised_user_circle,
  //       onPressed: () {
  //         print("Icon supervised_user_circle");
  //       }),
  // ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => new _MenuModel(),
        child: Builder(
          builder: (context) {
            final menuStyle = Provider.of<_MenuModel>(context);
            menuStyle
              ..activeColor = this.activeColor
              ..inactiveColor = this.inactiveColor
              ..backgroundColor = this.backgroundColor;

            return AnimatedOpacity(
                duration: Duration(milliseconds: 250),
                opacity: (mostrar) ? 1 : 0,
                child: _PinterestMenuBackground(_MenuItem(items)));
          },
        ));
  }
}

class _PinterestMenuBackground extends StatelessWidget {
  final Widget child;
  _PinterestMenuBackground(this.child);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      width: 250,
      height: 60,
      decoration: BoxDecoration(
          color: Provider.of<_MenuModel>(context).backgroundColor,
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(100)),
          boxShadow: [
            BoxShadow(
                color: Colors.black38,
                // offset: Offset(10,10),
                blurRadius: 10,
                spreadRadius: -5)
          ]),
      // child: ,
    );
  }
}

class _MenuItem extends StatelessWidget {
  final List<PinterestButton> menuItems;
  _MenuItem(this.menuItems);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(menuItems.length,
          (index) => _PrinterestMenuButton(index, menuItems[index])),
    );
  }
}

class _PrinterestMenuButton extends StatelessWidget {
  final int index;
  final PinterestButton item;

  _PrinterestMenuButton(this.index, this.item);

  @override
  Widget build(BuildContext context) {
    final menuItem = Provider.of<_MenuModel>(context);
    final Color color;
    final double size;
    if (menuItem.selectedItem == index) {
      color = menuItem.activeColor;
      size = 35.0;
    } else {
      color = menuItem.inactiveColor;
      size = 25.0;
    }
    return GestureDetector(
      onTap: () {
        Provider.of<_MenuModel>(context, listen: false).selectedItem = index;
        item.onPressed();
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        child: Icon(
          item.icon,
          size: size,
          color: color,
        ),
      ),
    );
  }
}

class _MenuModel with ChangeNotifier {
  int _selectedItem = 0;
  Color _backgroundColor = Colors.white;
  Color _activeColor = Colors.black;
  Color _inactiveColor = Colors.blueGrey;

  int get selectedItem => this._selectedItem;

  set selectedItem(int index) {
    this._selectedItem = index;
    notifyListeners();
  }

  Color get backgroundColor => this._backgroundColor;

  set backgroundColor(Color color) {
    this._backgroundColor = color;
  }

  Color get activeColor => this._activeColor;

  set activeColor(Color color) {
    this._activeColor = color;
  }

  Color get inactiveColor => this._inactiveColor;

  set inactiveColor(Color color) {
    this._inactiveColor = color;
  }
}
