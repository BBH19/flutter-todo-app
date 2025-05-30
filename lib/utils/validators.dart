class validators {
  static String? validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez remplir le champs';
    } else {
      String pattern = r'[0-9]{5,16}';
      RegExp regex = RegExp(pattern);
      if (!regex.hasMatch(value)) {
        return 'Entrer Un Nombre Valide';
      }
    }
    return null;
  }

  static String? validateField(String? value) {
    if (value == null || value.isEmpty) {
      return '*';
    }
    return null;
  }

  static double? checkDouble(dynamic value) {
    if(value is double) return value;
    if(value is int) return value.toDouble();
    if(value is String) return double.tryParse(value);
    return null;
  }
}
