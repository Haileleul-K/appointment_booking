import 'package:flutter/material.dart';

import '../../../core/colors.dart';

Container tripCreateModalsheet(context,
      {required String iconPath, required String iconText}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: AppColors.primaryAppColor)),
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => Dialog(
                    child: Container(
                      
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Text('Create New trip',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                              trailing: IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.highlight_remove_rounded)),
                            ),
                            SizedBox(height: 20,),
                            tripformFieldDropdown(
                              label: 'Route',
                              items: ['addis to ambo', 'ambo to aware'],
                              hintText: 'select route',
                              intialdropDownValue: 'addis to a.d'
                            ),
                            SizedBox(height: 20,),
                            tripformFieldDropdown(
                              label: 'Vehicle',
                              items: ['lumbherigini', 'bugati'],
                              hintText: 'select vehicle',
                              intialdropDownValue: 'bugati'
                            ),
                            SizedBox(height: 20,),
                            tripFormField(label: 'short code'),
                            SizedBox(height: 20,),
                            tripformFieldDropdown(
                                label: 'status',
                                items: ['Active', 'pending'],
                                hintText: 'status',
                                intialdropDownValue: 'active'
                                ),
                                SizedBox(height: 20,),
                            tripFormField(label: 'total no of seat'),
                            SizedBox(height: 20,),
                            tripFormField(label: 'Tariff Amount'),
                            SizedBox(height: 20,),
                            ElevatedButton(onPressed: (){}, child: Text('Create'))
                          ],
                        ),
                      ),
                    ),
                  ));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              iconPath,
              scale: 1.9,
              color: Colors.orange,
            ),
            SizedBox(
              width: 60,
            ),
            Text(
              iconText,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  TextFormField tripFormField({required String label}) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        label: Text(label),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Text 3 is required';
        }
        return null;
      },
    );
  }

  DropdownButtonFormField<String> tripformFieldDropdown({
    required String label,
    required List<String> items,
    required String hintText,
    required String intialdropDownValue
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
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
    );
  }



Container vehicleAddModalsheet(context,
      {required String iconPath, required String iconText}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: AppColors.primaryAppColor)),
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => Dialog(
                    child: Container(
                      
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Text('Add new vehicle',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                              trailing: IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.highlight_remove_rounded)),
                            ),
                          
                            SizedBox(height: 20,),
                            tripFormField(label: 'car model'),
                            SizedBox(height: 20,),
                            tripFormField(label: 'Car side_No'),
                            SizedBox(height: 20,),
                            tripFormField(label: 'No of seat'),
                            SizedBox(height: 20,),
                            ElevatedButton(onPressed: (){}, child: Text('Add'))
                          ],
                        ),
                      ),
                    ),
                  ));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              iconPath,
              scale: 1.9,
              color: Colors.orange,
            ),
            SizedBox(
              width: 60,
            ),
            Text(
              iconText,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }