import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_timer.dart';
import '../flutter_flow/flutter_flow_toggle_icon.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:percent_indicator/percent_indicator.dart';

class OnGoingMatchWidget extends StatefulWidget {
  const OnGoingMatchWidget({
    Key? key,
    this.myscore,
    this.opponentscore,
    this.round,
    this.opponentname,
    this.opponentlevel,
    this.timerduration,
  }) : super(key: key);

  final int? myscore;
  final int? opponentscore;
  final int? round;
  final String? opponentname;
  final int? opponentlevel;
  final int? timerduration;

  @override
  _OnGoingMatchWidgetState createState() => _OnGoingMatchWidgetState();
}

class _OnGoingMatchWidgetState extends State<OnGoingMatchWidget>
    with TickerProviderStateMixin {
  final animationsMap = {
    'buttonOnActionTriggerAnimation': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: true,
      effects: [
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 50.ms,
          duration: 100.ms,
          begin: 1,
          end: 0.95,
        ),
      ],
    ),
  };
  StopWatchTimer? timerController;
  String? timerValue;
  int? timerMilliseconds;
  AudioPlayer? soundPlayer1;
  AudioPlayer? soundPlayer2;
  TextEditingController? textController;
  AudioPlayer? soundPlayer3;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    // On page load action.
    setState(() => FFAppState().nextimage = (FFAppState().nextimage + 1)%FFAppState().Answers.length );
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 100));
      timerController?.onExecute.add(
        StopWatchExecute.reset,
      );

      timerController?.onExecute.add(
        StopWatchExecute.start,
      );
    });

    if (!isWeb) {
      _keyboardVisibilitySubscription =
          KeyboardVisibilityController().onChange.listen((bool visible) {
        setState(() {
          _isKeyboardVisible = visible;
        });
      });
    }

    textController = TextEditingController();
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    if (!isWeb) {
      _keyboardVisibilitySubscription.cancel();
    }
    textController?.dispose();
    timerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.asset(
              'assets/images/bg.png',
            ).image,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            FlutterFlowTimer(
              timerValue: timerValue ??= StopWatchTimer.getDisplayTime(
                timerMilliseconds ??= widget.timerduration!,
                hours: true,
                minute: true,
                second: true,
                milliSecond: false,
              ),
              timer: timerController ??= StopWatchTimer(
                mode: StopWatchMode.countDown,
                presetMillisecond: timerMilliseconds ??= widget.timerduration!,
                onChange: (value) {
                  setState(() {
                    timerMilliseconds = value;
                    timerValue = StopWatchTimer.getDisplayTime(
                      value,
                      hours: true,
                      minute: true,
                      second: true,
                      milliSecond: false,
                    );
                  });
                },
              ),
              textAlign: TextAlign.start,
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Nunito',
                    color: Colors.white,
                    fontSize: 0,
                  ),
              onEnded: () async {
                timerController?.onExecute.add(
                  StopWatchExecute.stop,
                );

                context.goNamed(
                  'RoundResult',
                  queryParams: {
                    'myscore': serializeParam(
                      widget.myscore,
                      ParamType.int,
                    ),
                    'opponentscore': serializeParam(
                      widget.opponentscore,
                      ParamType.int,
                    ),
                    'round': serializeParam(
                      widget.round,
                      ParamType.int,
                    ),
                    'opponentname': serializeParam(
                      widget.opponentname,
                      ParamType.String,
                    ),
                    'opponentlevel': serializeParam(
                      widget.opponentlevel,
                      ParamType.int,
                    ),
                    'playeranswer': serializeParam(
                      textController!.text,
                      ParamType.String,
                    ),
                    'playerpoint': serializeParam(
                      functions.computePoints2(textController!.text,
                          FFAppState().Answers.elementAt(FFAppState().nextimage)),
                      ParamType.int,
                    ),
                    'opponentpoint': serializeParam(
                      functions.computePoints2(
                          FFAppState().opponentAnswers.elementAt(FFAppState().nextimage), FFAppState().Answers.elementAt(FFAppState().nextimage)),
                      ParamType.int,
                    ),
                    'timerduration': serializeParam(
                      5000,
                      ParamType.int,
                    ),
                  }.withoutNulls,
                );
              },
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 30,
                          borderWidth: 1,
                          buttonSize: 60,
                          icon: Icon(
                            Icons.keyboard_arrow_left,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () async {
                            if (FFAppState().isSoundOn == true) {
                              soundPlayer1 ??= AudioPlayer();
                              if (soundPlayer1!.playing) {
                                await soundPlayer1!.stop();
                              }

                              soundPlayer1!
                                  .setAsset('assets/audios/DM-CGS-21.wav')
                                  .then((_) => soundPlayer1!.play());
                            }

                            context.goNamed('WelcomePage');
                          },
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '1-on-1 Match',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Nunito',
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ToggleIcon(
                          onPressed: () async {
                            setState(() => FFAppState().isSoundOn =
                                !FFAppState().isSoundOn);
                          },
                          value: FFAppState().isSoundOn,
                          onIcon: Icon(
                            FFIcons.kvolumeMedium,
                            color: Colors.white,
                            size: 30,
                          ),
                          offIcon: Icon(
                            FFIcons.kvolumeMute2,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: AlignmentDirectional(0, -0.35),
                child: Material(
                  color: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).customColor9,
                      borderRadius: BorderRadius.circular(10),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(18, 15, 18, 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: AlignmentDirectional(0, -0.95),
                                  child: Text(
                                    'ROUND ${valueOrDefault<String>(
                                      widget.round?.toString(),
                                      '1',
                                    )}',
                                    style: FlutterFlowTheme.of(context)
                                        .title1
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w800,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if ((isWeb
                                  ? MediaQuery.of(context).viewInsets.bottom > 0
                                  : _isKeyboardVisible) ==
                              false)
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Visibility(
                                  visible: (isWeb
                                          ? MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom >
                                              0
                                          : _isKeyboardVisible) ==
                                      false,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(45),
                                              child: Image.asset(
                                                'assets/images/pngfind.com-default-image-png-6764065.png',
                                                width: 40,
                                                height: 40,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  valueOrDefault<String>(
                                                    FFAppState().username,
                                                    'ocg2347',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 3, 0, 0),
                                              child: FFButtonWidget(
                                                onPressed: () {
                                                  print('Button pressed ...');
                                                },
                                                text:
                                                    '${widget.myscore?.toString()}-${widget.opponentscore?.toString()}',
                                                options: FFButtonOptions(
                                                  width: 75,
                                                  height: 40,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .customColor6,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .subtitle2
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                  elevation: 0,
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(45),
                                              child: Image.asset(
                                                'assets/images/pngfind.com-default-image-png-6764065.png',
                                                width: 40,
                                                height: 40,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  widget.opponentname!,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                shape: BoxShape.rectangle,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(0),
                                      child: Image.asset(
                                        'assets/images/questions/'+FFAppState().nextimage.toString()+'.jpg',
                                        width: MediaQuery.of(context)
                                            .size
                                            .width,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: LinearPercentIndicator(
                                  percent: functions.miliseconds2progress(
                                      timerMilliseconds!,
                                      widget.timerduration!),
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  lineHeight: 24,
                                  animation: false,
                                  progressColor:
                                      FlutterFlowTheme.of(context).customColor6,
                                  backgroundColor: Color(0xFF490E96),
                                  center: Text(
                                    functions.miliseonds2SecondsStr(
                                        timerMilliseconds!),
                                    style: FlutterFlowTheme.of(context)
                                        .title2
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: Colors.white,
                                          fontSize: 20,
                                          lineHeight: 1,
                                        ),
                                  ),
                                  barRadius: Radius.circular(20),
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, 1),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20),
                      child: TextFormField(
                        controller: textController,
                        onChanged: (_) => EasyDebounce.debounce(
                          'textController',
                          Duration(milliseconds: 2000),
                          () => setState(() {}),
                        ),
                        onFieldSubmitted: (_) async {
                          if (FFAppState().isSoundOn == true) {
                            soundPlayer2 ??= AudioPlayer();
                            if (soundPlayer2!.playing) {
                              await soundPlayer2!.stop();
                            }

                            soundPlayer2!
                                .setAsset('assets/audios/DM-CGS-21.wav')
                                .then((_) => soundPlayer2!.play());
                          }
                          if (timerMilliseconds == 0) {
                            context.goNamed(
                              'RoundResult',
                              queryParams: {
                                'myscore': serializeParam(
                                  widget.myscore,
                                  ParamType.int,
                                ),
                                'opponentscore': serializeParam(
                                  widget.opponentscore,
                                  ParamType.int,
                                ),
                                'opponentname': serializeParam(
                                  widget.opponentname,
                                  ParamType.String,
                                ),
                                'round': serializeParam(
                                  widget.round,
                                  ParamType.int,
                                ),
                                'opponentlevel': serializeParam(
                                  widget.opponentlevel,
                                  ParamType.int,
                                ),
                                'playeranswer': serializeParam(
                                  textController!.text,
                                  ParamType.String,
                                ),
                                'playerpoint': serializeParam(
                                  functions.computePoints2(
                                      textController!.text, FFAppState().Answers.elementAt(FFAppState().nextimage)),
                                  ParamType.int,
                                ),
                                'opponentpoint': serializeParam(
                                  functions.computePoints2(
                                      FFAppState().opponentAnswers.elementAt(FFAppState().nextimage), FFAppState().Answers.elementAt(FFAppState().nextimage)),
                                  ParamType.int,
                                ),
                                'timerduration': serializeParam(
                                  5000,
                                  ParamType.int,
                                ),
                              }.withoutNulls,
                            );
                          }
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Your Answer',
                          hintStyle:
                              FlutterFlowTheme.of(context).title2.override(
                                    fontFamily: 'Nunito',
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).customColor7,
                              width: 5,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).customColor7,
                              width: 5,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 5,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 5,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Color(0xC26C3EA8),
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                          suffixIcon: textController!.text.isNotEmpty
                              ? InkWell(
                                  onTap: () async {
                                    textController?.clear();
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.clear,
                                    color: FlutterFlowTheme.of(context)
                                        .customColor5,
                                    size: 22,
                                  ),
                                )
                              : null,
                        ),
                        style: FlutterFlowTheme.of(context).title2.override(
                              fontFamily: 'Nunito',
                              color: Colors.white,
                              fontSize: 20,
                            ),
                        maxLines: 2,
                        minLines: 1,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                  if ((isWeb
                          ? MediaQuery.of(context).viewInsets.bottom > 0
                          : _isKeyboardVisible) ==
                      false)
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                      child: FFButtonWidget(
                        onPressed: () async {
                          if (FFAppState().isSoundOn == true) {
                            soundPlayer3 ??= AudioPlayer();
                            if (soundPlayer3!.playing) {
                              await soundPlayer3!.stop();
                            }

                            soundPlayer3!
                                .setAsset('assets/audios/DM-CGS-21.wav')
                                .then((_) => soundPlayer3!.play());
                          }
                          if (animationsMap['buttonOnActionTriggerAnimation'] !=
                              null) {
                            await animationsMap[
                                    'buttonOnActionTriggerAnimation']!
                                .controller
                                .forward(from: 0.0);
                          }
                          if (timerMilliseconds == 0) {
                            context.goNamed(
                              'RoundResult',
                              queryParams: {
                                'myscore': serializeParam(
                                  widget.myscore,
                                  ParamType.int,
                                ),
                                'opponentscore': serializeParam(
                                  widget.opponentscore,
                                  ParamType.int,
                                ),
                                'opponentname': serializeParam(
                                  widget.opponentname,
                                  ParamType.String,
                                ),
                                'round': serializeParam(
                                  widget.round,
                                  ParamType.int,
                                ),
                                'opponentlevel': serializeParam(
                                  widget.opponentlevel,
                                  ParamType.int,
                                ),
                                'playeranswer': serializeParam(
                                  textController!.text,
                                  ParamType.String,
                                ),
                                'playerpoint': serializeParam(
                                  valueOrDefault<int>(
                                    functions.computePoints2(textController!.text,
                                        FFAppState().Answers.elementAt(FFAppState().nextimage)),
                                    0,
                                  ),
                                  ParamType.int,
                                ),
                                'opponentpoint': serializeParam(
                                  functions.computePoints2(
                                      FFAppState().opponentAnswers.elementAt(FFAppState().nextimage), FFAppState().Answers.elementAt(FFAppState().nextimage)),
                                  ParamType.int,
                                ),
                                'timerduration': serializeParam(
                                  5000,
                                  ParamType.int,
                                ),
                              }.withoutNulls,
                            );
                          }
                        },
                        text: 'Guess!',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 60,
                          color: FlutterFlowTheme.of(context).customColor6,
                          textStyle:
                              FlutterFlowTheme.of(context).title2.override(
                                    fontFamily: 'Nunito',
                                    color: Colors.white,
                                    fontSize: 27,
                                  ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ).animateOnActionTrigger(
                        animationsMap['buttonOnActionTriggerAnimation']!,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
