import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wonderful_ties/models/cepaberto_address.dart';

const token = '1229b084aa05b23664124cc5debeab82';

class CepAbertoService {
  Future<CepAbertoAddress> getAddressFromCep(String cep) async {
    final cleanCep = cep.replaceAll('.', '').replaceAll('-', '');
    final endpoint = "https://www.cepaberto.com/api/v3/cep?cep=$cleanCep";
    final Dio dio = Dio();
    dio.options.headers[HttpHeaders.authorizationHeader] = 'Token token = $token';
    try{
      final response = await dio.get<Map<String, dynamic>>(endpoint);
      if(response.data.isEmpty){
        return Future.error('CEP inválido');
      }
      final CepAbertoAddress address = CepAbertoAddress.fromMap(response.data);
    } on DioError catch(e){
      return Future.error('Erro ao buscar CEP');
    }
  }
}