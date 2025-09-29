import 'package:flutter/material.dart';
import 'package:vinno_foods/features/auth/presentation/widgets/organisms/loading_screen_organism.dart';


class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return const LoadingScreenOrganism();
  }
}
