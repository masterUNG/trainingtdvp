import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tdvp/models/amount_print_model.dart';
import 'package:tdvp/models/format_paper_model.dart';
import 'package:tdvp/models/size_paper_model.dart';
import 'package:tdvp/utility/app_controller.dart';

class AppService {
  Future<void> readSizePapter() async {
    AppController appController = Get.put(AppController());
    await FirebaseFirestore.instance
        .collection('sizePaper')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          SizePaperModel model = SizePaperModel.fromMap(element.data());
          appController.sizePaperModels.add(model);
        }
      }
    });
  }

  Future<void> readFormatPapter() async {
    AppController appController = Get.put(AppController());
    await FirebaseFirestore.instance
        .collection('formatPaper')
        .get()
        .then((value) {
      print('## value at readRormatPaper --> ${value.docs.length}');
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          FormatPaperModel model = FormatPaperModel.fromMap(element.data());
          print('## model at readFormatPaper --> ${model.toMap()}');
          appController.formatPaperModels.add(model);
        }
        print(
            '## appController.formatPaperModels ---> ${appController.formatPaperModels.length}');
      }
    });
  }

  Future<void> readAmountPrint() async {
    AppController appController = Get.put(AppController());
    await FirebaseFirestore.instance
        .collection('amoutPrint').orderBy('amount', descending: true)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          AmountPrintModel model = AmountPrintModel.fromMap(element.data());
          appController.amountPrintModels.add(model);
        }
      }
    });
  }
}
