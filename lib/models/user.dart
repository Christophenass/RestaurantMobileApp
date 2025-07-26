import 'dart:convert';
// This is a model class for User, which represents a user in the application.`
class User {
  //?:means optional
  final String? name;
  final String email;
  final String? mobile;
  final String? country;
  final String password;

  User({
   this.name,
   required this.email,
   this.mobile,
   this.country,
   required this.password,
});
//byetaaba kel shi info hon w byenaamalon convertion la json bl code l tahet
  Map<String, dynamic> toMap() {
return{
'name':name,
  'email':email,
  'mobile':mobile,
  'country':country,
  'password':password,


};
  }
// Converts the User instance to a JSON string be2dar estaamlo bl post request
  String toJson() =>jsonEncode(toMap());
    










}





