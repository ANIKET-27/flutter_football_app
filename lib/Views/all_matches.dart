import 'package:all_league_football_app/Services/Api/api.dart';
import 'package:all_league_football_app/Services/Modals/fixture_data.dart';
import 'package:all_league_football_app/Views/BottomNavigationWidgets/fixtues_view.dart';
import 'package:all_league_football_app/Views/live_match_view.dart';
import 'package:flutter/material.dart';

class AllMatches extends StatefulWidget {
  final String league;
  const AllMatches({super.key, required this.league});

  @override
  State<AllMatches> createState() => _AllMatchesState();
}

class _AllMatchesState extends State<AllMatches> {
  List<FixutreData> allMatches = [];

  void getData() async {
    allMatches = await Api.getAllMathces(widget.league);
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Matches'),
      ),
      body: allMatches.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: allMatches.length,
              itemBuilder: (BuildContext context, int index) {
                return tileBuilder(allMatches[index]);
              },
            ),
    );
  }

  Widget tileBuilder(FixutreData data) {
    if (data.fixture.statue.short == "NS")
      return FixturesViewState().buildUpcomingTile(data);

    return buildDoneTile(data);
  }

  Widget buildDoneTile(FixutreData data) {
   
    int val = 0;
    if (data.goals.home > data.goals.away) val = 1;
    if (data.goals.home < data.goals.away) val = -1;

    TextStyle norm = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    TextStyle win = const TextStyle(
        fontSize: 25, fontWeight: FontWeight.bold, color: Colors.deepOrange);

    return InkWell(
      child: Container(
       
        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
        padding: EdgeInsets.all(7),
        height: 75,
        decoration: BoxDecoration(
           color: Color(0xffD3D3D3),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                    data.teams.home.name,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  )
                  ),
                    SizedBox(
                      width: 2,
                    ),
                    Image.network(
                      data.teams.home.logo,
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                  ],
                )),
            Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data.goals.home.toString(),
                          style: val == 1 ? win : norm,
                        ),
                        SizedBox(width: 7),
                        Text(
                          ":",
                          style: norm,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          data.goals.away.toString(),
                          style: val == -1 ? win : norm,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(data.fixture.statue.short),
                  ],
                )),
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      data.teams.away.logo,
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                   Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                    data.teams.away.name,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  )
                  ),
                  ],
                ))
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LiveMatchDetails(fixd: data)));
      },
    );
  }
}
