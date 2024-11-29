import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geofence_service/geofence_service.dart';
import 'package:get/get.dart';
import 'package:hr_application/app/models/team_members_model.dart';
import 'package:hr_application/app/models/teams_model.dart';
import 'package:hr_application/data/app_enums.dart';
import 'package:hr_application/data/controllers/api_conntroller.dart';
import 'package:hr_application/data/controllers/api_url_service.dart';
import 'package:hr_application/data/controllers/app_storage_service.dart';
import 'package:hr_application/utils/helper_function.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as loc;
import 'package:local_auth/local_auth.dart';


class AllEmployesPageController extends GetxController {
  late final GeofenceService _geofenceService;
  final LocalAuthentication auth = LocalAuthentication();


  void canVerifyandVerify() async {
    final bool canauthenticate = await auth.canCheckBiometrics;
    if (canauthenticate) {
      // final all_biometric = await auth.getAvailableBiometrics();

      final bool didauth = await auth.authenticate(localizedReason: "Required for person verification.",
      options: AuthenticationOptions(stickyAuth: true,biometricOnly: true));  
      if (didauth) {
        updatebuttonText();
        showSuccessSnack("User Authorized");
      }
    }
    else {
      Get.closeAllSnackbars();
      print("noauth");
    }
  }

    void _initGeofenceService() {
    _geofenceService = GeofenceService.instance.setup(
      interval: 5000,
      accuracy: 100,
      loiteringDelayMs: 60000,
      statusChangeDelayMs: 10000,
      useActivityRecognition: false,
      allowMockLocations: true,
      printDevLog: true,
      geofenceRadiusSortType: GeofenceRadiusSortType.DESC
    );
    _geofenceService.addGeofenceStatusChangeListener(_onGeofenceStatusChanged);
    _geofenceService.addLocationChangeListener(_onLocationChanged);
    _geofenceService.addLocationServicesStatusChangeListener(_onLocationServicesStatusChanged);
    _geofenceService.addStreamErrorListener(_onError);
  }  
  
  Future<void> _onGeofenceStatusChanged(
    Geofence geofence,
    GeofenceRadius geofenceRadius,
    GeofenceStatus geofenceStatus,
    Location location) async {
    // setState(() {
      if (geofenceStatus == GeofenceStatus.ENTER) {
        // _geofenceTimestamps[geofence.id]?['lastEntry'] = DateTime.now();
        Get.snackbar("Entered in Office", "Please Authorize your check-in",duration: Duration(days: 2));
        canVerifyandVerify();
        // _showToast("Entered in Geolocation");
      } else if (geofenceStatus == GeofenceStatus.EXIT) {
        // _geofenceTimestamps[geofence.id]?['lastExit'] = DateTime.now();
        Get.snackbar("Exited from Office", "Please Authorize your check-out",duration: Duration(days: 2));
        canVerifyandVerify();
        // _showToast("Entered in Geolocation");
      }
    // });
    // _geofenceStreamController.add(geofence);
  }
  
