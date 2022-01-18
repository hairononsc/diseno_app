// import 'package:diseno_app/src/models/slider_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//
class SlideShow extends StatelessWidget {
  final List<Widget> slides;
  final bool puntosarriba;
  final Color primaryColor;
  final Color secundaryColor;
  double primaryBullet;
  double secundaryBullet;

  SlideShow(
      {required this.slides,
      this.puntosarriba = false,
      this.primaryColor = Colors.blue,
      this.secundaryColor = Colors.grey,
      this.primaryBullet = 12.0,
      this.secundaryBullet = 12});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => new _SliderModel(),
        child: SafeArea(child: Center(
          child: Builder(
            builder: (BuildContext context) {
              Provider.of<_SliderModel>(context).primaryColor =
                  this.primaryColor;
              Provider.of<_SliderModel>(context).secundaryColor =
                  this.secundaryColor;
              Provider.of<_SliderModel>(context).primaryBullet =
                  this.primaryBullet;
              Provider.of<_SliderModel>(context).secundaryBullet =
                  this.secundaryBullet;

              return _CrearEstructuraSlideShow(
                  puntosarriba: puntosarriba, slides: slides);
            },
          ),
        )));
  }
}

class _CrearEstructuraSlideShow extends StatelessWidget {
  const _CrearEstructuraSlideShow({
    required this.puntosarriba,
    required this.slides,
  });

  final bool puntosarriba;
  final List<Widget> slides;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (this.puntosarriba) _Dots(this.slides.length),
        Expanded(child: _Slides(slides)),
        if (!this.puntosarriba) _Dots(this.slides.length),
      ],
    );
  }
}

class _Dots extends StatelessWidget {
  final int totalSlides;

  _Dots(this.totalSlides);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      // color: Colors.red,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(this.totalSlides, (index) => _Dot(index))),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;

  _Dot(this.index);
  @override
  Widget build(BuildContext context) {
    final slidesShowModel = Provider.of<_SliderModel>(context);
    double size = 0;
    Color color;

    if (slidesShowModel.currentPage >= index - 0.5 &&
        slidesShowModel.currentPage < index + 0.5) {
      size = slidesShowModel.primaryBullet;
      color = slidesShowModel.primaryColor;
    }
    else {
      size = slidesShowModel.secundaryBullet;
      color = slidesShowModel.secundaryColor;
    }
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: size,
      height: size,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> slides;
  _Slides(this.slides);
  @override
  __SlidesState createState() => __SlidesState();
}

class __SlidesState extends State<_Slides> {
  final pageViewController = PageController();

  @override
  void initState() {
    pageViewController.addListener(() {

      Provider.of<_SliderModel>(context, listen: false).currentPage =
          pageViewController.page!;
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
          controller: pageViewController,
          children: widget.slides.map((slide) => _Slide(slide)).toList()),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;
  _Slide(this.slide);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(30),
      child: slide,
    );
  }
}

class _SliderModel with ChangeNotifier {
  double _currentPage = 0;
  Color _primaryColor = Colors.blue;
  Color _secundaryColor = Colors.grey;
  double _primaryBullet = 15.0;
  double _secundaryBullet = 12.0;

  double get currentPage => this._currentPage;

  set currentPage(double currentPage) {
    this._currentPage = currentPage;
    notifyListeners();
  }

  Color get primaryColor => this._primaryColor;
  set primaryColor(Color color) {
    this._primaryColor = color;
    
  }

  Color get secundaryColor => this._secundaryColor;
  set secundaryColor(Color color) {
    this._secundaryColor = color;
    
  }

  double get primaryBullet => this._primaryBullet;
  set primaryBullet(double value) {
    this._primaryBullet = value;
    
  }

  double get secundaryBullet => this._secundaryBullet;
  set secundaryBullet(double value) {
    this._secundaryBullet = value;
    
  }
}
