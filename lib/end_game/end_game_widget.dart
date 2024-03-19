import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';

import 'package:gameanalytics_sdk/gameanalytics.dart';

class EndGameWidget extends StatefulWidget {
  const EndGameWidget({
    Key? key,
    this.myscore,
    this.opponentscore,
    this.opponentname,
    this.opponentlevel,
    this.userwins,
  }) : super(key: key);

  final int? myscore;
  final int? opponentscore;
  final String? opponentname;
  final int? opponentlevel;
  final bool? userwins;

  @override
  _EndGameWidgetState createState() => _EndGameWidgetState();
}

class _EndGameWidgetState extends State<EndGameWidget>
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
  AudioPlayer? soundPlayer1;
  AudioPlayer? soundPlayer2;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  AudioPlayer? soundPlayer3;

  @override
  void initState() {
    super.initState();
    int playerWins;
    if(widget.myscore!>widget.opponentscore!){
      playerWins=1;
    }else{
      playerWins=0;
    }
    var fields = new Map();
    fields["playerscore"]=widget.myscore.toString();
    fields["opponentscore"]=widget.opponentscore.toString();

    GameAnalytics.addProgressionEvent({ "progressionStatus": GAProgressionStatus.Complete,
      "progression01": "endgame",
      "progression02": (FFAppState().nextopponent+1).toString(),
      "score": playerWins,
      "customFields": jsonEncode(fields) });

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().isSoundOn == true) {
        if (widget.myscore! >= widget.opponentscore!) {
          soundPlayer1 ??= AudioPlayer();
          if (soundPlayer1!.playing) {
            await soundPlayer1!.stop();
          }

          soundPlayer1!
              .setAsset('assets/audios/success-1-6297.mp3')
              .then((_) => soundPlayer1!.play());
        } else {
          soundPlayer2 ??= AudioPlayer();
          if (soundPlayer2!.playing) {
            await soundPlayer2!.stop();
          }

          soundPlayer2!
              .setAsset('assets/audios/pixel-death-66829.mp3')
              .then((_) => soundPlayer2!.play());
        }
      }
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
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
                        child: SelectionArea(
                            child: Text(
                          'The winner!',
                          style: FlutterFlowTheme.of(context).title2.override(
                                fontFamily: 'Nunito',
                                color: Colors.white,
                                fontSize: 32,
                              ),
                        )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                    child: FFButtonWidget(
                      onPressed: () {
                        print('Button pressed ...');
                      },
                      text:
                          'lv. ${widget.userwins! ? FFAppState().userlevel.toString() : widget.opponentlevel?.toString()}',
                      options: FFButtonOptions(
                        width: 80,
                        height: 30,
                        color: FlutterFlowTheme.of(context).customColor6,
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle2.override(
                                  fontFamily: 'Nunito',
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset(
                      'assets/images/pngfind.com-default-image-png-6764065.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: Text(
                      valueOrDefault<String>(
                        widget.userwins!
                            ? FFAppState().username
                            : widget.opponentname,
                        'username',
                      ),
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Nunito',
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                    child: SelectionArea(
                        child: Text(
                      'Match Result',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Nunito',
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                    )),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, -0.4),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.15,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).customColor9,
                          borderRadius: BorderRadius.circular(10),
                          shape: BoxShape.rectangle,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 10),
                                    child: FFButtonWidget(
                                      onPressed: () {
                                        print('Button pressed ...');
                                      },
                                      text:
                                          'lv. ${FFAppState().userlevel.toString()}',
                                      options: FFButtonOptions(
                                        width: 50,
                                        height: 30,
                                        color: FlutterFlowTheme.of(context)
                                            .customColor6,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .subtitle2
                                            .override(
                                              fontFamily: 'Nunito',
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                            ),
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
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SelectionArea(
                                      child: Text(
                                    FFAppState().username,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  )),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 3, 0, 0),
                                    child: FFButtonWidget(
                                      onPressed: () {
                                        print('Button pressed ...');
                                      },
                                      text:
                                          '${widget.myscore?.toString()}-${widget.opponentscore?.toString()}',
                                      options: FFButtonOptions(
                                        width: 75,
                                        height: 40,
                                        color: FlutterFlowTheme.of(context)
                                            .customColor6,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .subtitle2
                                            .override(
                                              fontFamily: 'Nunito',
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w800,
                                            ),
                                        elevation: 0,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 10),
                                    child: FFButtonWidget(
                                      onPressed: () {
                                        print('Button pressed ...');
                                      },
                                      text:
                                          'lv. ${widget.opponentlevel?.toString()}',
                                      options: FFButtonOptions(
                                        width: 50,
                                        height: 30,
                                        color: FlutterFlowTheme.of(context)
                                            .customColor6,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .subtitle2
                                            .override(
                                              fontFamily: 'Nunito',
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                            ),
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
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SelectionArea(
                                      child: Text(
                                    widget.opponentname!,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 30),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 5),
                        child: Image.asset(
                          'assets/images/Group_323.png',
                          width: MediaQuery.of(context).size.width * 0.12,
                          height: MediaQuery.of(context).size.height * 0.03,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Expanded(
                        child: SelectionArea(
                            child: Text(
                          'You won ${functions.getExperience(widget.myscore!, widget.opponentscore!).toString()} XP!',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Nunito',
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                  ),
                        )),
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          if (animationsMap['buttonOnActionTriggerAnimation'] !=
                              null) {
                            animationsMap['buttonOnActionTriggerAnimation']!
                                .controller
                                .forward(from: 0.0);
                          }
                          if (FFAppState().isSoundOn == true) {
                            soundPlayer3 ??= AudioPlayer();
                            if (soundPlayer3!.playing) {
                              await soundPlayer3!.stop();
                            }

                            soundPlayer3!
                                .setAsset('assets/audios/DM-CGS-21.wav')
                                .then((_) => soundPlayer3!.play());
                          }
                          await Future.delayed(
                              const Duration(milliseconds: 150));

                          context.goNamed('MatchFinding');
                        },
                        text: 'Next Game',
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
