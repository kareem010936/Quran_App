import 'package:dio/dio.dart';
class Api {
  final dio = Dio();
  Get_Azqar() async {
    Response rsposnse;
    rsposnse = await dio.get("https://alquran.vip/APIs/azkar");
    return rsposnse.data;
  }
}
