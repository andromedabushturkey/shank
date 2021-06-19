import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:shank/Widgets/db_info_bottomsheet_widget.dart';
import 'package:shank/Widgets/show_password_dialog.dart';

import '../controllers/create_new_db_controller.dart';

class AvailableDbList extends StatelessWidget {
  const AvailableDbList({
    // Key key,
    required CreateNewDbController createNewDbController,
  })  : _createNewDbController = createNewDbController,
        super();

  final CreateNewDbController _createNewDbController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () => ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: _createNewDbController.listOfAvailDb.length,
          itemBuilder: (BuildContext context, int index) {
            String _databaseName =
                basename(_createNewDbController.listOfAvailDb[index].path);
            return ExpansionTile(
              leading: Icon(AntDesign.database),
              title: Text(_databaseName),
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
                          onPressed: () {
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
      ),
    );
  }
}
