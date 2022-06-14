class Validator {
  static final Validator instance = Validator();

  static String? validateEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return "Field is Required";
    }
    return null;
  }

  static String? validateEmail(String? email) {
    RegExp regExp = RegExp(
      r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      caseSensitive: false,
      multiLine: false,
    );
    if (email!.isEmpty) {
      return "Field is Required";
    } else if (!regExp.hasMatch(email)) {
      return "Invalid Email";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Field is Required";
    } else if (!(value.length > 3)) {
      return "Password should contains more then 3 character";
    }
    return null;
  }
}
