import 'package:get/get.dart';

class MyLocale implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "fr": {
          "1": "Profile",
          "2": "Découvrir Produits",
          "3":"Langues",
          "4":"Anglais",
          "5": "Français",
        },
        "en": {
          "1": "Profil",
          "2": "Discover products",
              "3": "Language",
          "4": "English",
          "5": "French",
        },
      };
}
