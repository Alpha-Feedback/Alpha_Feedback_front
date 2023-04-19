
import 'form_submition_state.dart';
class AuthState{
  final FormSubmissionStatus authState;
  final String userId;
  final String password;
  AuthState({

    this.authState=const IntialFormStatus(),
    this.userId='',
    this.password=''
  });
  AuthState copyWith({
    FormSubmissionStatus? authState,
     String? userId,
     String? password,


  }){
    return AuthState(
      authState:authState??const IntialFormStatus(),
      userId:userId??this.userId,
      password:password??this.password,
    );
  }
}