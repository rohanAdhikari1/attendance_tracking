import 'package:attendance_tracking/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

class ApiRepository{
  final ApiService apiService = ApiService();

  Future<Map<String, dynamic>> _handleRequest(
      Future<Response> Function() request, {
        required bool expectStatus,
        required Map<String, dynamic> Function(Map<String, dynamic> json) onSuccess,
        String defaultError = "Something went wrong!",
      }) async {
    try {
      final response = await request();
      print(response);
      final decodedJson = response.data as Map<String, dynamic>? ?? {};
      final isValid = response.statusCode == 200 &&
          decodedJson.isNotEmpty &&
          (!expectStatus || decodedJson['status'] == true);

      if (isValid) {
        return onSuccess(decodedJson);
      } else {
        _showError(
          decodedJson['error'] ?? "Error",
          decodedJson['message'] ?? defaultError,
        );
      }
    } on DioException catch (e) {
      print(e.response);
      _showError(
        "Error",
        e.response?.data['message'] ??
            e.response?.data['error'] ??
            defaultError,
      );
    } catch (e) {
      _showError("Error", "An error occurred: ${e.toString()}");
    }

    return {
      'success': false,
      'data': null,
    };
  }

  void _showError(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  /// Check enrollment
  Future<Map<String, dynamic>> checkEnroll() async {
    return _handleRequest(
          () => apiService.dio.get('check-enroll'),
      expectStatus: false,
      onSuccess: (json) => {
        'success': true,
        'data': json,
      },
      defaultError: "Failed to check enrollment",
    );
  }

  /// Mark attendance
  Future<Map<String, dynamic>> markAttendance(dynamic jsonData) async {
    return _handleRequest(
          () => apiService.dio.post('mark_attendance', data: jsonData, options: Options(
            contentType: 'multipart/form-data',
          ),),
      expectStatus: true,
      onSuccess: (json) => {
        'success': true,
        'data': json['result'],
      },
      defaultError: "Failed to mark attendance",
    );
  }

  Future<Map<String, dynamic>> startWork(dynamic jsonData) async {
    return _handleRequest(
          () => apiService.dio.post('start_work', data: jsonData,options: Options(
            contentType: 'multipart/form-data',
          ),),
      expectStatus: true,
      onSuccess: (json) => {
        'success': true,
        'data': json['result'],
        'report_id': json['report_id'],
      },
      defaultError: "Something Went Wrong!",
    );
  }

  Future<Map<String, dynamic>> finishWork(dynamic jsonData) async {
    return _handleRequest(
          () => apiService.dio.post('finish_work', data: jsonData,options: Options(
            contentType: 'multipart/form-data',
          ),),
      expectStatus: true,
      onSuccess: (json) => {
        'success': true,
        'data': json['result'],
      },
      defaultError: "Something Went Wrong!",
    );
  }

  /// Fetch enrollment with task
  Future<Map<String, dynamic>> fetchEnrollMentWithTask() async {
    return _handleRequest(
          () => apiService.dio.get('taskwithenrollment'),
      expectStatus: true,
      onSuccess: (json) => {
        'success': true,
        'data': json['result'],
        'is_online': json['is_online'] ?? false, // only here
      },
      defaultError: "Failed to fetch enrollment with task",
    );
  }
}