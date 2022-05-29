import 'package:clean_architecture/presentation/resources/assets_manager.dart';
import 'package:clean_architecture/presentation/resources/color_manager.dart';
import 'package:clean_architecture/presentation/resources/strings_manager.dart';
import 'package:clean_architecture/presentation/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/route_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  late final List<SliderObjects> _list = _getSliderData();
  PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  List<SliderObjects> _getSliderData() => [
        SliderObjects(ImageAssets.onboardingLogo1, AppStrings.onBoardingTitle1,
            AppStrings.onBoardingSubTitle1),
        SliderObjects(ImageAssets.onboardingLogo2, AppStrings.onBoardingTitle2,
            AppStrings.onBoardingSubTitle2),
        SliderObjects(ImageAssets.onboardingLogo3, AppStrings.onBoardingTitle3,
            AppStrings.onBoardingTitle3),
        SliderObjects(ImageAssets.onboardingLogo4, AppStrings.onBoardingTitle4,
            AppStrings.onBoardingTitle4),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: AppSize.s0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark,
              statusBarColor: ColorManager.white,
              statusBarIconBrightness: Brightness.dark),
        ),
        backgroundColor: ColorManager.white,
        body: PageView.builder(
            controller: _pageController,
            itemCount: _list.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {

              return OnBoardingPage(_list[index]);

            }),
      bottomSheet: Container(
        color: ColorManager.white,
        height: AppSize.s100,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(onPressed: (){
           Navigator.pushReplacementNamed(context, Routes.loginRoute);
              }, child: Text(
                AppStrings.skip,
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.subtitle1,

              )),
            ),
            _getBottomSheetWidget()

            // add layout for indicator and arrows
          ],
        ),

      ),

    );
  }
  Widget _getBottomSheetWidget()
  {

    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.leftArrowIc),
              ),
              onTap: (){
                // go to next slide
                _pageController.animateToPage(_getNextIndex(), duration:Duration(milliseconds: DurationConstant.d300), curve: Curves.bounceInOut);


              },
            ),
          ),
          //cicrle indicator

          Row(
            children: [
              for(int i=0;i<_list.length;i++)
                Padding(padding: EdgeInsets.all(AppPadding.p8),
                  child: _getProperCircle(i),


                ),

            ],
          ),
          Padding(
            padding: EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.rightarrowIc),
              ),
              onTap: (){
                // go to prev slide
                _pageController.animateToPage(_getPreviosIndex(), duration:Duration(milliseconds: DurationConstant.d300), curve: Curves.bounceInOut);


              },
            ),
          ),
        ],
      ),
    );
  }

 Widget _getProperCircle(int index)
 {
   if(index==_currentIndex)
     {
       return SvgPicture.asset(ImageAssets.hollowCircleIc);
     }
   else
     {
       return SvgPicture.asset(ImageAssets.solidCircleIc);
     }
 }

  int _getPreviosIndex() {
    int prevIndex=_currentIndex --;
    if(prevIndex==-1)
      {
        _currentIndex=_list.length-1;
      }
    return _currentIndex;
  }
  int _getNextIndex() {
    int nextIndex=_currentIndex ++;
    if(nextIndex>=_list.length)
    {
      _currentIndex=0;
    }
    return _currentIndex;
  }

}

class SliderObjects {
  String title;
  String subTitle;
  String image;

  SliderObjects(this.image, this.subTitle, this.title);
}








class OnBoardingPage extends StatelessWidget {
  SliderObjects _sliderObjects;

  OnBoardingPage(this._sliderObjects, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding:  EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObjects.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Padding(
          padding:  EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObjects.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        SizedBox(height: AppSize.s60 ,),

        //image widget
       SvgPicture.asset(_sliderObjects.image)





      ],
    );
  }
}
