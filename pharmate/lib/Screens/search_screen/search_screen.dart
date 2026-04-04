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

    // We needed to save the loadingKey here
    // to fix a loading indicator issue when we navigate back
    final loadingKey = useMemoized(() => GlobalKey());
    String selectedBrandName = '';

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
              // Handled with build when for multiple success states
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
                  'brandName': selectedBrandName,
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
                    height: 240,
                    child: Form(
                      key: formKey,
                      child: Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: InputFormWidget(
                                title: 'Medicine Name',
                                hint: 'Enter Medicine name',
                                controller: searchController,
                              ),
                            ),
                            FilledButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  context.read<SearchBloc>().add(
                                    //~ #1
                                    SearchRequestEvent(
                                      searchText: searchController.text,
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                'Search',
                                style: TextStyle(fontWeight: .bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Gap(16),

                  // ---------------------------
                  // ---------------------------
                  Expanded(
                    child: BlocBuilder<SearchBloc, SearchState>(
                      //! I had to search for this
                      buildWhen: (previous, current) {
                        // rebuild the widget when the state is MedicinesFetchingSuccessfulState
                        // even if other success states are emitted.
                        return current is MedicinesFetchingSuccessfulState;
                      },
                      builder: (context, state) {
                        if (state is MedicinesFetchingSuccessfulState) {
                          return ListView.builder(
                            //~ #15
                            itemCount: state.medicines.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8),
                                child: ListTile(
                                  leading: Icon(Icons.medication),
                                  trailing: Icon(Icons.arrow_forward_ios),

                                  onTap: () {
                                    selectedBrandName =
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
                        return Center(
                          child: Icon(
                            Icons.search,
                            size: 250,
                            color: Colors.grey.withAlpha(100),
                          ),
                        );
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
