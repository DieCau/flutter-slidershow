import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:slideshow_app/src/models/slider_model.dart';

class Slideshow extends StatelessWidget {
  
  final List<Widget> slides;
  
  const Slideshow({
    super.key,
    required this.slides
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => SliderModel(),
        child: Center(
          child: Column(
            children: [
              Expanded(child: 
                _Slides(slides)
              ), 
              _Dots(slides.length)],
          ),
        ));
  }
}

class _Dots extends StatelessWidget {
  
  final int totalSlides;
  const _Dots(this.totalSlides);

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      width: double.infinity,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalSlides, (index) => _Dot(index)),
        // children: [
        //   _Dot(0), 
        //   _Dot(1), 
        //   _Dot(2)
        // ],

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
      width: 9,
      height: 9,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: (pageViewIndex >= index - 0.5 && pageViewIndex < index + 0.5)
              ? const Color.fromARGB(255, 51, 158, 55)
              : Colors.grey,
          shape: BoxShape.circle),
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> slides;

  const _Slides( this.slides);

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
        children: widget.slides.map((slide) => _Slide(slide)).toList(),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;

  const _Slide(this.slide);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(30),
      child: slide,
    );
  }
}
