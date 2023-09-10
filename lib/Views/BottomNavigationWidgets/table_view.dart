import 'package:all_league_football_app/Services/Api/api.dart';
import 'package:all_league_football_app/Services/Modals/table.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TableView extends StatefulWidget {
  final String league;
  const TableView({super.key, required this.league});

  @override
  State<TableView> createState() => _TableViewState();
}

class _TableViewState extends State<TableView> {
  late List<TableData> data = [];

  void getData() async {
    data = await Api.getLeagueTable(widget.league);
    setState(() {});
  }

  Widget buildTable() {
    List<Widget> list = [];
    for (int i = 0; i < data.length; i++) {
      list.add(
        Container(
         height: 100,
        child:
        Row(
          children: [
                              Container(
                                width: 40,
                                child: Center(child: Text(data[i].rank.toString())),
                              ),
                              Container(
                                
                                width: 150,
                                child: Row(
                                  children: [
                                    Image.network(data[i].team.logo,width: 30,fit: BoxFit.cover,),
                                    Expanded(child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Text(data[i].team.name),
                                    )),
                                  ]),
                              ),
                              Container(
                                width: 40,
                                child: Center(child: Text(data[i].all.played.toString())),
                              ),
                              Container(
                                width: 40,
                                child: Center(child: Text(data[i].goalsDiff.toString())),
                              ),
                              Container(
                                width: 40,
                                child: Center(child: Text(data[i].points.toString())),
                              )
          ]
        )
        )
      );
    }
    return Column(
      children: list,
    );
  }

  @override
  void initState() {
    super.initState();
    if(data.isEmpty)
     getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child:
             data.length == 0
                ? Center(
                    child: CircularProgressIndicator(),
                  ):
            Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Text('League Table',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple)),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 40,
                                child: Center(child: Text('Pos')),
                              ),
                              Container(
                                width: 150,
                                child: Center(child: Text('Club')),
                              ),
                              Container(
                                width: 40,
                                child: Center(child: Text('MP')),
                              ),
                              Container(
                                width: 40,
                                child: Center(child: Text('GD')),
                              ),
                              Container(
                                width: 40,
                                child: Center(child: Text('Pts')),
                              ),
                              //  Expanded(
                              //  child: Center(child: Text('Form')),
                              // )
                            ],
                          ),
                          Container(
                          height: MediaQuery.of(context).size.height-180,
                          child :SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child:buildTable(),
                          )
                          ),
                          
                       ],
                      ),
                    ]
                  )
                  )
                  );
  }
}
