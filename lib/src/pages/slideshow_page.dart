import 'package:diseno_app/src/theme/theme.dart';
import 'package:diseno_app/src/widgets/slideshow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SlideShowPage extends StatelessWidget {
  const SlideShowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLarge;

    if (MediaQuery.of(context).size.height > 500) {
      isLarge = true;
    } else {
      isLarge = false;
    }

    final children = [
      Expanded(child: MiSlideShow()),
      Expanded(child: MiSlideShow()),
    ];
    return Scaffold(
        // backgroundColor: Colors.white,
        body: (isLarge)
            ? Column(
                children: children,
              )
            : Row(
                children: children,
              ));
  }
}

class MiSlideShow extends StatelessWidget {
  const MiSlideShow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);
    final accentColor =
        Provider.of<ThemeChanger>(context).currentTheme.accentColor;
    return SlideShow(
      puntosarriba: false,
      primaryColor: appTheme.darkTheme ? accentColor : Color(0xffFF5A7E),
      secundaryColor: Colors.grey,
      primaryBullet: 16,
      secundaryBullet: 12,
      slides: [
        SvgPicture.asset('assets/svgs/slide-1.svg'),
        SvgPicture.asset('assets/svgs/slide-2.svg'),
        SvgPicture.asset('assets/svgs/slide-3.svg'),
        SvgPicture.asset('assets/svgs/slide-4.svg'),
        SvgPicture.asset('assets/svgs/slide-5.svg'),
        // Container(width: 300,height: 300,color: Colors.red,)
      ],
    );
  }
}
