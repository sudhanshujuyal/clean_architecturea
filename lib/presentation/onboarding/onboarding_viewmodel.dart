
import 'dart:async';

import 'package:clean_architecture/domain/model.dart';
import 'package:flutter/material.dart';
import '../../domain/model.dart';
import '../base/baseviewmodel.dart';
import '../resources/assets_manager.dart';
import '../resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel with OnBoardingViewModelInputs,OnBoardingViewModelOutputs
{
  // stream controller


  final StreamController _streamController=StreamController<SliderViewObject>();
  late final List<SliderObjects> _list;
  int _currentIndex = 0;
  @override
  void dispose() {
    _streamController.close();
    // TODO: implement dispose
  }

  @override
  void start() {
  _list=_getSliderData();
  //Send this slider data to or view
    _postDataToView();


    // TODO: implement start
  }

  @override
  int goNext() {
    // TODO: implement goNext
    int nextIndex=_currentIndex ++;
    if(nextIndex>=_list.length)
    {
      _currentIndex=0;
    }
    return _currentIndex;
    // _postDataToView();
  }

  @override
 int  goPrev() {
    // TODO: implement goPrev
    int prevIndex=_currentIndex --;
    if(prevIndex==-1)
    {
      _currentIndex=_list.length-1;
    }
    return _currentIndex;
    // _postDataToView();
  }

  @override
  void onPageChanged(int index) {
    // TODO: implement onPageChanged
   _currentIndex=index;
   _postDataToView();

  }

  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  // TODO: implement outputSliderViewObject
  Stream<SliderViewObject> get outputSliderViewObject => _streamController.stream.map((slideViewObject) =>slideViewObject);


  //private function
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

  void _postDataToView() {
    inputSliderViewObject.add(SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }
}

//input mean the orders that out view model will receive from our view
abstract class OnBoardingViewModelInputs
{
void goNext();//when user clicks on right arrow or swipe left
void goPrev();// when user clicks on left arrow or swipe right
void onPageChanged(int index);
Sink get inputSliderViewObject;
}
//input mean the data or result that will be sent from out view model will receive from our view

abstract class OnBoardingViewModelOutputs
{
//
Stream<SliderViewObject> get outputSliderViewObject;

}
class SliderViewObject
{
SliderObjects sliderObjects;
 int numOfSlides;
 int currentIndex;
SliderViewObject(this.sliderObjects,this.numOfSlides,this.currentIndex);
}