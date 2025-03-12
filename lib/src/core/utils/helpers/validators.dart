class Validators {
  static String? validatePassword(String? password) {
    if (password!.isEmpty) {
      return "Password cannot be empty";
    }

    if (password.length < 6) {
      return "Password length must be atleast 6 characters";
    }

    if (!password.contains(RegExp(r'[A-Z]'))) {
      return "Uppercase letter missing";
    }

    if (!password.contains(RegExp(r'[a-z]'))) {
      return "Lowercase letter missing";
    }

    return null;
  }

  static String? validateEmail(String? value) {
    String emailPattern = r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';
    RegExp regex = RegExp(emailPattern);
    if (value == null || value.isEmpty) {
      return "This field is mandatory";
    } else if (!regex.hasMatch(value.trim())) {
      return "Incorrect email";
    } else {
      return null;
    }
  }
}
