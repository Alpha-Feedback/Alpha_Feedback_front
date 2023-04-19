import 'dart:io';
import 'package:alpha_feedback/model/user_model.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
 import 'package:shared_preferences/shared_preferences.dart';

import 'app_url.dart';

class HttpService {
  Dio _dio = Dio();
  HttpService() {
    _dio = Dio(BaseOptions(
        receiveDataWhenStatusError: true,
        connectTimeout: 50*1000, // 20 seconds
        receiveTimeout: 30*1000 // 20 seconds

    ));
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =(X509Certificate cert, String host, int port) => true;
      return client;
    };
    initializeInterceptors();
  }
  initializeInterceptors(){
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest:(options, handler) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? token = prefs.getString("access_token");
          // if(token!.isEmpty){
          //   final NavigationService _navigationService = locator<NavigationService>();
          //   _navigationService.navigateTo(routes.AppRoute.loginRoute);
          // }
          options.headers.addAll({"Authorization": "Bearer $token"});
          print('REQUEST[${options.method}] => PATH: ${options.path}');
          return handler.next(options); //continue
        },
        onResponse:(response,handler) {
          ('RESPONSE[${response.data}] => PATH: ${response.requestOptions.path}');
          // Do something with response data
          print("RESPONSE[${response.data}] => PATH: ${response.requestOptions.path}");
          print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
          return handler.next(response); // continue
        },
        onError: (DioError e, handler) {
          ('statusCode: [${e.response?.statusCode} Error : [${e.error}] => PATH: ${e.requestOptions.path}');
          // Do something with response error
          print('ERROR Status Code : [${e.response!.statusCode}] => PATH: ${e.requestOptions.path}');
          print('ERROR[${e.response?.data}] => PATH: ${e.requestOptions.path}');
          print('ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');
          return  handler.next(e);//continue
          // If you want to resolve the request with some custom data，
          // you can resolve a `Response` object eg: `handler.resolve(response)`.
        }
    ));
  }

  Future<User> login(String userId, String password ) async {
    Response response;
    User user=User(userId: userId, password: password);
    try {
      response = await _dio.post(
          AppUrl.login,
          data: user.toJson(),
          options: Options(contentType: "application/json")
      );
      try{
        var  result=User.fromJson(response.data);
        return result;
      }catch(e){
        throw Exception( "Data Parsing Error");
      }
    } on DioError catch(e){
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        throw Exception( "Connection Request timeout");
      }  else if (e.error is SocketException) {
        throw Exception( "Network Error ,Please Check Your connection!");
      }
      else if (e.error is SocketException) {
        throw Exception( "Network Error ,Please Check Your connection!");
      }
      else if (e.error is SocketException) {
        throw Exception( "Network Error ,Please Check Your connection!");
      } else if(e.type == DioErrorType.response) {

        throw Exception("Incorrect credentials ");
      }
      else{
        throw Exception("Some Thing  Wrong Please Try again");
      }
    }
    catch (e) {
      throw Exception("Something wrong Please try again");

    }
  }
  Future<User> register(String userId, String password ) async {
    Response response;
    User user=User(userId: userId, password: password);
    try {
      response = await _dio.post(
          AppUrl.login,
          data: user.toJson(),
          options: Options(contentType: "application/json")
      );
      try{
        var  result=User.fromJson(response.data);
        return result;
      }catch(e){
        throw Exception( "Data Parsing Error");
      }
    } on DioError catch(e){
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        throw Exception( "Connection Request timeout");
      }  else if (e.error is SocketException) {
        throw Exception( "Network Error ,Please Check Your connection!");
      }
      else if (e.error is SocketException) {
        throw Exception( "Network Error ,Please Check Your connection!");
      }
      else if (e.error is SocketException) {
        throw Exception( "Network Error ,Please Check Your connection!");
      } else if(e.type == DioErrorType.response) {

          throw Exception("Something wrong");

      }
      else{
        throw Exception("Some Thing  Wrong Please Try again");
      }
    }
    catch (e) {
      throw Exception("Something wrong Please try again");
    }
  }
}