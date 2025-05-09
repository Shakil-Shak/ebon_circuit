class SignupModel {
  String? id;
  String? appId;
  SignupModel({required this.id, required this.appId});

  Map<String, dynamic> dataToMap() {
    return {'user_id': id, 'appId': appId};
  }

  SignupModel.mapToData(Map<String, dynamic> map) {
    id = map["user_id"];
    appId = map['appId'];
  }
}
