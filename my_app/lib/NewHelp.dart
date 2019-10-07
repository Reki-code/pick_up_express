import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:data_plugin/bmob/type/bmob_date.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:my_app/Modal.dart';
import 'package:intl/intl.dart';

import 'DatabaseHandler.dart';

class NewHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("取快递"),
        ),
        body: NewHelpForm());
  }
}

class NewHelpForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewHelpFormState();
  }
}

class NewHelpFormState extends State<NewHelpForm> {
  final _formKey = GlobalKey<FormState>();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final codeController = TextEditingController();
  final remarksController = TextEditingController();
  final contactController = TextEditingController();
  var selectSize;
  BmobDate appointedTime;
  String appointed;
  String curUserId;
  final dateFormat = DateFormat('yyyy-MM-dd HH:mm');
  
  final List<DropdownMenuItem> sizeList = [
    DropdownMenuItem(value: '2kg', child: Text('2KG以下'),),
    DropdownMenuItem(value: '4kg', child: Text('2KG~4KG'),),
    DropdownMenuItem(value: '6kg', child: Text('4KG~6KG'),),
    DropdownMenuItem(value: '10kg', child: Text('6KG~10KG'),),
  ];

  @override
  void initState( ) {
    super.initState();
    DatabaseHandler.getCurrentUser().then((userId) {
      curUserId = userId;
      BmobQuery().queryObjectByTableName(userId, '_User').then((userJson) {
        User user = User.fromJson(userJson);
        addressController.text = user.address ?? '';
        contactController.text = user.mobilePhoneNumber ?? '';
      });
    });

  }

  void _submit() {
    if (_formKey.currentState.validate()) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('提交中...'),
      ));
      order()
      ..expressName = nameController.text
      ..expressPhone = phoneController.text
      ..expressCode = codeController.text
      ..size = selectSize
      ..appointed = this.appointed == '尽快' ? false : true
      ..address = addressController.text
      ..remarks = remarksController.text
      ..userId = curUserId
      ..contactInfo = contactController.text
      ..appointedTime = appointedTime
      ..save().then((saved) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('提交成功'),
        ));
      }).catchError((e) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('提交失败'),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, vc) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    '快递信息:',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        labelText: '姓名'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return '不可为空';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
//                          contentPadding: EdgeInsets.all(30.0),
                        labelText: '电话'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return '不可为空';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: codeController,
                    decoration: InputDecoration(
//                          contentPadding: EdgeInsets.all(30.0),
                        labelText: '取货码'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return '不可为空';
                      }
                      return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        Text('快递规格: '),
                        DropdownButton(
                          hint: Text('选择快递规格'),
                          value: selectSize,
                          items: sizeList,
                          onChanged: (size) {
                            setState(() {
                              selectSize = size;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '收件信息:',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                  Column(
                    children: <Widget>[
                      RadioListTile<String>(
                        title: const Text('尽快'),
                        value: "尽快",
                        groupValue: this.appointed,
                        onChanged: (v) {
                          setState(() {
                            appointed = v;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: const Text('另约'),
                        value: "另约",
                        groupValue: this.appointed,
                        onChanged: (v) {
                          setState(() {
                            appointed = v;
                          });
                        },
                      )
                    ],
                  ),
                  DateTimeField(
                    decoration: InputDecoration(
                      labelText: '预约时间',
                      hintText: '可不填'
                    ),
                    enabled: appointed == '另约',
                    onChanged: (t) {
                      setState(() {
                        appointedTime = BmobDate()..setDate(t);
                      });
                    },
                    onShowPicker: (BuildContext context, DateTime currentValue) async {
                      var date = await showDatePicker(
                          lastDate: DateTime(2025),
                          context: context, 
                          firstDate: DateTime(2019),
                          initialDate: currentValue ?? DateTime.now()
                      );
                      if (date != null) {
                        var time = await showTimePicker(
                            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                            context: context,
                        );
                        return DateTimeField.combine(date, time);
                      }
                      return currentValue;
                    },
                    format: dateFormat,
                  ),
                  TextFormField(
                    controller: contactController,
                    autovalidate: true,
                    decoration: InputDecoration(
//                          contentPadding: EdgeInsets.all(30.0),
                        labelText: '联系电话'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return '不可为空';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: addressController,
                    autovalidate: true,
                    decoration: InputDecoration(
//                          contentPadding: EdgeInsets.all(30.0),
                        labelText: '收货地址'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return '不可为空';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: remarksController,
                    decoration: InputDecoration(
//                          contentPadding: EdgeInsets.all(30.0),
                        labelText: '备注'),
                    validator: (value) {
                      return null;
                    },
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: RaisedButton(
                          color: Colors.blue,
                          onPressed: _submit,
                          child: Text('发布', style: TextStyle(
                              color: Colors.white
                          ),),
                        ),
                      )
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
