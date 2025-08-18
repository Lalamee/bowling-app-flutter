import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static const String _baseUrl = 'http://localhost:8080';

  static Future<bool> registerMechanic(Map<String, dynamic> form) async {
    final url = Uri.parse('$_baseUrl/api/auth/register');

    final payload = {
      "user": {
        "phone": form['phone'],
        "password": form['password'] ?? 'password123',
        "roleId": 1,
        "accountTypeId": 1
      },
      "mechanicProfile": {
        "fullName": form['fio'],
        "birthDate": form['birth'],
        "totalExperienceYears": int.parse(form['workYears']),
        "bowlingExperienceYears": int.parse(form['bowlingYears']),
        "isEntrepreneur": form['status'] == 'ИП',
        "educationLevelId": int.parse(form['educationLevelId']),
        "educationalInstitution": form['educationName'],
        "specializationId": int.parse(form['specializationId'] ?? '1'),
        "skills": form['skills'],
        "advantages": form['advantages'],
        "workPlaces": form['workPlaces'],
        "workPeriods": form['workPeriods']
      }
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );

    return response.statusCode == 201;
  }

  static Future<bool> registerOwner(Map<String, dynamic> form) async {
    final url = Uri.parse('$_baseUrl/api/auth/register');

    final payload = {
      "user": {
        "phone": form['phone'],
        "password": form['password'] ?? 'password123',
        "roleId": 3,
        "accountTypeId": 2
      },
      "ownerProfile": {
        "inn": form['inn'],
        "legalName": form['legalName'],
        "contactPerson": form['contactPerson'],
        "contactPhone": form['contactPhone'],
        "contactEmail": form['contactEmail']
      }
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );

    return response.statusCode == 201;
  }
}