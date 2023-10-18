import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTripPage extends StatefulWidget {
  const AddTripPage({super.key});

  @override
  State<AddTripPage> createState() => _AddTripPageState();
}

class _AddTripPageState extends State<AddTripPage> {
  final GlobalKey<FormState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        //  backgroundColor: AppColors.whiteGrey,
        elevation: 0,
        centerTitle: false,
        title: Text('Add new trip'),
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _key,
        // autovalidateMode: autovalidateMode,
        child: SizedBox(
          height: height,
          child: Stack(
            children: [
              SizedBox(
                  height: height*0.7,
                  child:Align(
                    alignment: Alignment.bottomCenter,
                    child: sectionOne()))
                      ,
              Padding(
                padding:  EdgeInsets.only(top : height*0.05),
                child: tripFormField(label: 'label'),
              ),
              Positioned(
                left: height*0.01,
                right: height*0.01,
                top:height *0.12,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    // borderRadius: BorderRadius.circular(10),
                  ),
                  constraints:
                      const BoxConstraints(maxHeight: 160, minHeight: 40),
                      width: height*0.4,
                  // height: 160,
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // setState(() {
                          //   _phoneFocusNode.unfocus();
                          //   _phoneNumberController.text = state
                          //           .searchResponse[index].phoneNumber
                          //           ?.substring(4) ??
                          //       '';
                          // });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey[50] ?? Colors.grey)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(('state.searchResponse[inde')),
                              const SizedBox(
                                height: 5,
                              ),
                              Text('ddddddd')
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget tripformFieldDropdown(
      {required String label,
      required List<String> items,
      required String hintText,
      required String intialdropDownValue}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 4),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            label: Text(label),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(),
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(),
                borderRadius: BorderRadius.circular(10))),
        value: null,
        onChanged: (newValue) {
          intialdropDownValue = newValue!;
        },
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget tripFormField({required String label}) {
    return Padding(
     padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 4),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          label: Text(label),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Text 3 is required';
            // validator: (value) {
            //     if (value.isEmpty) {
            //       return 'Please select a date';
            //     }
            //     DateTime selected = DateFormat('yyyy-MM-dd').parse(value);
            //     if (selected.isBefore(DateTime.now())) {
            //       return 'Please select a date not earlier than today';
            //     }
            //     return null;
            //   },/
          }
          return null;
        },
      ),
    );
  }

  Widget sectionOne() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 20,
        ),
        tripformFieldDropdown(
            label: 'Route',
            items: ['addis to ambo', 'ambo to aware'],
            hintText: 'select route',
            intialdropDownValue: 'addis to a.d'),
        SizedBox(
          height: 20,
        ),
        tripFormField(label: 'short code'),
        SizedBox(
          height: 20,
        ),
        tripformFieldDropdown(
            label: 'status',
            items: ['Active', 'pending'],
            hintText: 'status',
            intialdropDownValue: 'active'),
        SizedBox(
          height: 20,
        ),
        tripFormField(label: 'total no of seat'),
        SizedBox(
          height: 20,
        ),
        tripFormField(label: 'Tariff Amount'),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(onPressed: () {}, child: Text('Create'))
      ],
    );
  }
}
