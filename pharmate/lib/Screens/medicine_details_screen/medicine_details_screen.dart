import 'package:capstone_one/Models/medicine_details_model.dart';
import 'package:capstone_one/core/routes/route_keys.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class MedicineDetailsScreen extends StatelessWidget {
  // This is a single object
  final MedicineDetailsModel medicineDetails;
  final String brandName;

  const MedicineDetailsScreen({
    super.key,
    required this.medicineDetails,
    required this.brandName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicine Details', style: TextStyle(fontWeight: .w600)),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Gap(32),
              Expanded(
                child: ListView.builder(
                  // Extra + 2 fields for Brand name and Add button
                  itemCount: medicineDetails.availableDetails.length + 2,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 32,
                          right: 32,
                          top: 8,
                          bottom: 8,
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.info_outline,
                            color: Colors.white70,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(12),
                          ),
                          tileColor: Color(0xFF34495E),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              'Brand Name',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: .bold,
                              ),
                            ),
                          ),
                          contentPadding: EdgeInsets.all(32),
                          horizontalTitleGap: 16,
                          subtitle: Text(
                            brandName,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: .w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    }
                    // Check if we are at the end of the list
                    if (index == medicineDetails.availableDetails.length + 1) {
                      return Padding(
                        padding: const EdgeInsets.all(24),
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            minimumSize: Size(400, 50),
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(12),
                            ),
                          ),
                          onPressed: () {
                            context.push(RouteKeys.addScreen, extra: brandName);
                          },
                          child: Text(
                            'Select Medicine',
                            style: TextStyle(fontSize: 16, fontWeight: .bold),
                          ),
                        ),
                      );
                    }

                    // in normal cases, we use medicineDetails.availableDetails[index]
                    // but since we have additional +1 button we subtract it
                    final item = medicineDetails.availableDetails[index - 1];
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 32,
                        right: 32,
                        top: 8,
                        bottom: 8,
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.info_outline,
                          color: Colors.white70,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(12),
                        ),
                        tileColor: item['title']! == 'Generic Name'
                            ? Color.fromARGB(255, 52, 152, 219)
                            : item['title']! == 'Purpose'
                            ? Color.fromARGB(255, 26, 188, 156)
                            : item['title']! == 'Usage'
                            ? Color.fromARGB(255, 46, 204, 113)
                            : item['title']! == 'Do Not Use'
                            ? Color.fromARGB(255, 231, 76, 60)
                            : item['title']! == 'Stop Use'
                            ? Color.fromARGB(255, 192, 57, 43)
                            : item['title']! == 'Dosage'
                            ? Color.fromARGB(255, 241, 196, 15)
                            : item['title']! == 'Adverse Reactions'
                            ? Color.fromARGB(255, 243, 156, 18)
                            : item['title']! == 'Ask Doctor'
                            ? Color.fromARGB(255, 155, 89, 182)
                            : Colors.transparent,
                        title: Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            item['title']!,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: .bold,
                            ),
                          ),
                        ),
                        contentPadding: EdgeInsets.all(32),
                        horizontalTitleGap: 16,
                        subtitle: Text(
                          item['value']!,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: .w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
