import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_timer.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_video_player.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';

class TutoVideoWidget extends StatefulWidget {
  const TutoVideoWidget({Key? key}) : super(key: key);

  @override
  _TutoVideoWidgetState createState() => _TutoVideoWidgetState();
}

class _TutoVideoWidgetState extends State<TutoVideoWidget>
    with TickerProviderStateMixin {
  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 10.ms,
          duration: 300.ms,
          begin: 0,
          end: 1,
        ),
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 10.ms,
          duration: 300.ms,
          begin: 1,
          end: 1,
        ),
      ],
    ),
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
  AudioPlayer? soundPlayer;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      timerController?.onExecute.add(
        StopWatchExecute.reset,
      );

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
      body: Stack(
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
              presetMillisecond: timerMilliseconds ??= 500,
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
                  color: Colors.white,
                  fontSize: 0,
                ),
            onEnded: () {},
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: Color(0xFF5211A7),
              shape: BoxShape.rectangle,
            ),
            child: Align(
              alignment: AlignmentDirectional(0, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 50),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FlutterFlowVideoPlayer(
                              path: 'assets/videos/intro_video.mp4',
                              videoType: VideoType.asset,
                              autoPlay: true,
                              looping: false,
                              showControls: false,
                              allowFullScreen: false,
                              allowPlaybackSpeedMenu: false,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    if (FFAppState().isSoundOn == true) {
                                      soundPlayer ??= AudioPlayer();
                                      if (soundPlayer!.playing) {
                                        await soundPlayer!.stop();
                                      }

                                      soundPlayer!
                                          .setAsset(
                                              'assets/audios/DM-CGS-21.wav')
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
                                    if (timerMilliseconds == 0) {
                                      setState(() => FFAppState().isIntroWatched = true);
                                      context.goNamed('TutoInteractiveRound1');
                                    }
                                  },
                                  text: '${valueOrDefault<String>(
                                    timerMilliseconds == 0
                                        ? 'Skip'
                                        : valueOrDefault<String>(
                                            functions.miliseonds2SecondsStr(
                                                timerMilliseconds!),
                                            '3',
                                          ),
                                    'genel',
                                  )} >>',
                                  options: FFButtonOptions(
                                    width: 150,
                                    color: FlutterFlowTheme.of(context)
                                        .customColor6,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .title1
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: Colors.white,
                                          fontSize: 27,
                                          fontWeight: FontWeight.w800,
                                        ),
                                    elevation: 0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ).animateOnActionTrigger(
                                  animationsMap[
                                      'buttonOnActionTriggerAnimation']!,
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
          ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!),
        ],
      ),
    );
  }
}
