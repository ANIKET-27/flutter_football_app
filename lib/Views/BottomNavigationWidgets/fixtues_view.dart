//import 'package:all_league_football_app/Services/Modals/fixture.dart';
import 'package:all_league_football_app/Services/Modals/fixture_data.dart';
import 'package:all_league_football_app/Views/all_matches.dart';
import 'package:all_league_football_app/Views/live_match_view.dart';
import 'package:flutter/material.dart';
import 'package:all_league_football_app/Services/Api/api.dart';
import 'package:carousel_slider/carousel_slider.dart';

class FixturesView extends StatefulWidget {
  final String league;
  const FixturesView({super.key, required this.league});

  @override
  State<FixturesView> createState() => FixturesViewState();
}

class FixturesViewState extends State<FixturesView> {
  late List<FixutreData> liveMatches = [];
  late List<FixutreData> upcomingMatches = [];

  void getUpcomingData() async {
    upcomingMatches = await Api.getupcomingMatches(widget.league);
    liveMatches = await Api.getLiveMatches(widget.league);
    setState(() {});
  }

  List<String> giveString(String s) {
    return s.split(RegExp(r"(?=[A-Z])"));
  }

  Widget buildLiveMatchWidget(int idx, FixutreData fixd) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LiveMatchDetails(fixd: fixd)));
      },
      child: Container(
        // padding: EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(255, 50, 6, 56),
          gradient: const LinearGradient(
              colors: [Color(0xFF42275a), Color(0xFF734b6d)]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              fixd.league.name,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Week - " + fixd.league.round.substring(17),
                style: TextStyle(color: Colors.white, fontSize: 12)),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Image.network(
                      fixd.teams.home.logo,
                      width: 75,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                   SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child:  Text(fixd.teams.home.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold)),
                   ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Home',
                        style: TextStyle(color: Colors.white, fontSize: 10)),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        fixd.goals.home.toString() +
                            ":" +
                            fixd.goals.away.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffFE2B84)),
                        borderRadius: BorderRadius.circular(5),
                        //color: Color(0xffFE2B84).withOpacity(0.5),
                      ),
                      child: Center(
                        child: Text(
                            fixd.fixture.statue.elapsed.toString() + '\'',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Image.network(
                      fixd.teams.away.logo,
                      width: 75,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                   SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child:  Text(fixd.teams.away.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold)),
                   ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Away',
                        style: TextStyle(color: Colors.white, fontSize: 10)),
                  ],
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget buildUpcomingTile(FixutreData data) {
    List<String> temp1 = giveString(data.teams.home.name);
    List<String> temp2 = giveString(data.teams.away.name);

    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      padding: EdgeInsets.all(7),
      height: 75,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
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
                  Text(data.fixture.date.substring(11, 16),
                      style: TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(data.fixture.date.substring(0, 10)),
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
    );
  }

  @override
  void initState() {
    getUpcomingData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
          margin: EdgeInsets.all(7),
          height: MediaQuery.sizeOf(context).height,
          color: Color(0xfff7f7f7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Live Matchs",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  child: upcomingMatches.isEmpty
                      ? Center(child: CircularProgressIndicator(),)
                      : liveMatches.isEmpty?
                      Center(
                          child: const Text(
                            "No On Going Live Matches.",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        )
                       :
                       CarouselSlider.builder(
                          itemCount: liveMatches.length,
                          itemBuilder: (_, idx, p) {
                            return buildLiveMatchWidget(idx, liveMatches[idx]);
                          },
                          options: CarouselOptions(),
                        )),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Upcomings",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "See All",
                          style:
                              TextStyle(color: Colors.deepOrange, fontSize: 16),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          size: 20,
                        )
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllMatches(
                                    league: widget.league,
                                  )));
                    },
                  ),
                ],
              ),
              Expanded(
                  child: upcomingMatches.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: upcomingMatches.length,
                          itemBuilder: (context, idx) {
                            return buildUpcomingTile(upcomingMatches[idx]);
                          }))
            ],
          )),
    ));
  }
}
