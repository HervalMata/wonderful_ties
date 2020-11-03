import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:wonderful_ties/helpers/validators.dart';
import 'package:wonderful_ties/models/user.dart';
import 'package:wonderful_ties/models/user_manager.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
        actions: <Widget> [
          FlatButton(onPressed: (){
            Navigator.of(context).pushReplacementNamed('/signup');
          },
            textColor: Colors.white,
            child: const Text(
              'Criar Conta',
              style: TextStyle(fontSize: 14),
            ),
          )
        ],
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formkey,
            child: Consumer<UserManager>(
              builder: (_, userManager, child){
                if(userManager.loadingFace){
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  );
                }
                return ListView(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                children: <Widget>[
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(hintText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: (email) {
                      if(!emailValid(email))
                        return 'Email inválido';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16,),
                  TextFormField(
                    controller: passController,
                    enabled: !userManager.loading,
                    decoration: const InputDecoration(hintText: 'Senha'),
                    autocorrect: false,
                    obscureText: true,
                    validator: (pass) {
                      if (pass.isEmpty || pass.length < 6)
                        return 'Senha inválida';
                      return null;
                    },
                  ),
                  child,
                  const SizedBox(height: 16,),
                  RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: userManager.loading ? null : (){
                        if(formkey.currentState.validate()){
                          userManager.signIn(
                            user: User(
                              email: emailController.text,
                              password: passController.text
                            ),
                            onFail: (e){
                              scaffoldkey.currentState.showSnackBar(
                                SnackBar(
                                  content: Text('Falha ao entrar: $e'),
                                  backgroundColor: Colors.red,
                                )
                              );
                            },
                            onSuccess: (){
                              Navigator.of(context).pop();
                            }
                          );
                        }
                      },
                    color: Theme.of(context).primaryColor,
                    disabledColor: Theme.of(context).primaryColor.withAlpha(100),
                    textColor: Colors.white,
                    child: userManager.loading ?
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ) : const Text(
                            'Entrar',
                            style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SignInButton(
                      Buttons.Facebook,
                      text: 'Entrar com Facebook',
                      onPressed: (){
                        userManager.facebookLogin(
                          onFail: (e){
                            scaffoldkey.currentState.showSnackBar(
                              SnackBar(
                                content: Text('Falha ao entrar: $e'),
                                backgroundColor: Colors.red,
                              )
                            );
                          },
                          onSuccess: (){
                            Navigator.of(context).pop();
                          }
                        );
                      },
                  )
                ],
              );
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                  onPressed: (){
                  },
                  padding: EdgeInsets.zero,
                  child: const Text('Esqueci minha senha'),
              ),
            ),
          ),
          ),
        ),
      ),
    );
  }
}