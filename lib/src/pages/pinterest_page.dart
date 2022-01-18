import 'package:diseno_app/src/widgets/pinterest_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class PinterestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _MenuModel(),
      child: Scaffold(
        // body: PinterestGrid(),
        // body: PinterestMenu(),
        body: Stack(
          children: [
            PinterestGrid(),
            _PinterestMenuLocation(),
          ],
        ),
      ),
    );
  }
}

class _PinterestMenuLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    final mostrar = Provider.of<_MenuModel>(context).show;
    if (widthScreen > 500) {
      widthScreen = widthScreen - 300;
    }
    return Positioned(
        bottom: 30,
        child: Container(
            // color: Colors.red,
            width: widthScreen,
            child: Row(
              children: [
                Spacer(),
                PinterestMenu(
                  mostrar: mostrar,
                  activeColor: Color(0xFFFFFFFF),
                  inactiveColor: Color(0xFFE7E6E5),
                  backgroundColor: Color(0xFF172834),
                  items: [
                    PinterestButton(
                        icon: Icons.pie_chart,
                        onPressed: () {
                          print("Icon pie_chart");
                        }),
                    PinterestButton(
                        icon: Icons.search,
                        onPressed: () {
                          print("Icon search");
                        }),
                    PinterestButton(
                        icon: Icons.notifications,
                        onPressed: () {
                          print("Icon notifications");
                        }),
                    PinterestButton(
                        icon: Icons.supervised_user_circle,
                        onPressed: () {
                          print("Icon supervised_user_circle");
                        }),
                  ],
                ),
                Spacer(),
              ],
            )));
  }
}

class PinterestGrid extends StatefulWidget {
  @override
  _PinterestGridState createState() => _PinterestGridState();
}

class _PinterestGridState extends State<PinterestGrid> {
  final List<int> items = List.generate(200, (index) => index);

  ScrollController controller = new ScrollController();
  double scrollAnterior = 0;
  @override
  void initState() {
    // TODO: implement initState

    controller.addListener(() {
      print("${controller.offset}");
      if (controller.offset > scrollAnterior) {
        Provider.of<_MenuModel>(context, listen: false).show = false;
        // print("ocultar menu");
      } else {
        // print("Mostrar Menu");
        Provider.of<_MenuModel>(context, listen: false).show = true;
      }
      scrollAnterior = controller.offset;
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int count;
    if (MediaQuery.of(context).size.width > 500) {
      count = 3;
    } else {
      count = 2;
    }

    return new StaggeredGridView.countBuilder(
      controller: controller,
      crossAxisCount: count,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) => _PinterestItem(index),
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(1, index.isEven ? 1 : 2),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}

class _PinterestItem extends StatelessWidget {
  final int index;
  _PinterestItem(this.index);
  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: new Center(
          child: new CircleAvatar(
            backgroundColor: Colors.white,
            child: new Text('$index'),
          ),
        ));
  }
}

class _MenuModel with ChangeNotifier {
  bool _show = true;

  bool get show => this._show;
  set show(bool value) {
    this._show = value;
    notifyListeners();
  }
}
