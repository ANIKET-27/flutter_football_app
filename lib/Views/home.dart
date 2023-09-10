import 'package:all_league_football_app/Views/League_View.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.deepPurpleAccent,
        appBar: AppBar(
          title: const Text(
            'Foolball App',
          ),
        ),
        body: ListView(
         children:[
              InkWell(
              child: Container(
                margin: EdgeInsets.all(10),
                
                decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(20)
                ),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                 children: [  
                 ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child:  Image.network(
                  'https://media-1.api-sports.io/football/leagues/39.png',
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                ),
                 ),
                const SizedBox(width: 20,),  
                Text('Premier League',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                
               ]
             )
             ,
              ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LeagueView(league: "39")));
            },
        ),
              InkWell(
              child: Container(
                margin: EdgeInsets.all(10),
                
                decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(20)
                ),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                 children: [  
                  ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child:  Image.network(
                  'https://media-1.api-sports.io/football/leagues/61.png',
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                ),
                ),
                const SizedBox(width: 20,),  
                Text('League 1',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                
               ]
             )
             ,
              ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LeagueView(league: "61")));
            },
        ),
              InkWell(
              child: Container(
                margin: EdgeInsets.all(10),
                
                decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(20)
                ),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                 children: [  
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child:  Image.network(
                  'https://media-1.api-sports.io/football/leagues/78.png',
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                ),
                ),
                const SizedBox(width: 20,),  
                Text('Bundesliga League',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                
               ]
             )
             ,
              ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LeagueView(league: "78")));
            },
        ),
              InkWell(
              child: Container(
                margin: EdgeInsets.all(10),
                
                decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(20)
                ),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                 children: [  
                 ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child:  Image.network(
                  'https://media-1.api-sports.io/football/leagues/135.png',
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                ),
                ),
                const SizedBox(width: 20,),  
                Text('Serie A',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                
               ]
             )
             ,
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LeagueView(league: "135")));
            },
        ),
             InkWell(
              child: Container(
                margin: EdgeInsets.all(10),
                
                decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(20)
                ),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                 children: [  
                  ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child:  Image.network(
                  'https://media-1.api-sports.io/football/leagues/140.png',
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                ),
                ),
                const SizedBox(width: 20,),  
                Text('Laliga',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                
               ]
             )
             ,
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LeagueView(league: "140")));
            },
        ),
       
        ] 
        
        )
    );
            
  }
}
