import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdvp/utility/app_controller.dart';
import 'package:tdvp/utility/app_service.dart';

class CalculatePrice extends StatefulWidget {
  const CalculatePrice({super.key});

  @override
  State<CalculatePrice> createState() => _CalculatePriceState();
}

class _CalculatePriceState extends State<CalculatePrice> {
  @override
  void initState() {
    super.initState();
    AppService().readSizePapter();
    AppService().readFormatPapter();
    AppService().readAmountPrint();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetX(
          init: AppController(),
          builder: (AppController appController) {
            print(
                '## amountPrintModel ---> ${appController.amountPrintModels.length}');
            return ((appController.sizePaperModels.isEmpty) ||
                    (appController.formatPaperModels.isEmpty))
                ? const SizedBox()
                : ListView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 24),
                    children: [
                      displayItem(
                        head: 'ขนาดกระดาษ',
                        widget: dropdownSizePaper(appController: appController),
                      ),
                      displayItem(
                        head: 'รูปแบบกระดาษ',
                        widget:
                            dropdownFormatPaper(appController: appController),
                      ),
                      displayItem(
                        head: 'รูปแบบการพิมพ์',
                        widget: dropdownSizePaper(appController: appController),
                      ),
                      displayItem(
                        head: 'จำนวนหน้าทั้งหมด',
                        widget:
                            dropdownAmountPrint(appController: appController),
                      ),
                      displayItem(
                        head: 'วิธีการเข้าเล่ม',
                        widget: dropdownSizePaper(appController: appController),
                      ),
                      displayItem(
                        head: 'จำนวนเล่มที่ต้องการ',
                        widget: dropdownSizePaper(appController: appController),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                if (appController
                                        .chooseSizePaperModels.length ==
                                    1) {
                                  Get.snackbar(
                                      'ขนาดกระดาษ ?', 'โปรดเลือกขนาดกระดาศ');
                                } else if (appController
                                        .chooseAmountPrintModels.length ==
                                    1) {
                                  Get.snackbar('จำนวนหน้า ?',
                                      'กรุณาเลือกจำนวนหน้า ด้วยคะ');
                                } else {
                                  double factorSizePaperDou = double.parse(
                                      appController
                                          .chooseSizePaperModels.last.factor);
                                  double amountDou = double.parse(appController
                                      .chooseAmountPrintModels.last.amount
                                      .toString());
                                  double price = factorSizePaperDou * amountDou;
                                  print('## price ---> $price');
                                  appController.price.value = price;
                                }
                              },
                              child: Text('Calculate')),
                          Text(appController.price.value.toString())
                        ],
                      )
                    ],
                  );
          }),
    );
  }

  Row displayItem({
    required String head,
    required Widget widget,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(head),
        ),
        Expanded(
          flex: 3,
          child: widget,
        ),
      ],
    );
  }

  DropdownButton<Object> dropdownSizePaper(
      {required AppController appController}) {
    return DropdownButton(
      isExpanded: true,
      items: appController.sizePaperModels
          .map(
            (element) => DropdownMenuItem(
              child: Text(element.size),
              value: element,
            ),
          )
          .toList(),
      onChanged: (value) {
        appController.chooseSizePaperModels.add(value);
      },
      value: appController.chooseSizePaperModels.last,
      hint: const Text('โปรดเลือกขนาดกระดาษ'),
    );
  }

  DropdownButton<Object> dropdownFormatPaper(
      {required AppController appController}) {
    return DropdownButton(
      isExpanded: true,
      items: appController.formatPaperModels
          .map(
            (element) => DropdownMenuItem(
              child: Text(element.paper),
              value: element,
            ),
          )
          .toList(),
      onChanged: (value) {
        appController.chooseFormatPaperModels.add(value);
      },
      value: appController.chooseFormatPaperModels.last,
      hint: const Text('เลือกรูปแบบกระดาษ'),
    );
  }

  DropdownButton<Object> dropdownAmountPrint(
      {required AppController appController}) {
    return DropdownButton(
      isExpanded: true,
      items: appController.amountPrintModels
          .map(
            (element) => DropdownMenuItem(
              child: Text(element.amount.toString()),
              value: element,
            ),
          )
          .toList(),
      onChanged: (value) {
        appController.chooseAmountPrintModels.add(value);
      },
      value: appController.chooseAmountPrintModels.last,
      hint: const Text('เลือกจำนวนหน้า'),
    );
  }
}
