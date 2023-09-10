import 'fixture.dart';
import 'goals.dart';
import 'leagues.dart';
import 'teams.dart';
class FixutreData {
  final Fixture fixture;
  final League league;
  final Teams teams;
  final Goals goals;

  FixutreData(this.fixture, this.league, this.teams, this.goals);

  factory FixutreData.formJson(Map<String, dynamic> e) {
    return FixutreData(Fixture.fromJson(e["fixture"]), League.fromJson(e['league']), Teams.fromJson(e['teams']),Goals.formJson(e['goals']));
  }
}
