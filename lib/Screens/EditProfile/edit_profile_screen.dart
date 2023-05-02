import 'package:app_mental/Services/userService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../helper/constants.dart';
import '../../helper/helperfuncions.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/edit-profile-screen';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController occupationController = new TextEditingController();
  TextEditingController workController = new TextEditingController();
  TextEditingController nicknameController = new TextEditingController();
  var genderDropDown = null;
  var civilDropDown = null;
  String userEmail = "";

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  getUserInfo() async {
    await HelperFunctions.getUserNameAndEmailInSharedPreference().then((user) {
      setState(() {
        nameController.text = user["name"];
        userEmail = user["email"];
      });
      UserService().getUserApp(user["email"]).then((userApp) {
        if (userApp.age != null) {
          ageController.text = userApp.age!;
        }
        if (userApp.phone != null) {
          phoneController.text = userApp.phone!;
        }
        if (userApp.occupation != null) {
          occupationController.text = userApp.occupation!;
        }
        if (userApp.workplace != null) {
          workController.text = userApp.workplace!;
        }
        if (userApp.gender != null && userApp.gender != "") {
          setState(() {
            genderDropDown = userApp.gender;
          });
        }
        if (userApp.maritalStatus != null && userApp.maritalStatus != "") {
          setState(() {
            civilDropDown = userApp.maritalStatus;
          });
        }
        if (userApp.nickname != null) {
          nicknameController.text = userApp.nickname!;
        }
      });
    });
  }

  goBackToHome(BuildContext context) {
    Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
    navigateToHome(context);
  }

  navigateToHome(BuildContext context) {
    Navigator.of(context).pushNamed("/logged-home");
  }

  popContext(BuildContext context) {
    Navigator.pop(context);
  }

  saveUserProfile(BuildContext context) async {
    if (genderDropDown == null) {
      genderDropDown = "";
    }
    if (civilDropDown == null) {
      civilDropDown = "";
    }
    await UserService()
        .saveUserProfile(
            userEmail,
            nameController.text,
            genderDropDown,
            ageController.text,
            workController.text,
            civilDropDown,
            occupationController.text,
            phoneController.text,
            nicknameController.text)
        .then((_) {
      HelperFunctions.saveUserNameInSharedPreference(nameController.text);
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Êxito!'),
          content: const Text('Seu perfil foi salvo com sucesso!'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                goBackToHome(context);
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    }).catchError((error) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Erro!'),
          content: Text(error.toString()),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                popContext(context);
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    });
  }

  _generateNickname() async {
    await UserService().getNewNickname().then((newNickname) {
      setState(() {
        nicknameController.text = newNickname;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.green,
        shadowColor: Colors.transparent,
        title: Text("Editar perfil"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            navigateToHome(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(104, 202, 138, .2),
                        blurRadius: 20.0,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Nome:",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      TextFormField(
                        controller: nameController,
                        validator: (val) {
                          return val!.isEmpty
                              ? "Por favor digite o seu nome!"
                              : null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(104, 202, 138, .2),
                        blurRadius: 20.0,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Apelido:",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                        readOnly: true,
                        controller: nicknameController,
                      ),
                      ElevatedButton(
                        onPressed: () => _generateNickname(),
                        child: Text(
                          "Gerar novo apelido",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(104, 202, 138, .2),
                        blurRadius: 20.0,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Sexo:",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      DropdownButton(
                        isExpanded: true,
                        items: Constants.gender.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Center(
                              child: Text(
                                items,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }).toList(),
                        value: genderDropDown,
                        onChanged: (value) {
                          setState(() {
                            genderDropDown = value.toString();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(104, 202, 138, .2),
                        blurRadius: 20.0,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Idade:",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      TextFormField(
                        maxLength: 3,
                        controller: ageController,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(104, 202, 138, .2),
                        blurRadius: 20.0,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Local de trabalho:",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      TextFormField(
                        controller: workController,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(104, 202, 138, .2),
                        blurRadius: 20.0,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Estado civil:",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      DropdownButton(
                        isExpanded: true,
                        items: Constants.civil.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Center(
                              child: Text(
                                items,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }).toList(),
                        value: civilDropDown,
                        onChanged: (value) {
                          setState(() {
                            civilDropDown = value.toString();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(104, 202, 138, .2),
                        blurRadius: 20.0,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Profissão:",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      TextFormField(
                        controller: occupationController,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(104, 202, 138, .2),
                        blurRadius: 20.0,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Telefone:",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      TextFormField(
                        maxLength: 20,
                        controller: phoneController,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  child: Text(
                    'Salvar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      saveUserProfile(context);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
