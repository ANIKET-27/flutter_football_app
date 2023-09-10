import 'dart:convert';

import 'package:all_league_football_app/Services/Modals/LiveFixtures/live_fixture_data.dart';
//import 'package:all_league_football_app/Services/Modals/fixture.dart';
import 'package:all_league_football_app/Services/Modals/fixture_data.dart';
import 'package:all_league_football_app/Services/Modals/player_stats.dart';
import 'package:all_league_football_app/Services/Modals/table.dart';
import 'package:http/http.dart' as http;

class Api {
  static final headers = {
    'x-rapidapi-host': "v3.football.api-sports.io",
    'x-rapidapi-key': "b1fdf62cbb56b8e5089b7a7ffc108e3c"
  };

  static Future<List<TableData>> getLeagueTable(String league) async {
    String url =
        "https://v3.football.api-sports.io/standings?league=$league&season=2023";

    List<TableData> table;
    http.Response res = await http.get(Uri.parse(url), headers: headers);

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      List<dynamic> temp = data['response'][0]['league']['standings'][0];
      table = temp.map((dynamic e) => TableData.formJson(e)).toList();
      return table;
    } else
      table = [];

    return table;
  }

   static Future<List<FixutreData>> getLiveMatches(String league) async {
    String url =
        "https://v3.football.api-sports.io/fixtures/?league=$league&season=2023&live=all";

    List<FixutreData> table;
    http.Response res = await http.get(Uri.parse(url), headers: headers);

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      List<dynamic> temp = data['response'];
      table = temp.map((dynamic e) => FixutreData.formJson(e)).toList();
      return table;
    } else
      table = [];

    return table;
  }

  static Future<List<FixutreData>> getupcomingMatches(String league) async {
    String url =
        "https://v3.football.api-sports.io/fixtures/?league=$league&season=2023&timezone=Asia/Kolkata&next=15";

    List<FixutreData> table;
    http.Response res = await http.get(Uri.parse(url), headers: headers);

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      List<dynamic> temp = data['response'];
      table = temp.map((dynamic e) => FixutreData.formJson(e)).toList();
      return table;
    } else
      table = [];

    return table;
  }

  static Future<List<PlayerStats>> TopScorers(String league) async {
    String url =
        "https://v3.football.api-sports.io/players/topscorers?league=$league&season=2023";

    List<PlayerStats> table;
    http.Response res = await http.get(Uri.parse(url), headers: headers);

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      List<dynamic> temp = data['response'];

      table = temp.map((dynamic e) => PlayerStats.fromJson(e)).toList();
      // print(table);
      return table;
    } else
      table = [];

    return table;
  }

  static Future<List<PlayerStats>> TopAssists(String league) async {
    String url =
        "https://v3.football.api-sports.io/players/topassists?league=$league&season=2023";

    List<PlayerStats> table;
    http.Response res = await http.get(Uri.parse(url), headers: headers);

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      List<dynamic> temp = data['response'];

      table = temp.map((dynamic e) => PlayerStats.fromJson(e)).toList();

      return table;
    } else
      table = [];

    return table;
  }

  static Future<List<PlayerStats>> YellowCard(String league) async {
    String url =
        "https://v3.football.api-sports.io/players/topyellowcards?league=$league&season=2023";

    List<PlayerStats> table;
    http.Response res = await http.get(Uri.parse(url), headers: headers);

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      List<dynamic> temp = data['response'];

      table = temp.map((dynamic e) => PlayerStats.fromJson(e)).toList();

      return table;
    } else
      table = [];

    return table;
  }

  static Future<List<PlayerStats>> RedCard(String league) async {
    String url =
        "https://v3.football.api-sports.io/players/topredcards?league=$league&season=2023";

    List<PlayerStats> table;
    http.Response res = await http.get(Uri.parse(url), headers: headers);

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      List<dynamic> temp = data['response'];

      table = temp.map((dynamic e) => PlayerStats.fromJson(e)).toList();

      return table;
    } else
      table = [];

    return table;
  }

  static Future<LiveMatchData> getLiveMatchData(int id) async {
    String url = "https://v3.football.api-sports.io/fixtures?id=$id";

    http.Response res = await http.get(Uri.parse(url), headers: headers);
    LiveMatchData lmd = LiveMatchData();
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);

      lmd.getAllEvent(data['response'][0]['events']);
      lmd.getLineUp(data['response'][0]['lineups']);
      lmd.getStats(data['response'][0]['statistics'][0]['statistics'],
          (data['response'][0]['statistics'][1]['statistics']));
    }
    return lmd;
  }

  static Future<List<FixutreData>> getAllMathces(String league) async {
    String url =
        "https://v3.football.api-sports.io/fixtures/?league=$league&season=2023";

    List<FixutreData> table = [];
    http.Response res = await http.get(Uri.parse(url), headers: headers);

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      List<dynamic> temp = data['response'];
      table = temp.map((dynamic e) => FixutreData.formJson(e)).toList();
     
      return table;
    }

    return table;
  }
}
