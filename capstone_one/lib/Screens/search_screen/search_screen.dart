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
                FilledButton(
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
                          onTap: () {
                            context.push(
                              RouteKeys.addScreen,
                              // Send exact brand name to go router
                              extra: loadedMedicines.value[index].brandName,
                            );
                            //TODO: display medicine details when clicked
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
