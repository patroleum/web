import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageSingleton {
  factory LocalStorageSingleton() {
    _instance ??= LocalStorageSingleton._();
    return _instance!;
  }
  LocalStorageSingleton._();

  static LocalStorageSingleton? _instance;

  static late SharedPreferences prefs;

  static const _tokenKey = 'token';
  static const _refreshTokenKey = 'refreshToken';
  static const _tokenDSSKey = 'tokenDSS';
  static const _signatureKey = 'signature';
  static const _idUserKey = 'idUser';
  static const _firebaseTokenKey = 'firebaseToken';
  static const _timeZoneNameKey = 'timeZoneName';
  static const _timeZoneOffsetKey = 'timeZoneOffset';

  static Future<void> initPrefts() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> cleanPrefts() async {
    await prefs.clear();
  }

  static Future<void> reload() async {
    await prefs.reload();
  }

  static Future<void> saveToken(String token, String refreshToken,
      String tokenDSS, String signature, int idUser) async {
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_refreshTokenKey, refreshToken);
    await prefs.setString(_tokenDSSKey, tokenDSS);
    await prefs.setString(_signatureKey, signature);
    await prefs.setInt(_idUserKey, idUser);
  }

  // Nuevo método para guardar el token de Firebase
  static Future<void> saveFirebaseToken(String firebaseToken) async {
    await prefs.setString(_firebaseTokenKey, firebaseToken);
  }

  // Nuevo método para recuperar el token de Firebase
  static String? getFirebaseToken() => prefs.getString(_firebaseTokenKey);

  // Guardar token DSS
  static Future<void> saveTokenDSS(String tokenDSS) async {
    await prefs.setString(_tokenDSSKey, tokenDSS);
  }

  // Recuperar datos específicos
  static String? getToken() => prefs.getString(_tokenKey);
  static String? getRefreshToken() => prefs.getString(_refreshTokenKey);
  static String? getTokenDSS() => prefs.getString(_tokenDSSKey);
  static String? getSignature() => prefs.getString(_signatureKey);
  static int? getIdUser() => prefs.getInt(_idUserKey);

  // Métodos para manejar zona horaria
  static Future<void> saveTimeZone(
      String timeZoneName, int timeZoneOffset) async {
    await prefs.setString(_timeZoneNameKey, timeZoneName);
    await prefs.setInt(_timeZoneOffsetKey, timeZoneOffset);
  }

  static String? getTimeZoneName() => prefs.getString(_timeZoneNameKey);
  static int? getTimeZoneOffset() => prefs.getInt(_timeZoneOffsetKey);

}
