import 'package:flutter/material.dart';

@immutable
class DurationConstant extends Duration {
  const DurationConstant._();
  
  const DurationConstant.toastDuration() : super(seconds: 2);
  const DurationConstant.lowDuration() : super(milliseconds: 200);
  const DurationConstant.zeroDuration() : super(milliseconds: 0);
  const DurationConstant.mediumDuration() : super(milliseconds: 500);
  const DurationConstant.animatedContainerMediumDuration() : super(milliseconds: 300);
  const DurationConstant.semiMediumDuration() : super(milliseconds: 1000);
  const DurationConstant.highDuration() : super(milliseconds: 1500); //1500
}
