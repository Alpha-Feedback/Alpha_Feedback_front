import 'dart:async';
import 'package:alpha_feedback/network/http_request.dart';
import 'package:bloc/bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'form_submition_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>
{
  // final AuthCubit authCubit;
  final HttpService _auth = HttpService();
  AuthBloc() : super(AuthState()) {
    on<LoginEvent>(_onLoginEvent);
    on<RegisterEvent>(_onRegisterEvent);
  }
  void _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {

    emit(state.copyWith(authState:FormSubmitting()));
    try{
      emit(state.copyWith(authState:SubmissionSuccess()));
return;
      await _auth.login(event.userId,  event.password);
      emit(state.copyWith(authState:SubmissionSuccess()));
    } on Exception catch(e){
      emit(state.copyWith(authState:SubmissionFailed(e)));
    }

  }
  void _onRegisterEvent(AuthEvent event, Emitter<AuthState> emit) async {

    emit(state.copyWith(authState:FormSubmitting()));
    try{
      await _auth.register(state.userId,  state.password);
      emit(state.copyWith(authState:SubmissionSuccess()));
    } on Exception catch(e){
      emit(state.copyWith(authState:SubmissionFailed(e)));
    }

  }

}