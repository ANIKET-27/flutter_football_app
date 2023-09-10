import 'dart:math';

import 'package:all_league_football_app/Services/Api/api.dart';
import 'package:all_league_football_app/Services/Modals/LiveFixtures/live_fixture_data.dart';
//import 'package:all_league_football_app/Services/Modals/team.dart';
//import 'package:all_league_football_app/Services/Modals/teams.dart';


import 'package:flutter/material.dart';
import 'package:all_league_football_app/Services/Modals/fixture_data.dart';


class LiveMatchDetails extends StatefulWidget {
  final FixutreData fixd;
  const LiveMatchDetails({super.key, required this.fixd});

  @override
  State<LiveMatchDetails> createState() => _LiveMatchDetailsState();
}

class _LiveMatchDetailsState extends State<LiveMatchDetails>
    with TickerProviderStateMixin {
  late TabController tabController;
  int tabindex = 0;

  bool recivedData = false;
  late LiveMatchData lmd = LiveMatchData();
  void fetchData() async {
    lmd = await Api.getLiveMatchData(widget.fixd.fixture.id);
    setState(() {
      recivedData = true;
      tabindex = tabController.index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    tabController =
        TabController(length: 3, vsync: this, initialIndex: tabindex);
    return Scaffold(
        backgroundColor: Color(0xfff7f7f7),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                // padding: EdgeInsets.all(10),
                height: 215,
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
                      widget.fixd.fixture.venue.name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.fixd.fixture.venue.city,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Week - " + widget.fixd.league.round.substring(17),
                        style: TextStyle(color: Colors.white, fontSize: 15)),
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
                              widget.fixd.teams.home.logo,
                              width: 75,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(widget.fixd.teams.home.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Home',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10)),
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
                                widget.fixd.goals.home.toString() +
                                    ":" +
                                    widget.fixd.goals.away.toString(),
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
                                    widget.fixd.fixture.statue.elapsed
                                            .toString() +
                                        '\'',
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
                              widget.fixd.teams.away.logo,
                              width: 75,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(widget.fixd.teams.away.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Away',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10)),
                          ],
                        ),
                      ],
                    ))
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  //color: Colors.deepPurple
                ),
                child: Column(children: [
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                    child: TabBar(
                        controller: tabController,
                        isScrollable: false,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        indicator: BoxDecoration(
                          color: Color(0xffFE2B84),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        tabs: [
                          Tab(text: "Summary"),
                          Tab(text: "Stats"),
                          Tab(text: "Line-Up")
                        ]),
                  ),
                  Expanded(
                    child: TabBarView(controller: tabController, children: [
                      summaryWidget(),
                      statsWidget(),
                      lineUpWidget(),
                    ]),
                  )
                ]),
              ))
            ],
          ),
        ));
  }

  Widget summaryWidget() {
    return !(recivedData)
        ? const Center(
            child: CircularProgressIndicator(),
          )
        :lmd.allEvent.isEmpty ? 
        Center(
          child: Text("No updates so far !!",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
        )
        : 
        ListView(children: listOfEvents());
  }

  Widget statsWidget() {
    return !(recivedData)
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView(
            scrollDirection: Axis.vertical,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       "Match Stats",
              //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              //     )
              //   ],
              // ),

              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: lmd.fixStats.home.length,
                  itemBuilder: (_, idx) {
                    return Container(
                      height: 60,
                      decoration: const BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.black))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            lmd.fixStats.home[idx].value,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            lmd.fixStats.home[idx].lable,
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            lmd.fixStats.away[idx].value,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )
                        ],
                      ),
                    );
                  }),
            ],
          );
  }

  Widget lineUpWidget() {
    return !(recivedData)
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView(scrollDirection: Axis.vertical, children: [
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 30,
              child: Center(
                child: Text("MANAGER",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Image.network(
                      lmd.lineUps.home.coach.photo,
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                      child: Image.network(
                    lmd.lineUps.away.coach.photo,
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  )),
                )
              ],
            ),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        lmd.lineUps.home.coach.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                        child: Text(lmd.lineUps.away.coach.name,
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
              child: Center(
                child: Text("FORMATION",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(lmd.lineUps.home.formation,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Expanded(
                    child: Center(
                        child: Text(lmd.lineUps.away.formation,
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
              child: Center(
                child: Text("STARTING XI",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: lmd.lineUps.home.startAndSub.starteleven.length,
                itemBuilder: (_, idx) {
                  return SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                                lmd.lineUps.home.startAndSub.starteleven[idx]
                                    .number
                                    .toString(),
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                                lmd.lineUps.home.startAndSub.starteleven[idx]
                                    .name,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        )),
                        Expanded(
                          flex: 1,
                          child:Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                                lmd.lineUps.away.startAndSub.starteleven[idx]
                                    .name,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                                lmd.lineUps.away.startAndSub.starteleven[idx]
                                    .number
                                    .toString(),
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ))
                      ],
                    ),
                  );
                }),
            const SizedBox(
              height: 30,
              child: Center(
                child: Text("SUBSTITUTES",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount:min<int>(lmd.lineUps.away.startAndSub.substitue.length,lmd.lineUps.home.startAndSub.substitue.length),
                itemBuilder: (_, idx) {
                  return SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                                lmd.lineUps.home.startAndSub.substitue[idx]
                                    .number
                                    .toString(),
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                                lmd.lineUps.home.startAndSub.substitue[idx]
                                    .name,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        )),
                        Expanded(
                          flex: 1,
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                                lmd.lineUps.away.startAndSub.substitue[idx]
                                    .name,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                                lmd.lineUps.away.startAndSub.substitue[idx]
                                    .number
                                    .toString(),
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ))
                      ],
                    ),
                  );
                })
          ]);
  }

  List<Widget> listOfEvents() {
    List<Widget> curatedList = [];

    for (int i = 0; i < lmd.allEvent.length; i++) {
      curatedList.add(eventMaker(lmd.allEvent[i]));
    }
    return curatedList;
  }

  Widget eventMaker(Event event) {
    int home = widget.fixd.teams.home.id;

    String type = event.type;

    switch (type) {
      case "Goal":
        {
          if (event.team.id == home) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              height: 75,
              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(event.time.time.toString() + "\'",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(
                    width: 20,
                  ),
                  Text(event.player.name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 20,
                  ),
                  goal(),
                ],
              ),
            );
          } else
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              height: 75,
              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
              padding: EdgeInsets.all(5),
              //  margin: EdgeInsets.fromLTRB(0,2.5,0, 2.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  goal(),
                  SizedBox(
                    width: 20,
                  ),
                  Text(event.player.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(
                    width: 20,
                  ),
                  Text(event.time.time.toString() + "\'",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
            );
        }

      case "Card":
        {
          if (event.team.id == home) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              height: 75,
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(event.time.time.toString() + "\'",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(
                    width: 20,
                  ),
                  Text(event.player.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(
                    width: 20,
                  ),
                  event.detail == "Yellow Card" ? yellowCard() : redCard(),
                ],
              ),
            );
          } else
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                // borderRadius: BorderRadius.circular(15),
              ),
              height: 75,
              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
              padding: EdgeInsets.all(5),
              // margin: EdgeInsets.fromLTRB(0,2.5,0, 2.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  event.detail == "Yellow Card" ? yellowCard() : redCard(),
                  SizedBox(
                    width: 20,
                  ),
                  Text(event.player.name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 20,
                  ),
                  Text(event.time.time.toString() + "\'",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
            );
        }

      case "subst":
        {
          if (event.team.id == home) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                //  borderRadius: BorderRadius.circular(15),
              ),
              height: 75,
              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
              padding: EdgeInsets.all(5),
              // margin: EdgeInsets.fromLTRB(0,2.5,0, 2.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(event.time.time.toString() + "\'",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(event.player.name),
                      Text(event.assist.name,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  sub(),
                ],
              ),
            );
          } else
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              height: 75,
              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  sub(),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(event.player.name),
                      Text(event.assist.name,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(event.time.time.toString() + "\'",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
            );
        }

      default:
        {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            height: 75,
            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            padding: EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  event.time.time.toString() + "'  " + event.type,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  event.detail,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        }
    }
  }

  Widget goal() {
    return const Icon(
      Icons.sports_soccer,
      size: 25,
    );
  }

  Widget redCard() {
    return Container(
      color: Colors.red,
      height: 20,
      width: 15,
    );
  }

  Widget yellowCard() {
    return Container(
      color: Colors.yellow,
      height: 20,
      width: 15,
    );
  }

  Widget sub() {
    return const Row(children: [
      Icon(
        Icons.arrow_upward,
        color: Colors.green,
        size: 20,
      ),
      Icon(
        Icons.arrow_downward,
        color: Colors.red,
        size: 20,
      )
    ]);
  }
}
