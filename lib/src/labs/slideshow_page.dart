import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:slideshow_app/src/models/slider_model.dart';

import 'package:flutter_svg/flutter_svg.dart';

class SlideShowPage extends StatelessWidget {
  const SlideShowPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Aqui colocamos el ChangeNotifierProvider
    return ChangeNotifierProvider(
      // Crea la instancia de mi clase SliderModel()
      create: (_) => SliderModel(),
      child: const Scaffold(
        body: Center(
            child: Column(
          children: [Expanded(child: _Slides()), _Dots()],
        )),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots();

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      width: double.infinity,
      height: 60,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Dot(0), 
          _Dot(1), 
          _Dot(2)
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;
  const _Dot(this.index);

  @override
  Widget build(BuildContext context) {
    
    final double pageViewIndex = Provider.of<SliderModel>(context).currentPage;
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 10,
      height: 10,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: (pageViewIndex >= index - 0.5 && pageViewIndex < index + 0.5) 
          ? const Color.fromARGB(255, 51, 158, 55)  : Colors.grey, 
        shape: BoxShape.circle
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  const _Slides();

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final pageViewController = PageController();

  @override
  void initState() {
    super.initState();

    pageViewController.addListener(() {
      // print('Pagina actual: ${pageViewController.page}');
      // Aqui se actualiza el Provider de mi clase SliderModel()
      // Colocar el listen en falso ya que estamos en el initState()
      Provider.of<SliderModel>(context, listen: false).currentPage = pageViewController.page!;
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: PageView(
        controller: pageViewController,
        children: const [
          _Slide('assets/svgs/slide-1.svg'),
          _Slide('assets/svgs/slide-2.svg'),
          _Slide('assets/svgs/slide-3.svg'),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final String svg;

  const _Slide(this.svg);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(30),
      child: SvgPicture.asset(svg),
    );
  }
}
