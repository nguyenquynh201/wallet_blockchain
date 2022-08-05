class UserEntity {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? password;
  num? coin;

  UserEntity(
      {this.id, this.name, this.email, this.phone, this.coin, this.password});

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      coin: json["coin"],
      password: json["password"],
    );
  }

  UserEntity.fromSnapshot(snapshot)
      : id = snapshot.data()['id'],
        name = snapshot.data()['name'],
        email = snapshot.data()['email'],
        phone = snapshot.data()['phone'],
        coin = snapshot.data()['coin'],
        password = snapshot.data()['password'];

  Map<String, dynamic> toJson() {
    return {
      "id" : id,
      "name": name,
      "email": email,
      "phone": phone,
      "coin": coin,
      "password": password,
    };
  }
  Map<String, dynamic> toJsonUpdate() {
   return {
     "coin": coin,
   };
  }
}
