import 'package:clean_architecture/presentation/onboarding/onboarding_viewmodel.dart';
import 'package:clean_architecture/presentation/resources/assets_manager.dart';
import 'package:clean_architecture/presentation/resources/color_manager.dart';
import 'package:clean_architecture/presentation/resources/strings_manager.dart';
import 'package:clean_architecture/presentation/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../domain/model.dart';
import '../resources/route_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {

  PageController _pageController = PageController(initialPage: 0);
  OnBoardingViewModel _viewModel=OnBoardingViewModel();
  _bind()
  {
    _viewModel.start();
  }


  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  Widget build(BuildContext context)
  {
    return StreamBuilder<SliderViewObject>(
         stream: _viewModel.outputSliderViewObject,
        builder: (context,snapshot)
        {
          return _getContentWidget(snapshot.data);
        },

        ) ;
  }
  Widget _getContentWidget(SliderViewObject? sliderViewObject)
  {

    return sliderViewObject==null?Container():Scaffold(
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
          itemCount: sliderViewObject.numOfSlides,
          onPageChanged: (index) {
            _viewModel.onPageChanged(index);
            // setState(() {
            //   ss = index;
            // });
          },
          itemBuilder: (context, index) {

            return OnBoardingPage(sliderViewObject.sliderObjects);

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
            _getBottomSheetWidget(sliderViewObject)

            // add layout for indicator and arrows
          ],
        ),

      ),

    );



  }

  @override
  void dispose() {
    //view model dispose
    super.dispose();
    _viewModel.dispose();

  }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject)
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
                child: SvgPicture.asset(ImageAssets.leftArrowIc,color: Colors.black,),
              ),
              onTap: (){
                // go to next slide
                _pageController.animateToPage(_viewModel.goPrev() ,duration:Duration(milliseconds: DurationConstant.d300), curve: Curves.bounceInOut);


              },
            ),
          ),
          //cicrle indicator

          Row(
            children: [
              for(int i=0;i<sliderViewObject.numOfSlides;i++)
                Padding(padding: EdgeInsets.all(AppPadding.p8),
                  child: _getProperCircle(i,sliderViewObject.currentIndex),


                ),

            ],
          ),
          Padding(
            padding: EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.rightarrowIc,color: Colors.black,),
              ),
              onTap: (){
                // go to prev slide
                _pageController.animateToPage(_viewModel.goNext(), duration:Duration(milliseconds: DurationConstant.d300), curve: Curves.bounceInOut);


              },
            ),
          ),
        ],
      ),
    );
  }

 Widget _getProperCircle(int index,int currentIndex)
 {
   if(index==currentIndex)
     {
       return SvgPicture.asset(ImageAssets.hollowCircleIc);
     }
   else
     {
       return SvgPicture.asset(ImageAssets.solidCircleIc);
     }
 }



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
