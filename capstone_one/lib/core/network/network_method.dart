import 'package:capstone_one/Models/medicine_model.dart';
import 'package:capstone_one/core/network/network_constant.dart';
import 'package:dio/dio.dart';

class NetworkMethod {
  //! Receive controller value #2
  final String medicineName;
  NetworkMethod({required this.medicineName});
  final dio = Dio(BaseOptions(baseUrl: NetworkConstant.baseURL));

  Future<List<MedicineModel>> getAllSearchResults() async {
    //! Send controller value #3
    final response = await dio.get(NetworkConstant.getMedicine(medicineName));
    List<MedicineModel> medicines = [];

    for (var medicine in response.data['results']) {
      final object = MedicineModel.fromJson(medicine);
      medicines.add(object);
    }
    return medicines;
  }
}
