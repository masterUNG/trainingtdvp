import 'package:get/get.dart';
import 'package:tdvp/models/amount_print_model.dart';
import 'package:tdvp/models/format_paper_model.dart';
import 'package:tdvp/models/size_paper_model.dart';

class AppController extends GetxController {
  RxList sizePaperModels = <SizePaperModel>[].obs;
  RxList chooseSizePaperModels = <SizePaperModel?>[null].obs;

  RxList formatPaperModels = <FormatPaperModel>[].obs;
  RxList chooseFormatPaperModels = <FormatPaperModel?>[null].obs;

  RxList amountPrintModels = <AmountPrintModel>[].obs;
  RxList chooseAmountPrintModels = <AmountPrintModel?>[null].obs;

  RxDouble price = 0.0.obs;
}
