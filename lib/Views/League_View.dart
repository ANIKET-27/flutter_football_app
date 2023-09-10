import 'package:all_league_football_app/Views/BottomNavigationWidgets/fixtues_view.dart';
import 'package:all_league_football_app/Views/BottomNavigationWidgets/table_view.dart';
import 'package:all_league_football_app/Views/BottomNavigationWidgets/toppers_view.dart';
import 'package:flutter/material.dart';

class LeagueView extends StatefulWidget {
  final String league;
  const LeagueView({super.key, required this.league});
  @override
  State<LeagueView> createState() => LeagueViewState();

}

class LeagueViewState extends State<LeagueView> {
late int selectedItem;
late String league;
List pages=[];
  @override
  void initState() {
    selectedItem=0;
    league=widget.league;
    pages.add(TableView(league: league));
    pages.add(FixturesView(league: league));
    pages.add(TopInLeagueView(league: league));
  
    super.initState();
  }
 

  void ontap(int idx) {
    setState(() {
      selectedItem = idx;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.table_chart), label: 'Table'),
          BottomNavigationBarItem(
              icon: Icon(Icons.upcoming), label: 'Fixtures'),
          BottomNavigationBarItem(
              icon: Icon(Icons.star), label: 'Top Scorer'),
        ],
        currentIndex: selectedItem,
        selectedItemColor:  Color(0xffFE2B84),
        unselectedItemColor: Colors.grey,
        onTap: (value) => ontap(value),
      ),
      //body: navigationWidget[selectedItem],
      body:pages[selectedItem]
    );
  }
}
