import 'dart:math' as math;
import 'package:flutter/cupertino.dart';

import 'package:coach_bot/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import '../flutter_flow/flutter_flow_theme.dart';

typedef void Callback(List<dynamic> list, int h, int w);

class PoseDetectorWidget extends StatefulWidget {
  final List<CameraDescription> cameras;
  PoseDetectorWidget(this.cameras);

  @override
  _PoseDetectorState createState() => _PoseDetectorState();
}

class _PoseDetectorState extends State<PoseDetectorWidget> {
  CameraController controller;
  String toggleText = "Start";

  bool isChanged = true;

  @override
  void initState() {
    super.initState();

    if (widget.cameras == null || widget.cameras.length < 1){
      print('No cameras found!');
    } else {
      controller = new CameraController(widget.cameras[1], ResolutionPreset.medium);
      controller.initialize().then((_){
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller.value.isInitialized) {
      return Container();
    }

    var tmp = MediaQuery.of(context).size;
    var screenH = 0.72 * math.max(tmp.height, tmp.width);
    var screenW = 0.72 * math.min(tmp.height, tmp.width);
    tmp = controller.value.previewSize;
    var previewH = 0.72 * math.max(tmp.height, tmp.width);
    var previewW = 0.72 * math.min(tmp.height, tmp.width);
    var screenRatio = screenH / screenW;
    var previewRatio = previewH / previewW;
    Size screen = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () async{
            Navigator.pop(context);
          },
          child: Icon(
            Icons.check_rounded,
            color: Colors.black,
            size: 24,
          ),
        ),
        title: Text(
          "[Exercise]",
          style: FlutterFlowTheme.of(context).bodyText1.override(
            fontFamily: "Lexend Deca",
            color: Color(0xFF14181B),
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              children:[
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: screenRatio > previewRatio ? screenH / previewH * previewW : screenW,
                    maxHeight: screenRatio > previewRatio ? screenH : screenW / previewW * previewH
                  ),
                  child: CameraPreview(controller),
                ),
              ]
            ),
            Wrap(
              spacing: 8,
              direction: Axis.horizontal,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 12, 5, 8),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.44,
                        height: 100,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x34090F13),
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Reps',
                                style: FlutterFlowTheme.of(context).subtitle1,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(12, 8, 12, 0),
                                child: Text(
                                  "0",
                                  style: FlutterFlowTheme.of(context).title1
                                )
                              )
                            ],
                          ),
                        ),
                      )
                    )
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 12, 12, 8),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.44,
                        height: 100,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x34090F13),
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Sets",
                                style: FlutterFlowTheme.of(context).subtitle1,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(12, 9, 12, 0),
                                child: FFButtonWidget(
                                  text: toggleText,
                                  onPressed: () {
                                    isChanged = !isChanged;
                                    setState(() {
                                      isChanged == true ? toggleText = "Start" : toggleText = "Stop";
                                    });
                                  },
                                  options: FFButtonOptions(
                                    height: 35,
                                    color: isChanged == true ? Colors.green : Colors.red,
                                    textStyle: FlutterFlowTheme.of(context).subtitle1.override(
                                      fontFamily: "Lexend Deca",
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    elevation: 2,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ),
                      ),
                    )
                  ]
                ),
              ],
            ),
            // Padding(
            //   padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
            //   child: FFButtonWidget(
            //     onPressed: () async{
            //       Navigator.pop(context);
            //     },
            //     text: "Finish Exercise",
            //     options: FFButtonOptions(
            //       height: 40,
            //       color: FlutterFlowTheme.of(context).primaryColor,
            //       textStyle: FlutterFlowTheme.of(context).subtitle1.override(
            //         fontFamily: 'Lexend Deca',
            //         color: Colors.white,
            //         fontSize: 20,
            //         fontWeight: FontWeight.normal,
            //       ),
            //       elevation: 2,
            //       borderSide: BorderSide(
            //         color: Colors.transparent,
            //         width: 1,
            //       ),
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}