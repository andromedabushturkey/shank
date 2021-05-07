import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:shank/controllers/create_new_db_controller.dart';

class AvailableDbList extends StatelessWidget {
  const AvailableDbList({
    Key key,
    @required CreateNewDbController createNewDbController,
  })  : _createNewDbController = createNewDbController,
        super(key: key);

  final CreateNewDbController _createNewDbController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() => ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: _createNewDbController.listOfAvailDb.length,
            itemBuilder: (BuildContext context, int index) {
              String _databaseName = basename(_createNewDbController.listOfAvailDb[index].path);
              return ListTile(
                onTap: () async {
                  // await showPasswordDialog(index);
                  //DBHelper.openDB(_dbList[index]);
                  print('DBINFO ${_createNewDbController.listOfAvailDb[index]}');
                },
                title: Text(_databaseName),
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      AntDesign.database,
                      size: 20,
                    ),
                  ],
                ),
                trailing: GestureDetector(
                  child: Icon(Icons.delete_outline),
                  onTap: () {
                    //delete file on filesystem
                    _createNewDbController.listOfAvailDb[index].deleteSync();
                    //remove file from tracking list
                    _createNewDbController.removeDbOfAvailDB = index;
                  },
                ),
              );
            },
          )),
    );
  }
}
