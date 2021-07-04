import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/create_new_db_controller.dart';
import 'db_info_bottomsheet_widget.dart';
import 'show_password_dialog.dart';

class AvailableDbList extends StatelessWidget {
  AvailableDbList({
    // Key key,
    required CreateNewDbController createNewDbController,
  })  : _createNewDbController = createNewDbController,
        super();

  final CreateNewDbController _createNewDbController;

  final _box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final String? _dbname = _box.read('databaseName');
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          print('INDEX: $index');
          return ExpansionTile(
            leading: Icon(AntDesign.database),
            title: Text(_dbname ?? ''),
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () async {
                          await showPasswordDialog(index);
                        },
                        child: Text('Open Database')),
                    TextButton(
                        onPressed: () async {
                          await _createNewDbController
                              .removeDbFromFileSystem(index);
                          _createNewDbController.removeDbOfAvailDB = index;
                        },
                        child: Text('Delete Database')),
                    TextButton(
                        onPressed: () async {
                          Get.bottomSheet(DbInfoBottomSheetWidget(index));
                        },
                        child: Text('Database Info'))
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
