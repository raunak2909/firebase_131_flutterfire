class UserModel {
  String? name;
  String? id;
  String? email;
  int? age;

  UserModel({this.email, this.id, this.name, this.age});


  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      name: json['name'],
      email: json['email'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "email": email,
      "name": name,
      "id": id,
    };
  }
}