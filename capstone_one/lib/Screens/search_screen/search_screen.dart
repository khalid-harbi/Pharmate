import 'package:capstone_one/Models/medicine_details_model.dart';
import 'package:capstone_one/Models/medicine_model.dart';
import 'package:capstone_one/core/network/network_method.dart';
import 'package:capstone_one/core/routes/route_keys.dart';
import 'package:capstone_one/widgets/input_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends HookWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());

    // Variable declaration with HookWidget is different
    final loadedMedicines = useState<List<MedicineModel>>([]);

    //! I had to search for this
    final isLoading = useState(false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search for Medicines',
          style: TextStyle(fontWeight: .w600),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  width: 400,
                  height: 220,
                  child: Form(
                    key: formKey,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: InputFormWidget(
                          title: 'Medicine name',
                          hint: 'Enter Medicine name',
                          controller: searchController,
                        ),
                      ),
                    ),
                  ),
                ),
                Gap(8),

                // ---------------------------
                // ---------------------------
                FilledButton(
                  //TODO: This logic should be in bloc
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading.value = true;
                      final api = NetworkMethod(
                        //! Send controller value #1
                        medicineName: searchController.text,
                      );

                      loadedMedicines.value = await api.getAllSearchResults();
                      isLoading.value = false;
                    }
                  },
                  child: Text('Search', style: TextStyle(fontWeight: .bold)),
                ),
                Gap(16),
                if (isLoading.value) // Display loading when true
                  //TODO: set max time for loading then display No results found
                  SizedBox(child: Center(child: CircularProgressIndicator()))
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: loadedMedicines.value.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Icons.medication),

                          //TODO: This logic should be in bloc
                          onTap: () async {
                            // ---------------------------
                            // ---------------------------
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                            try {
                              final api = NetworkMethod(
                                medicineName:
                                    loadedMedicines.value[index].brandName,
                              );

                              // Create the Medicine Object
                              final MedicineDetailsModel? details = await api
                                  .getMedicineDetails();

                              //! I had to search for this
                              if (context.mounted) {
                                Navigator.pop(context);
                                context.push(
                                  RouteKeys.addScreen,
                                  extra: details,
                                );
                              }
                            } catch (e) {
                              if (context.mounted) {
                                Navigator.pop(context);
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text(
                                      'Unable to load details!',
                                    ),
                                    content: const Text(
                                      'We encountered a problem fetching the medicine details. Please check your connection and try again.',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(
                                            context,
                                          ); // Close the error dialog
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          },
                          title: Text(loadedMedicines.value[index].brandName),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
