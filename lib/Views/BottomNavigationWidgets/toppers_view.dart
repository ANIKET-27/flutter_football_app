//import 'dart:math';

import 'package:all_league_football_app/Services/Api/api.dart';
import 'package:all_league_football_app/Services/Modals/player_stats.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/scheduler.dart';

class TopInLeagueView extends StatefulWidget {
  final String league;
  const TopInLeagueView({super.key, required this.league});

  @override
  State<TopInLeagueView> createState() => _TopInLeagueViewState();
}

class _TopInLeagueViewState extends State<TopInLeagueView> {
  late List<PlayerStats> goals = [];
  late List<PlayerStats> assists;
  late List<PlayerStats> yellowcard;
  late List<PlayerStats> redCard;

  void getData() async {
    goals = await Api.TopScorers(widget.league);
    setState(() {});
  }

  Widget buildTile(int idx) {
    PlayerStats data = goals[idx];
    return SizedBox(
        height: 75,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                  child: Text((idx + 1).toString(),
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ),
            Expanded(
              flex: 3,
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Image.network(data.player.image, width: 50, fit: BoxFit.cover),
                SizedBox(
                  width: 10,
                ),
                Text(
                  data.player.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ]),
            ),
            Expanded(
              flex: 1,
              child:
                  Center(child: Image.network(data.stats.team.logo, width: 35)),
            ),
            Expanded(
              flex: 1,
              child: Center(
                  child: Text(data.stats.goals.total.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ),
          ],
        ));
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff7f7f7),
     body:SafeArea( 
     child:Column(
      children: [
        const Text(
          "Most Goals",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        const Text(
          "2022/23",
          style: TextStyle(fontSize: 16),
        ),
        Expanded(
            child: goals.isEmpty
                ? const Center(child: CircularProgressIndicator())
                :SingleChildScrollView(
                   scrollDirection: Axis.vertical,
                   child:ListView(
                  physics: NeverScrollableScrollPhysics(),
                  
                    shrinkWrap: true,
                     children: [
                        Container(
                            margin: const EdgeInsets.all(10),
                            padding: EdgeInsets.all(15),
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '1',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xffFE2B84),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(goals[0].player.name,
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold)),
                                    Text(goals[0].stats.team.name,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                    Text(goals[0].stats.goals.total.toString(),
                                        style: TextStyle(
                                            fontSize: 35,
                                            color: Color(0xffFE2B84)))
                                  ],
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(goals[0].player.image),
                                ),
                              ],
                            )
                            ),
                         const Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Center(
                                    child: Text("Pos",
                                        style: TextStyle(fontSize: 17)))),
                            Expanded(
                                flex: 3,
                                child: Center(
                                    child: Text("Player",
                                        style: TextStyle(fontSize: 17)))),
                            Expanded(
                                flex: 1,
                                child: Center(
                                    child: Text("Team",
                                        style: TextStyle(fontSize: 17)))),
                            Expanded(
                                flex: 1,
                                child: Center(
                                    child: Text("Goals",
                                        style: TextStyle(fontSize: 17)))),
                          ],
                        ),
                       ListView.builder(
                            shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: goals.length - 1,
                                itemBuilder: (context, idx) {
                                  return buildTile(idx + 1);
                                }
                                )
                        
                      ],
                    ),
                  )
                  // )
      ,
     )
     
     
     ]
     
    )
    )
    );
  }
}
