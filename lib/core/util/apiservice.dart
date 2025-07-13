// lib/core/util/apiservice.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  final Dio _dio;
  String? _token;

  ApiService()
      : _dio = Dio(
          BaseOptions(
            baseUrl:
                'http://127.0.0.1:8000/api/', // Replace with your API base URL
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        ) {
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(responseBody: true, requestBody: true),
      );
    }
  }

  void setToken(String token) {
    _token = '7|HG0tQM7cBopgRrBrn4SNiDRjWKZIRk4G0XJlophAffcc7fab';
    _updateAuthorizationHeader();
  }

  void clearToken() {
    _token = null;
    _dio.options.headers.remove('Authorization');
  }

  void _updateAuthorizationHeader() {
    if (_token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $_token';
    }
  }

  String handleError(DioException error) {
    if (error.response != null) {
      if (error.response!.data is Map &&
          error.response!.data.containsKey('message')) {
        return error.response!.data['message'].toString();
      }
      return error.response?.data.toString() ?? 'حدث خطأ ما في الخادم';
    } else {
      return error.message ?? 'حدث خطأ في الاتصال بالإنترنت';
    }
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Authorization':
                'Bearer 1|KqxW7JNtg4jr4WV4FoNgAr8U1Oj4VbvNd63dw8bA0732452a',
          },
        ),
      );
    } on DioException catch (e) {
      // *** التعديل هنا: رمي Exception وليس String مباشر ***
      throw Exception(handleError(e));
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Authorization':
                'Bearer 1|KqxW7JNtg4jr4WV4FoNgAr8U1Oj4VbvNd63dw8bA0732452a',
          },
        ),
      );
    } on DioException catch (e) {
      // *** التعديل هنا: رمي Exception وليس String مباشر ***
      throw Exception(handleError(e));
    }
  }

  Future<Response> update(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      // *** التعديل هنا: رمي Exception وليس String مباشر ***
      throw Exception(handleError(e));
    }
  }
}
