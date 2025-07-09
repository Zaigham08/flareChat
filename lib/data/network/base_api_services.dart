abstract class BaseApiServices{

  Future<dynamic> getApi(String url);

  Future<dynamic> getApiWithParams(String url, dynamic params);

  Future<dynamic> postApi(String url, dynamic data, {int time = 50});

  Future<dynamic> postApiWithParams(String url, dynamic data, dynamic params);

  Future<dynamic> putApi(String url, dynamic data, String param);

  Future<dynamic> deleteApi(String url, dynamic data);

  Future<dynamic> deleteApiWithParams(String url, var params);

}