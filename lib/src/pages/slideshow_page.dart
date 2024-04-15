import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import 'package:slideshow_app/src/widgets/slideshow.dart';


class SlideshowPage extends StatelessWidget {
  const SlideshowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffdddf00),
      body: Column(
        children: [
          Expanded(child: MiSlideshow()),
          Expanded(child: MiSlideshow()),
        ],
      )
    );
  }
}

class MiSlideshow extends StatelessWidget {
  const MiSlideshow({super.key});


  @override
  Widget build(BuildContext context) {
    return Slideshow(
      dotsUp: false,
      bulletPrimary: 12,
      bulletSecondary: 7,
      colorPrimary: Colors.green,
      colorSecondary: Colors.blueGrey,
      slides: [
        SvgPicture.asset('assets/svgs/slide-1.svg'),
        SvgPicture.asset('assets/svgs/slide-2.svg'),
        SvgPicture.asset('assets/svgs/slide-3.svg'),
        SvgPicture.asset('assets/svgs/slide-4.svg'),
        SvgPicture.asset('assets/svgs/slide-5.svg'),
      ],
    );
  }
}