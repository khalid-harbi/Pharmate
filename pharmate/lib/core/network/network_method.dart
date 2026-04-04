import 'package:capstone_one/Models/medicine_details_model.dart';
import 'package:capstone_one/Models/medicine_model.dart';
import 'package:capstone_one/core/network/network_constant.dart';
import 'package:dio/dio.dart';

class NetworkMethod {
  //~ #8
  final String medicineName;
  NetworkMethod({required this.medicineName});

  final dio = Dio(BaseOptions(baseUrl: NetworkConstant.baseURL));

  // ----------------------------
  // ----------------------------
  //~ #10
  Future<List<MedicineModel>> getAllSearchResults() async {
    //! Send controller value #3
    try {
      final response = await dio.get(NetworkConstant.getMedicine(medicineName));

      // List of resulted medicines from the search
      List<MedicineModel> medicines = [];

      for (var medicine in response.data['results']) {
        final object = MedicineModel.fromJson(medicine);
        medicines.add(object);
      }
      //~ #11
      return medicines;
    } catch (e) {
      return [];
    }
  }

  // ----------------------------
  // ----------------------------

  Future<MedicineDetailsModel?> getMedicineDetails() async {
    try {
      final response = await dio.get(
        NetworkConstant.getMedicineDetails(medicineName),
      );

      final results = response.data['results'];

      return MedicineDetailsModel.fromJson(results[0]);
    } catch (e) {
      return null;
    }
  }
}
