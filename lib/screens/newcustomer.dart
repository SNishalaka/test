
import 'package:flutter/material.dart';
import 'package:sqlite_sample/models/customer.dart';
import 'package:sqlite_sample/utils/database_helper.dart';

class NewCustomer extends StatefulWidget {
  const NewCustomer({Key? key}) : super(key: key);

  @override
  State<NewCustomer> createState() => _NewCustomerState();
}

class _NewCustomerState extends State<NewCustomer> {
  List<Customer> _customers = [];
  late DatabaseHelper _dbHelper;

  final GlobalKey<FormState> _formKey = GlobalKey();
  
  @override
  void initState() {
    super.initState();
    setState(() {
      _dbHelper = DatabaseHelper.instance;
    });
  }
  var measure;

 Customer _customer = Customer(firstName: "", lastName: "", bodyTemp: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Customer"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const Align(
              alignment: Alignment.topLeft,
              child: Text("Enter your data",
                  style: TextStyle(
                    fontSize: 24,
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'First Name',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        border: OutlineInputBorder()),
                    onSaved: (val) =>
                        setState(() => _customer.firstName = val!),
                    onFieldSubmitted: (value) {
                      setState(() {
                        // firstName = value.capitalize();
                        // firstNameList.add(firstName);
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        // firstName = value.capitalize();
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 3) {
                        return 'First Name must contain at least 3 characters';
                      } else if (value.contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                        return 'First Name cannot contain special characters';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Last Name',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        border: OutlineInputBorder()),
                    onSaved: (val) => setState(() => _customer.lastName = val!),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 3) {
                        return 'Last Name must contain at least 3 characters';
                      } else if (value.contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                        return 'Last Name cannot contain special characters';
                      }
                    },
                    onFieldSubmitted: (value) {
                      setState(() {
                        // lastName = value.capitalize();
                        // lastNameList.add(lastName);
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        // lastName = value.capitalize();
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Body Temperature',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    onSaved: (val) => setState(() => _customer.bodyTemp = val!),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.contains(RegExp(r'^[a-zA-Z\-]'))) {
                        return 'Use only numbers!';
                      }
                    },
                    onFieldSubmitted: (value) {
                      setState(() {
                        // bodyTemp = value as int;
                        // bodyTempList.add(bodyTemp);
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        //bodyTemp = value as int;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // DropdownButtonFormField(
                  //     decoration: const InputDecoration(
                  //         enabledBorder: OutlineInputBorder(
                  //           borderRadius:
                  //               BorderRadius.all(Radius.circular(20.0)),
                  //           borderSide:
                  //               BorderSide(color: Colors.grey, width: 0.0),
                  //         ),
                  //         border: OutlineInputBorder()),
                  //     items: const [
                  //       DropdownMenuItem(
                  //         value: 1,
                  //         child: Text("ºC"),
                  //       ),
                  //       DropdownMenuItem(
                  //         value: 2,
                  //         child: Text("ºF"),
                  //       )
                  //     ],
                  //     hint: const Text("Select item"),
                  //     onChanged: (value) {
                  //       setState(() {
                  //         measure = value;
                  //         // measureList.add(measure);
                  //       });
                  //     },
                  //     onSaved: (value) {
                  //       setState(() {
                  //         measure = value;
                  //       });
                  //     }),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(60)),
                    onPressed: () => _saveCustomer(),
                    child: const Text("Submit"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // _refreshCustomerList() async {
  //   List<Map<String, dynamic>> x = (await _dbHelper.fetchCustomers();
  // }

  _saveCustomer() async{
    var formData = _formKey.currentState;
    formData?.save();
    await _dbHelper.insertCustomer(_customer);
    print("=======");
    print(Customer.tblCustomer.length);
  }
}

extension StringExtension on String {
  // Method used for capitalizing the input from the form
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}