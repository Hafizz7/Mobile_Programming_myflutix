import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myflutix/models/cast.dart';
import 'package:myflutix/models/movie_populer_list.dart';
import 'package:myflutix/models/runtime.dart';

class ApiService {
  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkM2Q2OTA2N2Y3YTUzMzlmZWFkNzhmZmNhYWVjMjYwMSIsInN1YiI6IjY1MTEwNjhhMjZkYWMxMDEyZDViYTYyNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.W_bqfydwpdYfHD0kUIBrI3nDdAV7AhfOqzfJGNBXU5w';

  // final String apiKey2 =
  //     'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkM2Q2OTA2N2Y3YTUzMzlmZWFkNzhmZmNhYWVjMjYwMSIsInN1YiI6IjY1MTEwNjhhMjZkYWMxMDEyZDViYTYyNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.W_bqfydwpdYfHD0kUIBrI3nDdAV7AhfOqzfJGNBXU5w';

      
  Future<List<Movie>> getPopularMovies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/popular?language=en-US&page=1'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> movies = json.decode(response.body)['results'];
      List<Movie> film = movies.map((dataFilmJson) {
        return Movie.fromJson(dataFilmJson);
      }).toList();
      return film;
      // return json.decode(response.body)['results'];
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Casttt>> getDetailMovie(int movieId) async {    
    final response = await http.get(
      Uri.parse(
          '$baseUrl/movie/$movieId?language=en-US&append_to_response=credits'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Accept': 'application/json',
      },
    );  

    if (response.statusCode == 200) {
      final dynamic responseData = json.decode(response.body);
      final Map<String, dynamic>? credits = responseData['credits'];      

      if (credits != null) {
        final List<dynamic>? castData = credits['cast'];

        if (castData != null) {
          // Konversi data cast menjadi objek Casttt
          List<Casttt> castList =
              castData.map((cast) => Casttt.fromJson(cast)).toList();
          return castList;
        }
      }
    }

    // Jika data cast kosong atau respons tidak sesuai, lemparkan pengecualian
    throw Exception('Failed to load cast details for movie $movieId');
  }

  Future<RunTime> getRuntimeMovies(int movieId) async {
  try {      
    final response = await http.get(
      Uri.parse(
        '$baseUrl/movie/$movieId',
      ),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Accept': 'application/json',
      },
    );

    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return RunTime.fromJson(data);      
    } else {
      throw Exception('Failed to load runtime for movie $movieId. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching runtime for movie $movieId: $e');
    rethrow;
  }
}


}
