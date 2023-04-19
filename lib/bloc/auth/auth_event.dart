abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String userId;
  final String password;
  LoginEvent({required this.userId, required this.password});
}

class RegisterEvent extends AuthEvent {
  final String userId;
  final String password;
  final String confirmPassword;
  RegisterEvent({required this.userId, required this.password, required this.confirmPassword});
}
