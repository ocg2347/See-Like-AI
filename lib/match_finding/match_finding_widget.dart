import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:gameanalytics_sdk/gameanalytics.dart';


class MatchFindingWidget extends StatefulWidget {
  const MatchFindingWidget({Key? key}) : super(key: key);

  @override
  _MatchFindingWidgetState createState() => _MatchFindingWidgetState();
}

class _MatchFindingWidgetState extends State<MatchFindingWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() => FFAppState().nextopponent = (FFAppState().nextopponent + 1)%FFAppState().OpponentNames.length );
      await Future.delayed(const Duration(milliseconds: 6000));
      context.goNamed(
        'MatchFound',
        queryParams: {
          'opponentname': serializeParam(
            valueOrDefault<String>(
              functions.getOpponentName(FFAppState().nextopponent,
                  FFAppState().OpponentNames.toList()),
              '0',
            ),
            ParamType.String,
          ),
          'opponentlevel': serializeParam(
            valueOrDefault<int>(
              functions.getOpponentLevel(FFAppState().OpponentLevels.toList(),
                  FFAppState().nextopponent),
              1,
            ),
            ParamType.int,
          ),
        }.withoutNulls,
      );
    });
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
              'assets/images/bg_w_images.png',
            ).image,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0, -0.25),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                        child: Lottie.asset(
                          'assets/lottie_animations/33744-loading-dots-white.json',
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 30,
                          fit: BoxFit.cover,
                          animate: true,
                        ),
                      ),
                    ),
                    Text(
                      'Finding possible matches...',
                      style: FlutterFlowTheme.of(context).title2.override(
                            fontFamily: 'Nunito',
                            color: Colors.white,
                          ),
                    ),
                    Text(
                      'It usually takes around 5 seconds.',
                      style: FlutterFlowTheme.of(context).title2.override(
                            fontFamily: 'Nunito',
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
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
