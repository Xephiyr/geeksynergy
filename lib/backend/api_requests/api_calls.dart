import 'api_manager.dart';

Future<dynamic> hobsListCall({
  String category = 'movies',
  String language = 'kannada',
  String genre = 'all',
  String sort = 'voting',
}) =>
    ApiManager.instance.makeApiCall(
      callName: 'HobsList',
      apiDomain: 'hoblist.com',
      apiEndpoint: 'movieList',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'category': category,
        'language': language,
        'genre': genre,
        'sort': sort,
      },
      returnResponse: true,
    );
