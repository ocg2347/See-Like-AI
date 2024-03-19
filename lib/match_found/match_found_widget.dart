import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_timer.dart';
import '../flutter_flow/flutter_flow_toggle_icon.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';

import 'package:gameanalytics_sdk/gameanalytics.dart';


class MatchFoundWidget extends StatefulWidget {
  const MatchFoundWidget({
    Key? key,
    this.opponentname,
    this.opponentlevel,
    this.buttonactive,
  }) : super(key: key);

  final String? opponentname;
  final int? opponentlevel;
  final bool? buttonactive;

  @override
  _MatchFoundWidgetState createState() => _MatchFoundWidgetState();
}

class _MatchFoundWidgetState extends State<MatchFoundWidget>
    with TickerProviderStateMixin {
  final animationsMap = {
    'buttonOnActionTriggerAnimation': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: true,
      effects: [
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 100.ms,
          duration: 150.ms,
          begin: 1,
          end: 0.95,
        ),
      ],
    ),
  };
  StopWatchTimer? timerController;
  String? timerValue;
  int? timerMilliseconds;
  AudioPlayer? soundPlayer;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    GameAnalytics.addProgressionEvent({ "progressionStatus": GAProgressionStatus.Start,
      "progression01": "matchfound","progression02":FFAppState().nextopponent.toString()});

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() => FFAppState().isReadyActive = false);
      timerController?.onExecute.add(
        StopWatchExecute.start,
      );
    });

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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 50, 20, 100),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ToggleIcon(
                    onPressed: () async {
                      setState(() =>
                          FFAppState().isSoundOn = !FFAppState().isSoundOn);
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
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Text(
                      '1-on-1 Match',
                      style: FlutterFlowTheme.of(context).title1.override(
                            fontFamily: 'Nunito',
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                  SelectionArea(
                      child: Text(
                    'Best of 5',
                    style: FlutterFlowTheme.of(context).title2.override(
                          fontFamily: 'Nunito',
                          color: Colors.white,
                        ),
                  )),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                            child: FFButtonWidget(
                              onPressed: () {
                                print('Button pressed ...');
                              },
                              text: 'lv. ${FFAppState().userlevel.toString()}',
                              options: FFButtonOptions(
                                width: 80,
                                height: 30,
                                color:
                                    FlutterFlowTheme.of(context).customColor6,
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Nunito',
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                elevation: 0,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(45),
                            child: Image.asset(
                              'assets/images/pngfind.com-default-image-png-6764065.png',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SelectionArea(
                              child: Text(
                            FFAppState().username,
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Nunito',
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                          )),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                        child: SelectionArea(
                            child: Text(
                          'vs.',
                          style: FlutterFlowTheme.of(context).title2.override(
                                fontFamily: 'Nunito',
                                color: Colors.white,
                              ),
                        )),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                            child: FFButtonWidget(
                              onPressed: () {
                                print('Button pressed ...');
                              },
                              text: 'lv. ${widget.opponentlevel.toString()}',
                              options: FFButtonOptions(
                                width: 80,
                                height: 30,
                                color:
                                    FlutterFlowTheme.of(context).customColor6,
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Nunito',
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                elevation: 0,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(45),
                            child: Image.asset(
                              'assets/images/pngfind.com-default-image-png-6764065.png',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SelectionArea(
                              child: Text(
                            valueOrDefault<String>(
                              widget.opponentname,
                              'None',
                            ),
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Nunito',
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                          )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlutterFlowTimer(
                    timerValue: timerValue ??= StopWatchTimer.getDisplayTime(
                      timerMilliseconds ??= 5000,
                      hours: false,
                      minute: false,
                      second: true,
                      milliSecond: false,
                    ),
                    timer: timerController ??= StopWatchTimer(
                      mode: StopWatchMode.countDown,
                      presetMillisecond: timerMilliseconds ??= 5000,
                      onChange: (value) {
                        setState(() {
                          timerMilliseconds = value;
                          timerValue = StopWatchTimer.getDisplayTime(
                            value,
                            hours: false,
                            minute: false,
                            second: true,
                            milliSecond: false,
                          );
                        });
                      },
                    ),
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Nunito',
                          color: FlutterFlowTheme.of(context).primaryColor,
                          fontSize: 0,
                        ),
                    onEnded: () async {
                      timerController?.onExecute.add(
                        StopWatchExecute.stop,
                      );

                      context.goNamed(
                        'OnGoingMatch',
                        queryParams: {
                          'myscore': serializeParam(
                            0,
                            ParamType.int,
                          ),
                          'opponentscore': serializeParam(
                            0,
                            ParamType.int,
                          ),
                          'round': serializeParam(
                            1,
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
                          'timerduration': serializeParam(
                            FFAppState().roundlength,
                            ParamType.int,
                          ),
                        }.withoutNulls,
                      );
                    },
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-0.1, 0),
                            child: FFButtonWidget(
                              onPressed: () {
                                print('Button pressed ...');
                              },
                              text: functions
                                  .miliseonds2SecondsStr(timerMilliseconds!),
                              options: FFButtonOptions(
                                width: 70,
                                height: 70,
                                color:
                                    FlutterFlowTheme.of(context).secondaryColor,
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Nunito',
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w800,
                                    ),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(45),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: SelectionArea(
                                child: Text(
                              'The game is about to start, get ready!',
                              style:
                                  FlutterFlowTheme.of(context).title2.override(
                                        fontFamily: 'Nunito',
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 15, 20, 30),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: FFButtonWidget(
                            onPressed: () async {
                              setState(() => FFAppState().isReadyActive = true);
                              timerController?.onExecute.add(
                                StopWatchExecute.stop,
                              );

                              if (FFAppState().isSoundOn == true) {
                                soundPlayer ??= AudioPlayer();
                                if (soundPlayer!.playing) {
                                  await soundPlayer!.stop();
                                }

                                soundPlayer!
                                    .setAsset('assets/audios/DM-CGS-21.wav')
                                    .then((_) => soundPlayer!.play());
                              }
                              if (animationsMap[
                                      'buttonOnActionTriggerAnimation'] !=
                                  null) {
                                await animationsMap[
                                        'buttonOnActionTriggerAnimation']!
                                    .controller
                                    .forward(from: 0.0);
                              }
                              await Future.delayed(
                                  const Duration(milliseconds: 150));

                              context.goNamed(
                                'OnGoingMatch',
                                queryParams: {
                                  'myscore': serializeParam(
                                    0,
                                    ParamType.int,
                                  ),
                                  'opponentscore': serializeParam(
                                    0,
                                    ParamType.int,
                                  ),
                                  'opponentname': serializeParam(
                                    functions.getOpponentName(
                                        FFAppState().nextopponent,
                                        FFAppState().OpponentNames.toList()),
                                    ParamType.String,
                                  ),
                                  'opponentlevel': serializeParam(
                                    functions.getOpponentLevel(
                                        FFAppState().OpponentLevels.toList(),
                                        FFAppState().nextopponent),
                                    ParamType.int,
                                  ),
                                  'round': serializeParam(
                                    1,
                                    ParamType.int,
                                  ),
                                  'timerduration': serializeParam(
                                    FFAppState().roundlength,
                                    ParamType.int,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            text: 'Ready!',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 60,
                              color: FFAppState().isReadyActive == true
                                  ? FlutterFlowTheme.of(context).customColor5
                                  : FlutterFlowTheme.of(context).customColor6,
                              textStyle:
                                  FlutterFlowTheme.of(context).title1.override(
                                        fontFamily: 'Nunito',
                                        color: Color(0xFF683D9E),
                                        fontSize: 27,
                                      ),
                              elevation: 0,
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
          ],
        ),
      ),
    );
  }
}
