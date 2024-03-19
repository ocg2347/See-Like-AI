import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';

import 'package:document_analysis/document_analysis.dart';

String getOpponentName(
  int opponentindex,
  List<String> opponentnames,
) {
  return opponentnames.elementAt(opponentindex);
}

String miliseonds2SecondsStr(int miliseconds) {
  num seconds = miliseconds ~/ 1000;
  return seconds.toString();
}

int getOpponentLevel(
  List<int> opponentlevels,
  int opponentidx,
) {
  return opponentlevels.elementAt(opponentidx);
}

double miliseconds2progress(
  int miliseconds,
  int roundlength,
) {
  double progress = 1.0 - (miliseconds / (roundlength));
  return progress;
}

double dummyprogress(int miliseconds) {
  double a = 0.8;
  return a;
  // Add your function code here!
}

int getOpponentPoints(
  List<int> opponentPoints,
  int questionNo,
) {
  return opponentPoints.elementAt(questionNo);
}

String getAnswer(
  List<String> opponentAnswers,
  int questionno,
) {
  return opponentAnswers.elementAt(questionno);
}
/*
int computePoints(
  String? answer,
  int questionno,
) {
  if (answer != null) {
    return 100;
  } else {
    return 90;
  }
}
*/
int computePoints2(
    String answer,
    String groundTruth,
    ) {
  //return 100;
  double similarity=wordFrequencySimilarity(groundTruth, answer, distanceFunction: jaccardDistance);
  if (answer.isEmpty){
    return 0;
  }
  else{
    int point = ((similarity*100).round()~/5+1)*5;
    return point;
  }
}

int incrementbyOne(int somenumber) {
  return somenumber + 1;
}

int getExperience(
    int userscore,
    int opponentscore,
    ) {
  int exp = userscore * 100 - opponentscore * 10;
  if(exp<0){
    return 0;
  }else{
    return exp;
  }
}
