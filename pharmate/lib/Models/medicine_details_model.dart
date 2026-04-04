//@ MedicineDetailsModel for the medicine details

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

      // results[0][openfda][generic_name]
      genericName: (openfda?['generic_name'] as List?)?.first,

      // as List.first because values are stored in a list
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
    // UI will display details using list
    final List<Map<String, String>> details = [];

    if (genericName != null && genericName!.isNotEmpty) {
      details.add({'title': 'Generic Name', 'value': genericName!});
    }
    if (purpose != null && purpose!.isNotEmpty) {
      details.add({'title': 'Purpose', 'value': purpose!});
    }
    if (usage != null && usage!.isNotEmpty) {
      details.add({'title': 'Usage', 'value': usage!});
    }
    if (doNotUse != null && doNotUse!.isNotEmpty) {
      details.add({'title': 'Do Not Use', 'value': doNotUse!});
    }
    if (adverseReactions != null && adverseReactions!.isNotEmpty) {
      details.add({'title': 'Adverse Reactions', 'value': adverseReactions!});
    }
    if (askDoctorOrPharmacist != null && askDoctorOrPharmacist!.isNotEmpty) {
      details.add({'title': 'Ask Doctor', 'value': askDoctorOrPharmacist!});
    }
    if (stopUse != null && stopUse!.isNotEmpty) {
      details.add({'title': 'Stop Use', 'value': stopUse!});
    }
    if (dosage != null && dosage!.isNotEmpty) {
      details.add({'title': 'Dosage', 'value': dosage!});
    }

    return details;
  }
}
