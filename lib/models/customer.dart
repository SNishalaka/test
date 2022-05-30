class Customer {
  static const tblCustomer = 'customers';
  static const colId = 'id';
  static const colFirstName = 'first_name';
  static const colLastName = 'last_name';
  static const colBodyTemp = 'body_temp';

  late  int?  id;
  late  String firstName;
  late  String lastName;
  late  String bodyTemp;

  Customer( {this.id,required this.firstName,required this.lastName,required this.bodyTemp} );

  Customer.fromMap(Map<String, dynamic> map){
    id = map["colId"];
    firstName = map["colFirstName"];
    lastName = map["colLastName"];
    bodyTemp= map["colBodyTemp"];
  }

  
  Map<String, dynamic> toMap(){
    var map = <String, dynamic> {'first_name': firstName, 'last_name': lastName, 'body_temp': bodyTemp};
    if(id != null) map[colId] = id;
    return map;
  }
}
