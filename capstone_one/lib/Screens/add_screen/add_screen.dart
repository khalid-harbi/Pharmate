import 'package:capstone_one/Models/medicine_details_model.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatelessWidget {
  // This is a single object
  final MedicineDetailsModel medicineDetails;
  const AddScreen({super.key, required this.medicineDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsetsGeometry.only(right: 8, bottom: 16),
        child: FloatingActionButton.large(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: medicineDetails.availableDetails.length,
                  itemBuilder: (context, index) {
                    final item = medicineDetails.availableDetails[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 24,
                        right: 24,
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
                          padding: EdgeInsets.only(bottom: 4),
                          child: Text(
                            item['title']!,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: .bold,
                            ),
                          ),
                        ),
                        contentPadding: EdgeInsets.all(24),
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
