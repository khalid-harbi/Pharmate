import 'package:capstone_one/Screens/search_screen/bloc/search_bloc.dart';
import 'package:capstone_one/core/routes/route_keys.dart';
import 'package:capstone_one/widgets/input_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends HookWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    // Save the value to memory
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final loadingKey = useMemoized(() => GlobalKey());
    final selectedBrandName = useState<String>('');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search for Medicines',
          style: TextStyle(fontWeight: .w600),
        ),
        centerTitle: false,
      ),
      body: BlocListener<SearchBloc, SearchState>(
        listener: (context, state) {
          // To handle loadingIndicator
          if (loadingKey.currentContext != null &&
              // .mounted means triggered currently on the screen
              loadingKey.currentContext!.mounted) {
            // Remove from screen
            context.pop();
          }

          // Determine search state
          switch (state) {
            case SearchInitial _:
              break;
            case MedicinesLoadingState _:
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) =>
                    // Set loadingKey to this Center widget
                    Center(key: loadingKey, child: CircularProgressIndicator()),
              );
              break;
            case MedicinesFetchingSuccessfulState _:
              // Handled with build when later
              break;
            case MedicinesLoadingFailedState _:
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Failed'),
                  content: Text(state.message),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            case MedicineDetailsLoadingState _:
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) =>
                    // Set loadingKey to this Center widget
                    Center(key: loadingKey, child: CircularProgressIndicator()),
              );
              break;
            case MedicineDetailsSuccessfulState _:
              context.push(
                RouteKeys.medicineDetailsScreen,

                // Pass more than one extra as a map
                extra: {
                  'details': state.medicineDetails,
                  'brandName': selectedBrandName.value,
                },
              );
              break;
            case MedicineDetailsFailedState _:
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Failed'),
                  content: Text(state.message),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
              break;
          }
        },
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Gap(32),
                  SizedBox(
                    width: 400,
                    height: 180,
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
                  Gap(16),

                  // ---------------------------
                  // ---------------------------
                  FilledButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        context.read<SearchBloc>().add(
                          //! Send controller value #1
                          SearchRequestEvent(searchText: searchController.text),
                        );
                      }
                    },
                    child: Text('Search', style: TextStyle(fontWeight: .bold)),
                  ),
                  Gap(16),
                  Expanded(
                    child: BlocBuilder<SearchBloc, SearchState>(
                      //! I had to search for this
                      buildWhen: (previous, current) {
                        // Redraw the list if it was successfully fetched
                        return current is MedicinesFetchingSuccessfulState;
                      },
                      builder: (context, state) {
                        if (state is MedicinesFetchingSuccessfulState) {
                          return ListView.builder(
                            itemCount: state.medicines.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8),
                                child: ListTile(
                                  leading: Icon(Icons.medication),
                                  trailing: Icon(Icons.arrow_forward_ios),

                                  onTap: () async {
                                    selectedBrandName.value =
                                        state.medicines[index].brandName;
                                    context.read<SearchBloc>().add(
                                      DetailsRequestEvent(
                                        brandName:
                                            state.medicines[index].brandName,
                                      ),
                                    );
                                  },
                                  title: Text(state.medicines[index].brandName),
                                ),
                              );
                            },
                          );
                        }
                        return Center(child: null);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
