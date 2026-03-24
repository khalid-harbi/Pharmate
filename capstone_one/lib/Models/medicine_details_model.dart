class MedicineDetailsModel {
  final String? id;
  final String? genericName;
  final String? purpose;
  final String? usage;
  final String? doNotUse;
  final String? adverseReactions;
  final String? askDoctorOrPharmacist;
  final String? stopUse;
  final String? dosage;

  MedicineDetailsModel({
    required this.id,
    this.genericName,
    this.purpose,
    this.usage,
    this.doNotUse,
    this.adverseReactions,
    this.askDoctorOrPharmacist,
    this.stopUse,
    this.dosage,
  });

  factory MedicineDetailsModel.fromJson(Map<String, dynamic> detail) {
    final openfda = detail['openfda'] as Map<String, dynamic>?;
    return MedicineDetailsModel(
      id: detail['set_id'] ?? '',
      genericName: (openfda?['generic_name'] as List?)?.first,
      purpose: (detail['purpose'] as List?)?.first,
      usage: (detail['indications_and_usage'] as List?)?.first,
      doNotUse: (detail['do_not_use'] as List?)?.first,
      adverseReactions: (detail['adverse_reactions'] as List?)?.first,
      askDoctorOrPharmacist:
          (detail['ask_doctor_or_pharmacist'] as List?)?.first,
      stopUse: (detail['stop_use'] as List?)?.first,
      dosage: (detail['dosage_and_administration'] as List?)?.first,
    );
  }

  //! I had to search for this
  // Getter to build a Map list only for available fields
  List<Map<String, String>> get availableDetails {
    final list = <Map<String, String>>[];

    // if (id != null && id!.isNotEmpty) {
    //   list.add({'title': 'ID', 'value': id!});
    // }

    if (genericName != null && genericName!.isNotEmpty) {
      list.add({'title': 'Generic Name', 'value': genericName!});
    }
    if (purpose != null && purpose!.isNotEmpty) {
      list.add({'title': 'Purpose', 'value': purpose!});
    }
    if (usage != null && usage!.isNotEmpty) {
      list.add({'title': 'Usage', 'value': usage!});
    }
    if (doNotUse != null && doNotUse!.isNotEmpty) {
      list.add({'title': 'Do Not Use', 'value': doNotUse!});
    }
    if (adverseReactions != null && adverseReactions!.isNotEmpty) {
      list.add({'title': 'Adverse Reactions', 'value': adverseReactions!});
    }
    if (askDoctorOrPharmacist != null && askDoctorOrPharmacist!.isNotEmpty) {
      list.add({'title': 'Ask Doctor', 'value': askDoctorOrPharmacist!});
    }
    if (stopUse != null && stopUse!.isNotEmpty) {
      list.add({'title': 'Stop Use', 'value': stopUse!});
    }
    if (dosage != null && dosage!.isNotEmpty) {
      list.add({'title': 'Dosage', 'value': dosage!});
    }

    return list;
  }
}
