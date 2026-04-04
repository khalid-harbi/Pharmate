//@ MedicineModel for the search results

class MedicineModel {
  final String brandName;

  MedicineModel({required this.brandName});

  factory MedicineModel.fromJson(Map<String, dynamic> medicine) {
    return MedicineModel(brandName: medicine['term']);
  }
}
