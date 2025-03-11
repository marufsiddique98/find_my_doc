class UserSession {
  UserSession._();
  static var _instance = UserSession._();
  UserSession get user => _instance;
}
