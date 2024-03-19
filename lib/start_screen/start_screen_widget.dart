import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_toggle_icon.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';

class StartScreenWidget extends StatefulWidget {
  const StartScreenWidget({Key? key}) : super(key: key);

  @override
  _StartScreenWidgetState createState() => _StartScreenWidgetState();
}

class _StartScreenWidgetState extends State<StartScreenWidget>
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
  AudioPlayer? soundPlayer1;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  AudioPlayer? soundPlayer2;

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      /*
      setState(() => FFAppState().nextopponent = -1);
      setState(() => FFAppState().nextimage = 0);
       */
      soundPlayer1 ??= AudioPlayer();
      if (soundPlayer1!.playing) {
        await soundPlayer1!.stop();
      }

      soundPlayer1!
          .setAsset('assets/audios/going-to-the-next-level-114480.mp3')
          .then((_) => soundPlayer1!.play());
    });

    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
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
              color: Color(0xFFEEEEEE),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: Image.asset(
                  'assets/images/bg_w_images.png',
                ).image,
              ),
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
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
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
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 100,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/for_general_use.png',
                              width: MediaQuery.of(context).size.width * 0.5,
                              fit: BoxFit.contain,
                            ),
                            SelectionArea(
                                child: Text(
                              FFAppState().appname,
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Nunito',
                                    color: Colors.white,
                                    fontSize: 35,
                                    fontWeight: FontWeight.w800,
                                  ),
                            )),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
                            child: FFButtonWidget(
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
                                if (animationsMap[
                                        'buttonOnActionTriggerAnimation'] !=
                                    null) {
                                  await animationsMap[
                                          'buttonOnActionTriggerAnimation']!
                                      .controller
                                      .forward(from: 0.0);
                                }
                                if (FFAppState().isIntroWatched == true) {
                                  if (FFAppState().username == null ||
                                      FFAppState().username == '') {
                                    context.pushNamed('UserNamePage');
                                  } else {
                                    context.pushNamed('WelcomePage');
                                  }
                                } else {
                                  context.goNamed('TutoVideo');
                                }
                              },
                              text: 'Tap to Start!',
                              options: FFButtonOptions(
                                width: 270,
                                height: 70,
                                color:
                                    FlutterFlowTheme.of(context).customColor6,
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
                              animationsMap['buttonOnActionTriggerAnimation']!,
                            ),
                          ),
                        ),
                      ],
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
