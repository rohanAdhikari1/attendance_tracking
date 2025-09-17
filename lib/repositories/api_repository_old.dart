import 'package:attendance_tracking/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApiRepository{
  final ApiService apiService = ApiService();

  Future<Map<String, dynamic>> checkEnroll() async{
    try{
      var response = await apiService.dio.get('check-enroll');
      Map<String, dynamic> decodedJson = response.data;
      if (decodedJson.isNotEmpty && response.statusCode == 200) {
        return {
          'success': true,
          'data': decodedJson,
        };
      } else {
        Get.snackbar(
          "Error",
          "Something Went Wrong!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return {
          'success': false,
          'data': decodedJson,
        };
      }
    }on DioException catch (e) {
      Get.snackbar(
        "Error",
        e.response?.data['message']  ?? e.response?.data['error']?? 'An error occurred. Please try again later.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "An error occurred: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    return {
      'success': false,
      'data': null,
    };
  }

  Future<Map<String, dynamic>> markAttendance(jsonData) async {
    try {
      var response = await apiService.dio.post('mark_attendance', data: jsonData);
      Map<String, dynamic> decodedJson = response.data;
      if (decodedJson.isNotEmpty && response.statusCode == 200 && decodedJson['status']) {
        return {
          'success': true,
          'data': decodedJson['result'],
        };
      } else {
        Get.snackbar(
          decodedJson['error'],
          decodedJson['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return {
          'success': false,
          'data': null,
        };
      }
    } on DioException catch (e) {
      Get.snackbar(
        "Error",
        e.response?.data['message']  ?? e.response?.data['error']?? 'An error occurred. Please try again later.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "An error occurred: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    return {
      'success': false,
      'data': null,
    };
  }

  Future<Map<String, dynamic>> fetchEnrollMentWithTask() async {
    try {
      var response = await apiService.dio.get(
        'taskwithenrollment',
      );
      Map<String, dynamic> decodedJson = response.data;
      if (decodedJson.isNotEmpty && response.statusCode == 200 && decodedJson['status']) {
        return {
          'success': true,
          'data': decodedJson['result'],
          'is_online' : decodedJson['is_online'] ?? false,
        };
      } else {
        Get.snackbar(
          "Error",
          "Something Went Wrong!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return {
          'success': false,
          'data': decodedJson,
          'is_online' : decodedJson['is_online'] ?? false,
        };
      }
    } on DioException catch (e) {
      Get.snackbar(
        "Error",
        e.response?.data['message']  ?? e.response?.data['error']?? 'An error occurred. Please try again later.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "An error occurred: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    return {
      'success': false,
      'data': null,
      'is_online':false
    };
  }
}