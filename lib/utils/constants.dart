class Constants {
  static Constants? _instance;
  // Avoid self isntance
  Constants._();
  static Constants get instance{
    _instance??=  Constants._();
    return _instance!;
   }

   static String AUTHENTICATOR_URL(String urlFragment) => '${const String.fromEnvironment('AUTHENTICATION_URL')}$urlFragment?key=${const String.fromEnvironment('APIKEY')}';
   static const String PRODUCT_BASE_URL = '${const String.fromEnvironment('SERVER_URL')}products';
   static const String USER_FAVORITES_URL = '${const String.fromEnvironment('SERVER_URL')}userFavorites';
   static const String ORDER_BASE_URL = '${const String.fromEnvironment('SERVER_URL')}orders';
  
}