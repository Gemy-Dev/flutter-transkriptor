
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:transkriptor/core/config/routing.dart';
import 'package:transkriptor/features/transkriper/presentation/blocs/bloc.dart';
import 'package:transkriptor/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  OpenAI.apiKey = dotenv.env['API_KEY']!;

  await di.init();
  runApp(BlocProvider(
    create: (context) => di.sl<TranskripBloc>(),
    child: const Transkriper(),
  ));
}

class Transkriper extends StatelessWidget {
  const Transkriper({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 162, 198, 246),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 162, 198, 246)),
        useMaterial3: true,
      ),
      onGenerateRoute: Routs().onGenerateRoute,
    );
  }
}
