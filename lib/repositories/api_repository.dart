import 'package:attendance_tracking/models/task.dart';
import 'package:attendance_tracking/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApiRepository{
  final ApiService apiService = ApiService();

  Future<Map<String, dynamic>> enrollUser(jsonData) async {
    try {
      var response = await apiService.dio.post('link', data: jsonData);
      Map<String, dynamic> decodedJson = response.data;
      if (decodedJson.isNotEmpty && response.statusCode == 200 && decodedJson['status']) {
        return {
          'success': true,
          'data': decodedJson['result'],
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

  Future<List<Task>> fetchTasksByCompany(String companyUid) async {
    try {
      var response = await apiService.dio.post(
        'tasks/list',
        data: {"company_uid": companyUid},
      );
      Map<String, dynamic> decodedJson = response.data;
      if (decodedJson['success'] == true) {
        List data = decodedJson['data'];
        return data.map((json) => Task.fromJson(json)).toList();
      } else {
        throw Exception("Failed to fetch tasks");
      }
    } catch (e) {
      print('Error fetching tasks: $e');
      rethrow;
    }
  }


}