import 'dart:convert';

import 'package:http/http.dart' as http;

class AddressService {

  Future<List<Map<String, dynamic>>> getAllProvinceVN() async {
    try {
      var url = Uri.https(
          'online-gateway.ghn.vn', 'shiip/public-api/master-data/province');
      var response = await http.post(
        url,
        headers: {
          'token': '7dbb1c13-7e11-11ee-96dc-de6f804954c9',
        },
      );
      print('Response status: ${response.statusCode}');
      if (response.statusCode != 200) {
        throw Exception('Failed to fetch province');
      }
      final responseBody = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final List<dynamic> provinceList = responseBody['data'];

      // Sorting by ProvinceName
      provinceList.sort((a, b) {
        final nameA = a['ProvinceName'] as String;
        final nameB = b['ProvinceName'] as String;
        return nameA.compareTo(nameB);
      });

      return provinceList.map((element) {
        final e = element as Map<String, dynamic>;
        return {
          'ProvinceName': e['ProvinceName'],
          'ProvinceID': e['ProvinceID'],
        };
      }).toList();
    } finally {}
  }

  Future<List<Map<String, dynamic>>> getDistrictOfProvinceVN(String provinceID) async {
    try {
      var url = Uri.https(
          'online-gateway.ghn.vn', 'shiip/public-api/master-data/district',
          {'province_id': '$provinceID'}
      );
      var response = await http.get(
        url,
        headers: {
          'token': '7dbb1c13-7e11-11ee-96dc-de6f804954c9',
        },
      );
      print('Response status: ${response.statusCode}');
      if (response.statusCode != 200) {
        throw Exception('Failed to fetch district');
      }
      final responseBody = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final List<dynamic> districtList = responseBody['data'];

      // Sorting by DistrictName
      districtList.sort((a, b) {
        final nameA = a['DistrictName'] as String;
        final nameB = b['DistrictName'] as String;
        return nameA.compareTo(nameB);
      });

      return districtList.map((element) {
        final e = element as Map<String, dynamic>;
        return {
          'DistrictName': e['DistrictName'],
          'DistrictID': e['DistrictID'],
        };
      }).toList();
    } finally {}
  }

  Future<List<Map<String, dynamic>>> getWardOfDistrictOfVN(String districtID) async {
    try {
      var url = Uri.https(
          'online-gateway.ghn.vn', 'shiip/public-api/master-data/ward',
          {'district_id': '$districtID'}
      );
      var response = await http.get(
        url,
        headers: {
          'token': '7dbb1c13-7e11-11ee-96dc-de6f804954c9',
        },
      );
      print('Response status: ${response.statusCode}');
      if (response.statusCode != 200) {
        throw Exception('Failed to fetch ward');
      }
      final responseBody = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final List<dynamic> wardList = responseBody['data'];

      // Sorting by WardName
      wardList.sort((a, b) {
        final nameA = a['WardName'] as String;
        final nameB = b['WardName'] as String;
        return nameA.compareTo(nameB);
      });

      return wardList.map((element) {
        final e = element as Map<String, dynamic>;
        return {
          'WardName': e['WardName'],
          'WardCode': e['WardCode'],
        };
      }).toList();
    } finally {}
  }

}