import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_timer.dart';
import '../flutter_flow/flutter_flow_toggle_icon.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:gameanalytics_sdk/gameanalytics.dart';

class RoundResultWidget extends StatefulWidget {
  const RoundResultWidget({
    Key? key,
    this.myscore,
    this.opponentscore,
    this.round,
    this.opponentname,
    this.opponentlevel,
    this.playeranswer,
    this.playerpoint,
    this.opponentpoint,
    this.timerduration,
  }) : super(key: key);

  final int? myscore;
  final int? opponentscore;
  final int? round;
  final String? opponentname;
  final int? opponentlevel;
  final String? playeranswer;
  final int? playerpoint;
  final int? opponentpoint;
  final int? timerduration;

  @override
  _RoundResultWidgetState createState() => _RoundResultWidgetState();
}

class _RoundResultWidgetState extends State<RoundResultWidget> {
  StopWatchTimer? timerController;
  String? timerValue;
  int? timerMilliseconds;
  TextEditingController? textController1;
  TextEditingController? textController2;
  AudioPlayer? soundPlayer1;
  AudioPlayer? soundPlayer2;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    var fields = new Map();
    if(widget.playeranswer!.isEmpty){
      fields["answer"]="empty";
    }
    else{
      fields["answer"]=widget.playeranswer;
    }
    fields["point"]=widget.playerpoint.toString();
    GameAnalytics.addProgressionEvent({ "progressionStatus": GAProgressionStatus.Complete,
      "progression01": "roundend", "progression02": widget.round.toString(),
      "customFields": jsonEncode(fields) });



    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 100));
      timerController?.onExecute.add(
        StopWatchExecute.reset,
      );

      timerController?.onExecute.add(
        StopWatchExecute.start,
      );

      if (widget.playerpoint! >= widget.opponentpoint!) {
        if (FFAppState().isSoundOn == true) {
          soundPlayer1 ??= AudioPlayer();
          if (soundPlayer1!.playing) {
            await soundPlayer1!.stop();
          }

          soundPlayer1!
              .setAsset('assets/audios/success-1-6297.mp3')
              .then((_) => soundPlayer1!.play());
        }
      } else {
        if (FFAppState().isSoundOn == true) {
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

    textController1 = TextEditingController(
        text: functions.getAnswer(
            FFAppState().opponentAnswers.toList(), FFAppState().nextimage));
    textController2 = TextEditingController(text: widget.playeranswer);
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
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
                    fontWeight: FontWeight.w900,
                  ),
              onEnded: () async {
                timerController?.onExecute.add(
                  StopWatchExecute.stop,
                );

                if (widget.playerpoint! >= widget.opponentpoint!) {
                  if (widget.myscore == FFAppState().nRoundsPerGame) {
                    context.goNamed(
                      'EndGame',
                      queryParams: {
                        'myscore': serializeParam(
                          functions.incrementbyOne(widget.myscore!),
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
                        'opponentlevel': serializeParam(
                          widget.opponentlevel,
                          ParamType.int,
                        ),
                        'userwins': serializeParam(
                          true,
                          ParamType.bool,
                        ),
                      }.withoutNulls,
                    );
                  } else {
                    context.goNamed(
                      'OnGoingMatch',
                      queryParams: {
                        'myscore': serializeParam(
                          functions.incrementbyOne(widget.myscore!),
                          ParamType.int,
                        ),
                        'opponentscore': serializeParam(
                          widget.opponentscore,
                          ParamType.int,
                        ),
                        'round': serializeParam(
                          functions.incrementbyOne(widget.round!),
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
                  }
                } else {
                  if (widget.opponentscore == FFAppState().nRoundsPerGame) {
                    context.goNamed(
                      'EndGame',
                      queryParams: {
                        'myscore': serializeParam(
                          widget.myscore,
                          ParamType.int,
                        ),
                        'opponentscore': serializeParam(
                          functions.incrementbyOne(widget.opponentscore!),
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
                        'userwins': serializeParam(
                          false,
                          ParamType.bool,
                        ),
                      }.withoutNulls,
                    );
                  } else {
                    context.goNamed(
                      'OnGoingMatch',
                      queryParams: {
                        'myscore': serializeParam(
                          widget.myscore,
                          ParamType.int,
                        ),
                        'opponentscore': serializeParam(
                          functions.incrementbyOne(widget.opponentscore!),
                          ParamType.int,
                        ),
                        'round': serializeParam(
                          functions.incrementbyOne(widget.round!),
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
                  }
                }
              },
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 50, 20, 0),
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
                  height: MediaQuery.of(context).size.height * 0.53,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).customColor9,
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0, 0.05),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(18, 15, 18, 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: AlignmentDirectional(0, -1),
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
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(0, -1),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: Image.asset(
                                    'assets/images/questions/'+FFAppState().nextimage.toString()+'.jpg',
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
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
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).customColor9,
                                  barRadius: Radius.circular(20),
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Text(
                                    functions.getAnswer(
                                        FFAppState().Answers.toList(),
                                        FFAppState().nextimage),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    style: FlutterFlowTheme.of(context)
                                        .title2
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                  ),
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
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                                child: FFButtonWidget(
                                  onPressed: () {
                                    print('Button pressed ...');
                                  },
                                  text: '${widget.opponentpoint.toString()} pt',
                                  options: FFButtonOptions(
                                    width: 50,
                                    color: Color(0xFFFFCB00),
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
                              Expanded(
                                child: TextFormField(
                                  controller: textController1,
                                  autofocus: true,
                                  readOnly: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    hintStyle:
                                        FlutterFlowTheme.of(context).bodyText2,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    filled: true,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .customColor9,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Nunito',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                      ),
                                  textAlign: TextAlign.end,
                                  maxLines: 2,
                                  minLines: 2,
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/pngfind.com-default-image-png-6764065.png',
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  Text(
                                    widget.opponentname!,
                                    style: FlutterFlowTheme.of(context)
                                        .title2
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/pngfind.com-default-image-png-6764065.png',
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  Text(
                                    FFAppState().username,
                                    style: FlutterFlowTheme.of(context)
                                        .title2
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: textController2,
                                  autofocus: true,
                                  readOnly: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    hintStyle:
                                        FlutterFlowTheme.of(context).bodyText2,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    filled: true,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .customColor9,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Nunito',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                      ),
                                  maxLines: 2,
                                  minLines: 2,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                child: FFButtonWidget(
                                  onPressed: () {
                                    print('Button pressed ...');
                                  },
                                  text: '${widget.playerpoint.toString()} pt',
                                  options: FFButtonOptions(
                                    width: 50,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryColor,
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  shape: BoxShape.rectangle,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                      child: Image.asset(
                        'assets/images/Group_323.png',
                        width: MediaQuery.of(context).size.width * 0.12,
                        height: MediaQuery.of(context).size.height * 0.03,
                        fit: BoxFit.contain,
                      ),
                    ),
                    FFButtonWidget(
                      onPressed: () {
                        print('Button pressed ...');
                      },
                      text: widget.playerpoint! >= widget.opponentpoint!
                          ? 'Hooray! You won the round ${FFAppState().username}!'
                          : 'Ops... Not this time ${FFAppState().username}',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 60,
                        color: Color(0xFFB08CDB),
                        textStyle: FlutterFlowTheme.of(context).title2.override(
                              fontFamily: 'Nunito',
                              color: Colors.white,
                              fontSize: 15,
                            ),
                        elevation: 0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
