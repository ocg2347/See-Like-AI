import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_toggle_icon.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TutoInteractiveRound1Widget extends StatefulWidget {
  const TutoInteractiveRound1Widget({Key? key}) : super(key: key);

  @override
  _TutoInteractiveRound1WidgetState createState() =>
      _TutoInteractiveRound1WidgetState();
}

class _TutoInteractiveRound1WidgetState
    extends State<TutoInteractiveRound1Widget> with TickerProviderStateMixin {
  AudioPlayer? soundPlayer1;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;
  AudioPlayer? soundPlayer2;
  TextEditingController? textController;
  var hasContainerTriggered2 = false;
  var hasButtonTriggered2 = false;
  final animationsMap = {
    'containerOnActionTriggerAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: true,
      effects: [
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 1.ms,
          duration: 250.ms,
          begin: 1,
          end: 1.1,
        ),
      ],
    ),
    'containerOnActionTriggerAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: false,
      effects: [
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 1.ms,
          duration: 250.ms,
          begin: 1,
          end: 1.1,
        ),
      ],
    ),
    'containerOnActionTriggerAnimation3': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: true,
      effects: [
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 1.ms,
          duration: 250.ms,
          begin: 1,
          end: 1.1,
        ),
      ],
    ),
    'textFieldOnActionTriggerAnimation': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: true,
      effects: [
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 1.ms,
          duration: 250.ms,
          begin: 1,
          end: 1.05,
        ),
      ],
    ),
    'buttonOnActionTriggerAnimation1': AnimationInfo(
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
    'buttonOnActionTriggerAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: false,
      effects: [
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 250.ms,
          begin: 1,
          end: 0.9,
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      soundPlayer1 ??= AudioPlayer();
      if (soundPlayer1!.playing) {
        await soundPlayer1!.stop();
      }

      soundPlayer1!
          .setAsset('assets/audios/DM-CGS-21.wav')
          .then((_) => soundPlayer1!.play());

      setState(() => FFAppState().tutoPhase = 1);
      if (animationsMap['containerOnActionTriggerAnimation2'] != null) {
        setState(() => hasContainerTriggered2 = true);
        SchedulerBinding.instance.addPostFrameCallback((_) async =>
            await animationsMap['containerOnActionTriggerAnimation2']!
                .controller
              ..reset()
              ..repeat(reverse: true));
      }
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
  }

  @override
  void dispose() {
    if (!isWeb) {
      _keyboardVisibilitySubscription.cancel();
    }
    textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).customColor7,
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
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                    soundPlayer2 ??= AudioPlayer();
                                    if (soundPlayer2!.playing) {
                                      await soundPlayer2!.stop();
                                    }

                                    soundPlayer2!
                                        .setAsset('assets/audios/DM-CGS-21.wav')
                                        .then((_) => soundPlayer2!.play());
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '1-on-1 Match',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Nunito',
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
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
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: AlignmentDirectional(0, 0),
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
                          padding:
                              EdgeInsetsDirectional.fromSTEB(18, 15, 18, 15),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(0, -0.95),
                                          child: Text(
                                            'Round 3',
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
                                ),
                              ).animateOnActionTrigger(
                                animationsMap[
                                    'containerOnActionTriggerAnimation1']!,
                              ),
                              if ((isWeb
                                      ? MediaQuery.of(context)
                                              .viewInsets
                                              .bottom >
                                          0
                                      : _isKeyboardVisible) ==
                                  false)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 15, 0, 0),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'PromptHero',
                                                      textAlign: TextAlign.end,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Nunito',
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
                                                      print(
                                                          'Button pressed ...');
                                                    },
                                                    text: '1-1',
                                                    options: FFButtonOptions(
                                                      width: 75,
                                                      height: 40,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .customColor6,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .subtitle2
                                                              .override(
                                                                fontFamily:
                                                                    'Nunito',
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                              ),
                                                      elevation: 0,
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'NovaLis',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Nunito',
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
                                  ).animateOnActionTrigger(
                                      animationsMap[
                                          'containerOnActionTriggerAnimation2']!,
                                      hasBeenTriggered: hasContainerTriggered2),
                                ),
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            child: Image.asset(
                                              'assets/images/tutoImage.jpg',
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
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    LinearPercentIndicator(
                                      percent: 0.7,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      lineHeight: 24,
                                      animation: false,
                                      progressColor:
                                          FlutterFlowTheme.of(context)
                                              .customColor6,
                                      backgroundColor: Color(0xFF490E96),
                                      center: Text(
                                        '6',
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
                                  ],
                                ),
                              ).animateOnActionTrigger(
                                animationsMap[
                                    'containerOnActionTriggerAnimation3']!,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.2,
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20),
                            child: TextFormField(
                              controller: textController,
                              onChanged: (_) => EasyDebounce.debounce(
                                'textController',
                                Duration(milliseconds: 2000),
                                () async {
                                  if (animationsMap[
                                          'textFieldOnActionTriggerAnimation'] !=
                                      null) {
                                    animationsMap[
                                            'textFieldOnActionTriggerAnimation']!
                                        .controller
                                        .stop();
                                  }
                                },
                              ),
                              onFieldSubmitted: (_) async {
                                if (textController!.text != null &&
                                    textController!.text != '') {
                                  setState(() => FFAppState().tutoPhase =
                                      FFAppState().tutoPhase + 1);

                                  context.goNamed(
                                    'TutoInteractiveRoundResult',
                                    queryParams: {
                                      'playeranswer': serializeParam(
                                        textController!.text,
                                        ParamType.String,
                                      ),
                                      'playerpoint': serializeParam(
                                        functions.computePoints2(
                                            textController!.text, "."),
                                        ParamType.int,
                                      ),
                                    }.withoutNulls,
                                  );
                                }
                              },
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'Your Answer',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .customColor7,
                                    width: 5,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .customColor7,
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
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    20, 20, 20, 20),
                                suffixIcon: textController!.text.isNotEmpty
                                    ? InkWell(
                                        onTap: () async {
                                          textController?.clear();
                                          if (animationsMap[
                                                  'textFieldOnActionTriggerAnimation'] !=
                                              null) {
                                            animationsMap[
                                                    'textFieldOnActionTriggerAnimation']!
                                                .controller
                                                .stop();
                                          }
                                          setState(() {});
                                        },
                                        child: Icon(
                                          Icons.clear,
                                          color: FlutterFlowTheme.of(context)
                                              .customColor5,
                                          size: 30,
                                        ),
                                      )
                                    : null,
                              ),
                              style:
                                  FlutterFlowTheme.of(context).title2.override(
                                        fontFamily: 'Nunito',
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                              maxLines: 2,
                              minLines: 1,
                              keyboardType: TextInputType.emailAddress,
                            ).animateOnActionTrigger(
                              animationsMap[
                                  'textFieldOnActionTriggerAnimation']!,
                            ),
                          ),
                        ),
                        if ((isWeb
                                ? MediaQuery.of(context).viewInsets.bottom > 0
                                : _isKeyboardVisible) ==
                            false)
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  if (textController!.text != null &&
                                      textController!.text != '') {
                                    setState(() => FFAppState().tutoPhase =
                                        FFAppState().tutoPhase + 1);

                                    context.goNamed(
                                      'TutoInteractiveRoundResult',
                                      queryParams: {
                                        'playeranswer': serializeParam(
                                          textController!.text,
                                          ParamType.String,
                                        ),
                                        'playerpoint': serializeParam(
                                          functions.computePoints2(
                                              textController!.text, "."),
                                          ParamType.int,
                                        ),
                                      }.withoutNulls,
                                    );
                                  }
                                },
                                text: 'Guess!',
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 40,
                                  color:
                                      FlutterFlowTheme.of(context).customColor6,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .title2
                                      .override(
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
                                animationsMap[
                                    'buttonOnActionTriggerAnimation1']!,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (FFAppState().tutoPhase <= 3)
            InkWell(
              onTap: () async {
                setState(() => FFAppState().tutoPhase =
                    FFAppState().tutoPhase + 1);
                await Future.delayed(const Duration(milliseconds: 100));
                if (FFAppState().tutoPhase == 1) {
                  if (animationsMap[
                  'containerOnActionTriggerAnimation2'] !=
                      null) {
                    setState(() =>
                    hasContainerTriggered2 = true);
                    SchedulerBinding.instance
                        .addPostFrameCallback((_) async =>
                    await animationsMap[
                    'containerOnActionTriggerAnimation2']!
                        .controller
                      ..reset()
                      ..repeat(reverse: true));
                  }
                } else {
                  if (FFAppState().tutoPhase == 2) {
                    if (animationsMap[
                    'containerOnActionTriggerAnimation2'] !=
                        null) {
                      animationsMap[
                      'containerOnActionTriggerAnimation2']!
                          .controller
                          .stop();
                    }
                    if (animationsMap[
                    'containerOnActionTriggerAnimation3'] !=
                        null) {
                      await animationsMap[
                      'containerOnActionTriggerAnimation3']!
                          .controller
                        ..reset()
                        ..repeat(reverse: true);
                    }
                  } else {
                    if (FFAppState().tutoPhase == 3) {
                      if (animationsMap[
                      'containerOnActionTriggerAnimation3'] !=
                          null) {
                        animationsMap[
                        'containerOnActionTriggerAnimation3']!
                            .controller
                            .stop();
                      }
                      if (animationsMap[
                      'textFieldOnActionTriggerAnimation'] !=
                          null) {
                        await animationsMap[
                        'textFieldOnActionTriggerAnimation']!
                            .controller
                          ..reset()
                          ..repeat(reverse: true);
                      }
                    } else {
                      if (FFAppState().tutoPhase == 4) {
                        if (animationsMap[
                        'textFieldOnActionTriggerAnimation'] !=
                            null) {
                          animationsMap[
                          'textFieldOnActionTriggerAnimation']!
                              .controller
                              .stop();
                        }
                        context.goNamed(
                            'TutoInteractiveRound2');
                      }
                    }
                  }
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 1,
                          decoration: BoxDecoration(),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.05,
                                height: MediaQuery.of(context).size.height * 1,
                                decoration: BoxDecoration(
                                  color: Color(0x80000000),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      decoration: BoxDecoration(
                                        color: Color(0x80000000),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      decoration: BoxDecoration(
                                        color: FFAppState().tutoPhase == 1
                                            ? Colors.transparent
                                            : Color(0x80000000),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.45,
                                      decoration: BoxDecoration(
                                        color: Color(0x80000000),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      decoration: BoxDecoration(
                                        color: FFAppState().tutoPhase == 2
                                            ? Colors.transparent
                                            : Color(0x80000000),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.09,
                                      decoration: BoxDecoration(
                                        color: FFAppState().tutoPhase == 3
                                            ? Colors.transparent
                                            : Color(0x80000000),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        decoration: BoxDecoration(
                                          color: Color(0x80000000),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.05,
                                height: MediaQuery.of(context).size.height * 1,
                                decoration: BoxDecoration(
                                  color: Color(0x80000000),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 1,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).customColor7,
                              borderRadius: BorderRadius.circular(25),
                              shape: BoxShape.rectangle,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 10, 10, 10),
                                    child: Text(
                                      FFAppState().tutoPhase == 1
                                          ? 'This is a best of five game...'
                                          : (FFAppState().tutoPhase == 2
                                              ? 'In every round you have 15 seconds to guess the prompt...'
                                              : (FFAppState().tutoPhase == 3
                                                  ? 'Please, enter your prompt here!'
                                                  : '.')),
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800,
                                            lineHeight: 2,
                                          ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 18, 10),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      setState(() => FFAppState().tutoPhase =
                                          FFAppState().tutoPhase + 1);
                                          await Future.delayed(const Duration(milliseconds: 100));

                                      if (animationsMap[
                                              'buttonOnActionTriggerAnimation2'] !=
                                          null) {
                                        setState(
                                            () => hasButtonTriggered2 = true);
                                        SchedulerBinding.instance
                                            .addPostFrameCallback((_) async =>
                                                await animationsMap[
                                                        'buttonOnActionTriggerAnimation2']!
                                                    .controller
                                                    .forward(from: 0.0));
                                      }
                                      if (FFAppState().tutoPhase == 1) {
                                        if (animationsMap[
                                                'containerOnActionTriggerAnimation2'] !=
                                            null) {
                                          setState(() =>
                                              hasContainerTriggered2 = true);
                                          SchedulerBinding.instance
                                              .addPostFrameCallback((_) async =>
                                                  await animationsMap[
                                                          'containerOnActionTriggerAnimation2']!
                                                      .controller
                                                    ..reset()
                                                    ..repeat(reverse: true));
                                        }
                                      } else {
                                        if (FFAppState().tutoPhase == 2) {
                                          if (animationsMap[
                                                  'containerOnActionTriggerAnimation2'] !=
                                              null) {
                                            animationsMap[
                                                    'containerOnActionTriggerAnimation2']!
                                                .controller
                                                .stop();
                                          }
                                          if (animationsMap[
                                                  'containerOnActionTriggerAnimation3'] !=
                                              null) {
                                            await animationsMap[
                                                    'containerOnActionTriggerAnimation3']!
                                                .controller
                                              ..reset()
                                              ..repeat(reverse: true);
                                          }
                                        } else {
                                          if (FFAppState().tutoPhase == 3) {
                                            if (animationsMap[
                                                    'containerOnActionTriggerAnimation3'] !=
                                                null) {
                                              animationsMap[
                                                      'containerOnActionTriggerAnimation3']!
                                                  .controller
                                                  .stop();
                                            }
                                            if (animationsMap[
                                                    'textFieldOnActionTriggerAnimation'] !=
                                                null) {
                                              await animationsMap[
                                                      'textFieldOnActionTriggerAnimation']!
                                                  .controller
                                                ..reset()
                                                ..repeat(reverse: true);
                                            }
                                          } else {
                                            if (FFAppState().tutoPhase == 4) {
                                              if (animationsMap[
                                              'textFieldOnActionTriggerAnimation'] !=
                                                  null) {
                                                animationsMap[
                                                'textFieldOnActionTriggerAnimation']!
                                                    .controller
                                                    .stop();
                                              }
                                              context.goNamed(
                                                  'TutoInteractiveRound2');
                                            }
                                          }
                                        }
                                      }
                                    },
                                    text: '>> Next',
                                    options: FFButtonOptions(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          11, 11, 11, 11),
                                      color: Color(0xFF39D284),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .subtitle2
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: Colors.white,
                                            fontSize: 26,
                                            fontWeight: FontWeight.w800,
                                          ),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ).animateOnActionTrigger(
                                      animationsMap[
                                          'buttonOnActionTriggerAnimation2']!,
                                      hasBeenTriggered: hasButtonTriggered2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
