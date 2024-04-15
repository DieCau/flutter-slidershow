import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Slideshow extends StatelessWidget {
  
  final List<Widget> slides;
  final bool dotsUp;
  final Color colorPrimary;
  final Color colorSecondary;
  final double bulletPrimary;
  final double bulletSecondary;
  
  const Slideshow({
    super.key,
    required this.slides,
    this.dotsUp          = false,
    this.colorPrimary    = Colors.greenAccent,
    this.colorSecondary  = Colors.grey, 
    this.bulletPrimary   = 12.0, 
    this.bulletSecondary = 12.0,
  });

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => _SlideshowModel(),
      child: SafeArea(
        child: Center(
          child: Builder(builder: (BuildContext context) {

            Provider.of<_SlideshowModel>(context).colorPrimary    = colorPrimary;
            Provider.of<_SlideshowModel>(context).colorSecondary  = colorSecondary;
            Provider.of<_SlideshowModel>(context).bulletPrimary   = bulletPrimary;
            Provider.of<_SlideshowModel>(context).bulletSecondary = bulletSecondary;
            
            return _CreateStructureSildeshow(dotsUp: dotsUp, slides: slides);

          },) 
        ),
      )
    );
  }
}

class _CreateStructureSildeshow extends StatelessWidget {
  const _CreateStructureSildeshow({
    required this.dotsUp,
    required this.slides,
  });

  final bool dotsUp;
  final List<Widget> slides;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if( dotsUp ) 
          _Dots(slides.length),
        Expanded(child: 
          _Slides(slides)
        ), 
        if( !dotsUp ) 
          _Dots(slides.length),
      ],
    );
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
      ),
    );
  }
}

class _Dot extends StatelessWidget {

  final int index;
 

  const _Dot(this.index);

  @override
  Widget build(BuildContext context) {
    
    final ssModel = Provider.of<_SlideshowModel>(context);

    double bullet;
    Color color;

    if( ssModel.currentPage >= index - 0.5 && ssModel.currentPage < index + 0.5 ) {
        bullet = ssModel.bulletPrimary;
        color  = ssModel.colorPrimary;
    } else {
        bullet = ssModel.bulletSecondary;
        color  = ssModel.colorSecondary;
    }


    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: bullet,
      height: bullet,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: color,
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
      Provider.of<_SlideshowModel>(context, listen: false).currentPage = pageViewController.page!;
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

class _SlideshowModel with ChangeNotifier {
  
  double _currentPage     = 0;
  Color _colorPrimary     = Colors.blue;
  Color _colorSecondary   = Colors.grey;
  double _bulletPrimary   = 12.0;
  double _bulletSecondary = 12.0;

  // Hacer un Geeter
  double get currentPage => _currentPage;

  // Hacer un Seeter
  set currentPage(double currentPage) {
    _currentPage = currentPage;
    // Notifica a todos los widgets que esten escuchando el cambio del valor "double _currentPage = 0"
    notifyListeners();
  }

  Color get colorPrimary => _colorPrimary;
  set colorPrimary(Color color) {
    _colorPrimary = color;
  }
  
  Color get colorSecondary => _colorSecondary;
  set colorSecondary(Color color) {
    _colorSecondary = color;
  }
  
  double get bulletPrimary => _bulletPrimary;
  set bulletPrimary(double bullet) {
    _bulletPrimary = bullet;
  }
  
  double get bulletSecondary => _bulletSecondary;
  set bulletSecondary(double bullet) {
    _bulletSecondary = bullet;
  }
  
}
