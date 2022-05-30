
import 'package:flutter/material.dart';
import 'package:sqlite_sample/models/customer.dart';
import 'package:sqlite_sample/utils/database_helper.dart';

class AllCustomers extends StatefulWidget {
  const AllCustomers({Key? key}) : super(key: key);

  @override
  State<AllCustomers> createState() => _AllCustomersState();
}

class _AllCustomersState extends State<AllCustomers> {
 List<Customer> _customers = [];
  late DatabaseHelper _dbHelper;

  @override
  void initState() {
    super.initState();
    setState(() {
      print(_customers.length);
      _dbHelper = DatabaseHelper.instance;
      _refreshCustomerList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Customers"),
      ),
      body: Card(
        margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            return Column(
              children:  <Widget>[
                ListTile(
                  title: Text(
                    _customers[index].firstName.toUpperCase(),
                  ),
                ),
                const Divider(
                  height: 5.0,
                )
              ],
            );
          },
          itemCount: _customers.length,
        ),
      ),
    );
  }


  _refreshCustomerList() async {
    List<Map<String, dynamic>> x = (await _dbHelper.fetchCustomers()) as List<Map<String, dynamic>>;
    setState(() {
      _customers = x.cast<Customer>();
    });
  }

}


