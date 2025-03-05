import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:transkriptor/core/config/routing.dart';
import 'package:transkriptor/core/extensions/theme_ex.dart';
import 'package:transkriptor/core/theme/colors.dart';
import 'package:transkriptor/features/transkriper/domain/entities/transkript_intities.dart';
import 'package:transkriptor/features/transkriper/presentation/blocs/bloc.dart';

import '../blocs/state.dart';

class Transkripts extends StatelessWidget {
  const Transkripts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Transkripts')),
      body: Container(
        color: const Color.fromARGB(255, 232, 242, 253),
        child: BlocBuilder<TranskripBloc, TranskriptState>(
          builder: (context, state) {
            if (state is Loaded<List<Transkript>>) {
              final trranskripts = state.transkript.reversed.toList();
              return ListView.builder(
                itemCount: trranskripts.length,
                itemBuilder: (_, index) => _ScriptWidget(
                  item: trranskripts[index],
                ),
              );
            } else {
              return const Center(
                child: Icon(Icons.error),
              );
            }
          },
        ),
      ),
    );
  }
}

class _ScriptWidget extends StatelessWidget {
  const _ScriptWidget({
    required this.item,
  });
  final Transkript item;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(10),
        shadowColor: Colors.grey.shade300,
        child: ListTile(
          onTap: () => _goToRead(context),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          tileColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(
              Icons.my_library_books_rounded,
              size: 25,
              color: Colors.blue,
            ),
          ),
          title: SizedBox(
            height: 18,
            child: Text(
              item.text,
              style: context.bodyMedium!,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.timeStamp,
              style: context.bodySmall!.copyWith(color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }

  void _goToRead(BuildContext context) {
    Navigator.pushNamed(context, viewTranskript, arguments: item);
  }
}