    void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      fontSize: 16.0
    );
  }

  void _onLocationChanged(Location location) {
    print('location: ${location.toJson()}');
  }

  void _onLocationServicesStatusChanged(bool status) {
    print('isLocationServicesEnabled: $status');
  }

  void _onError(error) {
    final errorCode = getErrorCodesFromError(error);
    if (errorCode == null) {
      print('Undefined error: $error');
      return;
    }
    print('ErrorCode: $errorCode');
  }

  final _geofenceList = <Geofence>[
    Geofence(
      id: 'DTU LIB',
      latitude: 28.749619,
      longitude: 77.114621,
      radius: [
        GeofenceRadius(id: 'radius_200m', length: 200),
      ],
    )
  ];

  Future<void> checkAndRequestPermission() async {
    final status = await Permission.location.status;
    if (status.isGranted) {
    await locationoncheck(status);
    print("Running GeoService");
      _geofenceService.start(_geofenceList).catchError(_onError);
    } else if (status.isDenied) {
      requestPermission();
    } else if(status.isPermanentlyDenied) {
      _showSettingsDialog();
    }
  }

  Future<void> locationoncheck(PermissionStatus status) async {
    loc.Location loca = new loc.Location();
    bool _serviceEnabled = await loca.serviceEnabled();
    if (!_serviceEnabled) {
      print(status.toString());
      print(_serviceEnabled.toString());
      _serviceEnabled = await loca.requestService();
      if (!_serviceEnabled) {
        print("Not avai");
        Get.snackbar("Location is not Enabled", "Please enable your location services");
        // _showToast("Location is Not Enabled!");
      }
    }
  }

  Future<void> requestPermission() async {
    final permission = await Permission.location.request();
    if (permission.isGranted) {
      print("Permission Granted");
      await locationoncheck(permission);
      _geofenceService.start(_geofenceList).catchError(_onError);
    } else if (permission.isDenied) {
      Get.snackbar("Permission Needed", "Needs location permission for proper working");
      // _showToast("Need this permission to work properly");
    } else if(permission.isPermanentlyDenied) {
      Get.snackbar("Location Denied", "App will not perform properly");
      // _showToast("Location Permission Denied app will not perform properly");
    }
  }

  void _showSettingsDialog() {
    Get.dialog(
      Text("This is a test")
      // AlertDialog(
      //   title: const Text('Location Permission Required'),
      //   content: const Text('Please enable location permission in settings.'),
      //   actions: [
      //     TextButton(
      //       child: const Text('Cancel'),
      //       onPressed: () => Navigator.of(Get.context).pop(),
      //     ),
      //     TextButton(
      //       child: const Text('Open Settings'),
      //       onPressed: () {
      //         openAppSettings();
      //         Navigator.of(context).pop();
      //       },
      //     ),
      //   ],
      // )
    );
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) => AlertDialog(
    //     title: const Text('Location Permission Required'),
    //     content: const Text('Please enable location permission in settings.'),
    //     actions: [
    //       TextButton(
    //         child: const Text('Cancel'),
    //         onPressed: () => Navigator.of(context).pop(),
    //       ),
    //       TextButton(
    //         child: const Text('Open Settings'),
    //         onPressed: () {
    //           openAppSettings();
    //           Navigator.of(context).pop();
    //         },
    //       ),
    //     ],
    //   ),
    // );
  }

  
  
  
  
  
  
  
  
  
  
  var teams = <TeamsModel>[];
  TeamsModel? selectedTeam;
  MemberModel? members;
  var isTeamLoading = true.obs, isMemberLoading = false.obs;

  var buttontext = "Checked Out".obs;
  var sliderText = "Slide to Check In".obs;

  var textColor = Colors.blue.shade300.obs;
  var arrowColor  = Colors.blue.obs;

  var timer = 5.obs;
  var colorAnimated =Colors.red.obs ;
  var colorWidget = WidgetStatePropertyAll(Colors.red).obs;

  updatebuttonText() {
    if (buttontext.value == "Checked In") {
      buttontext.value = "Checked Out";
      sliderText.value = "Slide to Check In";
      colorWidget.value = WidgetStatePropertyAll(Colors.red);
      colorAnimated.value = Colors.red;
      textColor.value = Colors.blue.shade300;
      arrowColor.value = Colors.blue;


    }
    else if(buttontext.value == "Checked Out"){
      buttontext.value = "Checked In";
      sliderText.value = "Slide to Check Out";
      colorWidget.value = WidgetStatePropertyAll(Colors.blue);
      colorAnimated.value = Colors.blue;
      textColor.value = Colors.red.shade300;
      arrowColor.value = Colors.red;
    }
  }

  @override
  void onInit() {
    super.onInit();
    checkAndRequestPermission();
    _initGeofenceService();

  }

  @override
  void onReady() {
    super.onReady();
    // fetchAllTeams();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchAllTeams() async {
    if (!isTeamLoading.value) {
      isTeamLoading.value = true;
    }
    await AppStorageController.to.asyncCurrentUser;
    final resp = await ApiController.to
        .callGETAPI(
      url: APIUrlsService.to.fetchTeams(
        AppStorageController.to.currentUser!.userID!,
        AppStorageController.to.currentUser!.companyID!,
        AppStorageController.to.currentUser!.roleType!.code,
      ),
    )
        .catchError((e) {
      isTeamLoading.value = true;
    });
    if (resp != null && resp is List<dynamic>) {
      teams.clear();
      teams.addAll(
        (resp).map((e) => TeamsModel.fromJson(e)).toList(),
      );
      if (teams.isNotEmpty) {
        selectedTeam = teams.first;
        fetchMembersbyTeams(selectedTeam!);
      } else {
        members = null;
        isMemberLoading.refresh();
      }
      isTeamLoading.value = false;
    } else {
      showErrorSnack((resp['errorMsg'] ?? resp).toString());
    }
  }

  void onTeamTap(TeamsModel team) {
    fetchMembersbyTeams(team).then((e) {
      selectedTeam = team;
      isTeamLoading.refresh();
    });
  }

  Future<void> fetchMembersbyTeams(TeamsModel team) async {
    if (!isMemberLoading.value) {
      isMemberLoading.value = true;
    }
    final resp = await ApiController.to
        .callGETAPI(
      url: APIUrlsService.to.fetchMembers(
        AppStorageController.to.currentUser!.userID!,
        AppStorageController.to.currentUser!.companyID!,
        team.id!,
      ),
    )
        .catchError((e) {
      isMemberLoading.value = false;
    });
    if (resp != null && resp is Map<String, dynamic>) {
      members = MemberModel.fromJson(resp);
    } else {
      showErrorSnack((resp['errorMsg'] ?? resp).toString());
    }
    isMemberLoading.value = false;
  }

  Future<void> addTeam(String teamName) async {
    if (teamName.trim().isEmpty) {
      showErrorSnack("Enter Team Name");
      return;
    }
    final resp = await ApiController.to.callPOSTAPI(
      url: APIUrlsService.to.addTeam,
      body: {
        "userID": AppStorageController.to.currentUser?.userID,
        "companyID": AppStorageController.to.currentUser?.companyID,
        "teamName": teamName,
      },
    ).catchError((e) {
      closeDialogs();
      Get.defaultDialog(
        content: Text(e.toString()),
        onConfirm: closeDialogs,
        textConfirm: "ok",
      );
    });
    closeDialogs();
    if (resp.toString().contains("Team Created")) {
      fetchAllTeams();
    } else {
      Get.defaultDialog(
        content: Text(resp.toString()),
        onConfirm: closeDialogs,
        textConfirm: "ok",
      );
    }
  }

  Future<void> addMembers(
      String fullName, String username, UserRoleType selectedRole) async {
    if (username.trim().isEmpty ||
        fullName.trim().isEmpty ||
        (selectedTeam?.id == null)) {
      showErrorSnack("Enter Full Name and username and select team");
      return;
    }
    final resp = await ApiController.to.callPOSTAPI(
      url: APIUrlsService.to.addMember,
      body: {
        "creatingUserID": AppStorageController.to.currentUser?.userID,
        "fullName": fullName,
        "teamID": selectedTeam!.id!,
        "userName": username,
        "companyID": AppStorageController.to.currentUser?.companyID,
        "roleType": selectedRole.code,
      },
    ).catchError((e) {
      closeDialogs();
      Get.defaultDialog(
        content: Text(e.toString()),
        onConfirm: closeDialogs,
        textConfirm: "ok",
      );
    });
    closeDialogs();
    if (resp.toString().contains("Member Added")) {
      fetchAllTeams();
    } else {
      Get.defaultDialog(
        content: Text(resp.toString()),
        onConfirm: closeDialogs,
        textConfirm: "ok",
      );
    }
  }
}
