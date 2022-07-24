class Employee {
  Employee({
    String? name,
    String? designation,
    String? city,
    int? id,
  }) {
    _name = name;
    _designation = designation;
    _city = city;
    _id = id;
  }

  Employee.fromJson(dynamic json) {
    _name = json['Name'];
    _designation = json['Designation'];
    _city = json['City'];
    _id = json['_id'];
  }

  String? _name;
  String? _designation;
  String? _city;
  int? _id;

  String? get name => _name;

  String? get designation => _designation;

  String? get city => _city;

  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Name'] = _name;
    map['Designation'] = _designation;
    map['City'] = _city;
    map['_id'] = _id;
    return map;
  }

}
