import 'dart:convert';

class User {
  
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





