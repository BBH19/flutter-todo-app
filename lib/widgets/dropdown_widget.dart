import 'package:chequeproject/utils/widgect_helper.dart';
import 'package:chequeproject/widgets/config.dart';
import 'package:flutter/material.dart';

List<String> paymentStatusList = <String>['En cours', 'Payé ', 'Non Payé'];
List<String> bankList = <String>[
  'Choisir Banque',
  'ARAB BANK MAROC',
  'ATTIJARIWAFA BANK',
  'AL BARID BANK',
  'BANQUE POPULAIRE',
  'BANK OF AFRICA',
  'BMCI',
  'CREDIT AGRICOLE',
  'CIH',
  'CREDIT DU MAROC',
  'SOCIETE GENERALE',
  'CFG BANK',
  'BANK ASSAFA',
  'AL AKHDAR BANK',
  'UMNIA BANK',
  'BANK AL YOUSR'
];

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = paymentStatusList.first;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: FormField<String>(builder: (FormFieldState<String> state) {
        return InputDecorator(
            decoration: WidgetHelper.getDecoration('Paiement'),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isDense: true,
                value: dropdownValue,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  size: 20,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: paymentStatusList
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        style: TextStyle(color: GlobalParams.GlobalColor)),
                  );
                }).toList(),
              ),
            ));
      }),
    );
  }
}
