class User {
  int? id;
  String? lastname;
  String? firstname;
  String? middlename;
  String? department;
  String? email;
  String? account_type;
  String? token;

  User({
    this.id,
    this.lastname,
    this.firstname,
    this.middlename,
    this.department,
    this.email,
    this.account_type,
    this.token
  });

  factory User.fromJson(Map<String, dynamic> json){
    return User(
        id: json['user']['id'],
        lastname: json['user']['lastname'],
        firstname: json['user']['firstname'],
        middlename: json['user']['middlename'],
        department: json['user']['department'],
        email: json['user']['email'],
        account_type: json['user']['account_type'],
        token: json['token']
    );
  }
}