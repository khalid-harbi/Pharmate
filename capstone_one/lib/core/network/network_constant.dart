class NetworkConstant {
  static const String baseURL = 'https://api.fda.gov/drug/label.json';

  //! Receive controller value #4
  static String getMedicine(String medicineName) {
    // Controller value is needed in API fetching
    return '?search=openfda.brand_name:*$medicineName*&count=openfda.brand_name.exact';
  }

  static String getMedicineDetails(String medicineName) {
    return '?search=openfda.brand_name:$medicineName&limit=1';
  }
}
