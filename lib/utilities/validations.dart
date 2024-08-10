class Validation {
  static final instance = Validation();

  emptyField(String? value) {
    if (value?.isEmpty == true) {
      return "field is required";
    }
  }

  emailValidation(String? value) {
    const regEx = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';

    if (value?.isEmpty == true) {
      return "field is required";
    }
    if (!RegExp(regEx).hasMatch(value ?? "")) {
      return "invalid email format";
    }
  }

  passwordValidation(String? value) {
    if (value?.isEmpty == true) {
      return "field is required";
    }

    if ((value?.trim().length ?? 0) < 8) {
      return "must contain atleast 8 charecters";
    }
  }

  cnfPasswordValidation(String? value, String oldPass) {
    if (value?.isEmpty == true) {
      return "field is required";
    }

    if ((value?.trim().length ?? 0) < 8) {
      return "must contain atleast 8 charecters";
    }

    if (value != oldPass) {
      return "password doen not match";
    }
  }

  phoneNumberValidation(String? value) {
    final RegExp phoneExp = RegExp(r'^\+?[0-9]{7,10}$');
    if (value?.isEmpty == true) {
      return "field is required";
    }
    if ((value?.trim().length ?? 0) < 10) {
      return "must contain 10 digits";
    }

    if (!phoneExp.hasMatch(value ?? "")) {
      return 'please enter a valid phone number';
    }
  }
}
