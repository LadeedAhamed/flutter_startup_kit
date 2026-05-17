import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../bloc/feature_bloc.dart';

class FeaturePage extends StatelessWidget {
  const FeaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<FeatureBloc>()..add(GetItemsEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Feature')),
        body: BlocBuilder<FeatureBloc, FeatureState>(
          builder: (context, state) {
            if (state is FeatureLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is FeatureError) {
              return Center(child: Text(state.message));
            }
            if (state is FeatureLoaded) {
              return ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(state.items[index].name),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
