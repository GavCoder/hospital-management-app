//email validation logic
String? validateEmail(String? email) {
  String? result;
  
  if (email == null || email.isEmpty) {
    result = 'Email invalid or empty';
  } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email)) {
    result = 'Please enter a valid email';
  }

  return result;
}

//password validation logic
String? validatePassword(String? password) {
  String? errorMessage;

  if (password == null || password.isEmpty) {
    errorMessage = 'Password invalid or empty. Password Must be 8 characters, and Must contain the @ symbol';
  } else if (!RegExp(r'^(?=.*[@])[A-Za-z0-9@]{8}$').hasMatch(password)) {
    errorMessage = 'Password Must be 8 characters, and Must contain the @ symbol';
  }
  
  return errorMessage;
}

//password confirmation validation logic
String? validateConfirmPassword(String? password, String? confirmPassword) {
  String? result;

  if (confirmPassword == null || confirmPassword.isEmpty) {
    result = 'Confirm password field cannot be empty';
  } else if (password != confirmPassword) {
    result = 'Passwords do not match';
  }
  return result;
}

//name validation logic
String? validateName(String? name){
  String? userName;

  if (name == null || name.isEmpty) {
    userName = 'Name cannot field be empty';
  }

  return userName;
}

//surname validation logic
String? validateSurname(String? surname){
  String? userSurname;

  if (surname == null || surname.isEmpty) {
    userSurname = 'Surname field cannot be empty';
  }
  
  return userSurname;
}

//hospital name validation logic
String? validateHospitalName(String? hopitalName){
  String? result;

  if (hopitalName == null || hopitalName.isEmpty) {
    result = 'Hospital field cannot be empty';
  }
  
  return result;
}

//review validation logic
String? validateReview(String? review){
  String? result;

  if (review == null || review.isEmpty) {
    result = 'Review field cannot be empty';
  }
  
  return result;
}

//ID number validation logic
String? validateIDNumber(String? idNum) {
  if (idNum == null || idNum.isEmpty) {
    return 'ID number is required';
  }
  if (idNum.length != 13 || !RegExp(r'^\d{13}$').hasMatch(idNum)) {
    return 'ID number must be 13 digits';
  }
  return null;
}

//phone number validation logic
String? validatePhoneNumber(String? number) {
  if (number == null || number.isEmpty) {
    return 'Phone number invalid or empty';
  }
  if (!RegExp(r'^(?:0)[1-9][0-9]{8}$').hasMatch(number)) {
    return 'Please enter a valid South African phone number';
  }
  return null;
}
