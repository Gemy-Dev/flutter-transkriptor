import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor/core/config/routing.dart';
import 'package:transkriptor/core/extensions/theme_ex.dart';
import 'package:transkriptor/core/theme/colors.dart';
import 'package:transkriptor/features/transkriper/domain/entities/transkript_intities.dart';
import 'package:transkriptor/features/transkriper/presentation/blocs/bloc.dart';
import 'package:transkriptor/features/transkriper/presentation/widgets/record_widget.dart';

import '../blocs/state.dart';
import '../widgets/custom_bottom_bar.dart';
import '../widgets/custom_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            Row(
              children: [
                Text(
                  'Remaining Minutes:  ',
                  style: context.titleMedium,
                ),
                Text(
                  '5452',
                  style: context.titleMedium!.copyWith(color: Colors.blue),
                ),
                const Spacer(),
                const CircleAvatar(
                  child: Icon(Icons.person),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Expanded(
                    child: CustomCard(
                        title: 'Record',
                        description: 'and transkribe',
                        onTap: ()async{
                          await showDialog(context: context, builder:(_)=> const AlertDialog(content: MyApp(),));
                        },
                        icon: Icons.mic)),
                const SizedBox(
                  width: 20,
                ),
                Expanded(child: BlocConsumer<TranskripBloc, TranskriptState>(
                  listener: (context, state) {
                    if(state is Loading){
                      showDialog(barrierDismissible: false,
                        context: context,builder: (context) =>  const AlertDialog(
                        content: Row(
                          children: [
                            CircularProgressIndicator(), SizedBox(width: 20,),Text('Please Wait ....')
                          ],
                        ),),);
                    }
                    else if(state is Loaded<String>){
                      Navigator.pop(context);
                      Navigator.pushNamed(context, viewTranskript,arguments: Transkript(id:0, text: state.transkript, timeStamp: TimeOfDay.now().toString()));
                    }
                  },
                  builder: (context, state) {
                    return CustomCard(
                        title: 'Pick a file',
                        description: 'Audio/Video File',
                        onTap: () async => _pickFile(context),
                        icon: Icons.my_library_music_rounded);
                  },
                ))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: CustomCard(
                        title: 'Share File',
                        description: 'form Whats & Telegram',
                        onTap: () {},
                        icon: Icons.file_upload_outlined)),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: CustomCard(
                        title: 'From URL',
                        description: 'form Youtube and any links',
                        onTap: () {},
                        icon: Icons.link))
              ],
            )
          ]),
        
      

    );
  }

  void _pickFile(BuildContext context) async {
    final bloc=BlocProvider.of<TranskripBloc>(context);
    final pickedFile = await FilePicker.platform.pickFiles(type: FileType.custom,
      allowedExtensions:  ['flac', 'm4a', 'mp3', 'mp4', 'mpeg', 'mpga', 'oga', 'ogg', 'wav', 'webm'], );
    if (pickedFile?.files.first != null) {
      final path = File(pickedFile!.files.first.path!).path;
      await bloc.createTranskript(path);
    }
  }
}
