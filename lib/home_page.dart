import 'package:flutter/material.dart';
import 'package:flutter_ai_images_app/ProviderState/provider_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tflite/flutter_tflite.dart' ;


class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final GlobalKey<ScaffoldMessengerState> scaffoldState = GlobalKey<ScaffoldMessengerState>();


  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: scaffoldState ,
      body: Column(
        children: [

          Consumer(
              builder: (context , prov, _) {
                return Container(
                  width: double.infinity ,
                  height: MediaQuery.of(context).size.height * 0.5 ,
                  color: prov.watch(image).fileImage == null ? Colors.teal : null,
                  child: prov.watch(image).fileImage == null ? const SizedBox() : Image.file(prov.watch(image).fileImage!)
                  ,
                );
              }
          ) ,


          Visibility(
              visible: ref.watch(imageAI).outputs == null ? false : true ,
              child: Text("${ref.read(imageAI).outputs?.elementAt(0)['label']}")) ,


          MaterialButton(onPressed: () async {
            return await ref.read(image).getImagePicker(
                scaffoldState: scaffoldState ,
                context: context ,
                imageSource: ImageSource.gallery
            ).then((value){
              ref.read(imageAI).classifyImage(ref.read(image).fileImage!);
            });
          } , child: const Text("GetImage"),) ,

          MaterialButton(onPressed: () {
            // print(_outputs);
            ref.read(image).deleteImagePicker();
            ref.read(imageAI).deleteOutPuts();
          } , child: const Text("Delete"),) ,

        ],
      ),
    )
    );
  }

  // Future<String?> loadModel() async {
  //   return await Tflite.loadModel(
  //     model: "assets/model_unquant.tflite",
  //     labels: "assets/labels.txt",
  //   );
  // }


}

final image = ChangeNotifierProvider((ref) => ImagePickerState());
final imageAI = ChangeNotifierProvider((ref) => LoadImageAIState());