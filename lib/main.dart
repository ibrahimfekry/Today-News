import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:news_app/web_view_screen.dart';

void main() {
  runApp( const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
bool iconBool = false;
IconData iconLight = Icons.wb_sunny;
IconData iconDark = Icons.nights_stay;
ThemeData lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
      color: Colors.white
  ),
  brightness: Brightness.light,
);
ThemeData darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    color: Colors.black12
  ),
  brightness: Brightness.dark,
);

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  final List<Tab>_tabList = [
   Tab(child: Text('Popular',style: TextStyle(color: iconBool ? Colors.white : Colors.black,),),),
   Tab(child: Text('Sports',style: TextStyle(color: iconBool ? Colors.white : Colors.black,)),),
   Tab(child: Text('Business',style: TextStyle(color: iconBool ? Colors.white : Colors.black,)),),
   Tab(child: Text('Entertainment',style: TextStyle(color: iconBool ? Colors.white : Colors.black,)),),
   Tab(child: Text('Health',style: TextStyle(color: iconBool ? Colors.white : Colors.black,)),),
   Tab(child: Text('Science',style: TextStyle(color: iconBool ? Colors.white : Colors.black,)),),
   Tab(child: Text('Technology',style: TextStyle(color: iconBool ? Colors.white : Colors.black,)),),
  ];
  TabController? _tabController ;
  late Map popularResponseBody;
  late Map sportsResponseBody;
  late Map businessResponseBody;
  late Map entertainmentResponseBody;
  late Map healthResponseBody;
  late Map scienceResponseBody;
  late Map technologyResponseBody;

  List articlePopularNews = [];
  List articleSportsNews = [];
  List articleBusinessNews = [];
  List articleEntertainmentNews = [];
  List articleHealthNews = [];
  List articleScienceNews = [];
  List articleTechnologyNews = [];

  Future gotPostsPopular()async{
    var popularUrl = 'https://newsapi.org/v2/top-headlines?country=eg&apiKey=2e20d6a98b6f4a5d96d305884b3c9331';
    http.Response popularResponseUrl =await http.get(Uri.parse(popularUrl));
    setState(() {
      popularResponseBody= jsonDecode(popularResponseUrl.body);
      articlePopularNews = popularResponseBody['articles'];

    });
  }
  Future gotSportsBusiness()async{
    var sportsUrl = 'https://newsapi.org/v2/top-headlines?country=eg&category=sports&apiKey=2e20d6a98b6f4a5d96d305884b3c9331';
    http.Response businessPopularUrl =await http.get(Uri.parse(sportsUrl));
    setState(() {
      sportsResponseBody= jsonDecode(businessPopularUrl.body);
      articleSportsNews = sportsResponseBody['articles'];

    });
  }
  Future gotPostsBusiness()async{
    var businessUrl = 'https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=2e20d6a98b6f4a5d96d305884b3c9331';
    http.Response businessPopularUrl =await http.get(Uri.parse(businessUrl));
    setState(() {
      businessResponseBody= jsonDecode(businessPopularUrl.body);
      articleBusinessNews = businessResponseBody['articles'];

    });
  }
  Future gotPostsEntertainment()async{
    var entertainmentUrl = 'https://newsapi.org/v2/top-headlines?country=eg&category=entertainment&apiKey=2e20d6a98b6f4a5d96d305884b3c9331';
    http.Response entertainmentResponseUrl =await http.get(Uri.parse(entertainmentUrl));
    setState(() {
      entertainmentResponseBody= jsonDecode(entertainmentResponseUrl.body);
      articleEntertainmentNews = entertainmentResponseBody['articles'];
    });
  }
  Future gotPostsHealth()async{
    var healthUrl = 'https://newsapi.org/v2/top-headlines?country=eg&category=health&apiKey=2e20d6a98b6f4a5d96d305884b3c9331';
    http.Response healthResponseUrl =await http.get(Uri.parse(healthUrl));
    setState(() {
      healthResponseBody= jsonDecode(healthResponseUrl.body);
      articleHealthNews = healthResponseBody['articles'];

    });
  }
  Future gotPostsScience()async{
    var scienceUrl = 'https://newsapi.org/v2/top-headlines?country=eg&category=science&apiKey=2e20d6a98b6f4a5d96d305884b3c9331';
    http.Response scienceResponseUrl =await http.get(Uri.parse(scienceUrl));
    setState(() {
      scienceResponseBody= jsonDecode(scienceResponseUrl.body);
      articleScienceNews = scienceResponseBody['articles'];

    });
  }
  Future gotPostsTechnology()async{
    var technologyUrl = 'https://newsapi.org/v2/top-headlines?country=eg&category=technology&apiKey=2e20d6a98b6f4a5d96d305884b3c9331';
    http.Response technologyResponseUrl =await http.get(Uri.parse(technologyUrl));
    setState(() {
      technologyResponseBody= jsonDecode(technologyResponseUrl.body);
      articleTechnologyNews = technologyResponseBody['articles'];

    });
  }
  @override
  void initState() {
  super.initState();
  _tabController= TabController(vsync:this,length: _tabList.length);
  gotPostsPopular();
  gotSportsBusiness();
  gotPostsBusiness();
  gotPostsEntertainment();
  gotPostsHealth();
  gotPostsScience();
  gotPostsTechnology();
  }
  @override
  void dispose() {
  _tabController?.dispose();
  super.dispose();
  }
  @override
  Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: iconBool ? darkTheme : lightTheme,
    home: Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        centerTitle: true,
        title:  Text('News',
        style: TextStyle(
        color: iconBool ? Colors.white : Colors.black,
        fontSize: 33,
        ),
        ),
        actions: [
          IconButton(
            color:iconBool ? Colors.white : Colors.black,
            iconSize: 35,
            onPressed: (){
              setState(() {
                iconBool = !iconBool;
              });
            },

            icon: Icon(
                iconBool ? iconLight : iconDark,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
        bottom: PreferredSize(
        preferredSize: const Size.fromHeight(30.0),
        child: Container(
          color: iconBool ? Colors.white.withOpacity(0.8) : Colors.white,
          child: TabBar(
            indicatorColor: Colors.black,
            isScrollable: true,
            labelColor: Colors.black,
            controller: _tabController,
            tabs: _tabList,
            ),
        ),
        ),
      ),
    body: TabBarView(
      controller: _tabController,
      children:[
        //Popular Section
        ListView.builder(
        itemBuilder:(context, index) => Column(
          children: [
            Container(
              color: Colors.black12,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> WebViewScreen(articlePopularNews[index]['url'])
                      )
                  );
                },
                child: Image.network(
                  articlePopularNews[index]['urlToImage'].toString(),
                  errorBuilder: (context, error, stackTrace) {
                    return const Image(image: AssetImage('images/Image_not_available.png'));
                  },),
              ),
            ),
            ListTile(
              title: Text(articlePopularNews[index]['title']),
            ),
          ],
        ),
          itemCount: articlePopularNews.length,
        ),
        //Sports Section
        ListView.builder(
          itemBuilder:(context, index) => Column(
            children: [
              Container(
                color: Colors.black12,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> WebViewScreen(articleSportsNews[index]['url'])
                      )
                    );
                  },
                  child: Image.network(
                    articleSportsNews[index]['urlToImage'].toString(),
                    errorBuilder: (context, error, stackTrace) {
                      return const Image(image: AssetImage('images/Image_not_available.png'));
                    },),
                ),
              ),
              ListTile(
                title: Text(articleSportsNews[index]['title']),
              ),
            ],
          ),
          itemCount: articleSportsNews.length,
        ),
        //Business Section
        ListView.builder(
          itemBuilder:(context, index) => Column(
            children: [
              Container(
                color: Colors.black12,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=> WebViewScreen( articleBusinessNews[index]['url'])
                        )
                    );
                  },
                  child: Image.network(
                    articleBusinessNews[index]['urlToImage'].toString(),
                    errorBuilder: (context, error, stackTrace) {
                      return const Image(image: AssetImage('images/Image_not_available.png'));
                    },),
                ),
              ),
              ListTile(
                title: Text(articleBusinessNews[index]['title']),
              ),
            ],
          ),
          itemCount: articleBusinessNews.length,
        ),
        //Entertainment Section
        ListView.builder(
          itemBuilder:(context, index) => Column(
            children: [
              Container(
                color: Colors.black12,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=> WebViewScreen( articleEntertainmentNews[index]['url'])
                        )
                    );
                  },
                  child: Image.network(
                    articleEntertainmentNews[index]['urlToImage'].toString(),
                    errorBuilder: (context, error, stackTrace) {
                      return const Image(image: AssetImage('images/Image_not_available.png'));
                    },),
                ),
              ),
              ListTile(
                title: Text(articleEntertainmentNews[index]['title']),
              ),
            ],
          ),
          itemCount: articleEntertainmentNews.length,
        ),
        //Health Section
        ListView.builder(
          itemBuilder:(context, index) => Column(
            children: [
              Container(
                color: Colors.black12,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=> WebViewScreen( articleHealthNews[index]['url'])
                        )
                    );
                  },
                  child: Image.network(
                    articleHealthNews[index]['urlToImage'].toString(),
                    errorBuilder: (context, error, stackTrace) {
                      return const Image(image: AssetImage('images/Image_not_available.png'));
                    },),
                ),
              ),
              ListTile(
                title: Text(articleHealthNews[index]['title']),
              ),
            ],
          ),
          itemCount: articleHealthNews.length,
        ),
        //Science Section
        ListView.builder(
          itemBuilder:(context, index) => Column(
            children: [
              Container(
                color: Colors.black12,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=> WebViewScreen( articleScienceNews[index]['url'])
                        )
                    );
                  },
                  child: Image.network(
                    articleScienceNews[index]['urlToImage'].toString(),
                    errorBuilder: (context, error, stackTrace) {
                      return const Image(image: AssetImage('images/Image_not_available.png'));
                    },),
                ),
              ),
              ListTile(
                title: Text(articleScienceNews[index]['title']),
              ),
            ],
          ),
          itemCount: articleScienceNews.length,
        ),
        //Technology Section
        ListView.builder(
          itemBuilder:(context, index) => Column(
            children: [
              Container(
                color: Colors.black12,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=> WebViewScreen( articleTechnologyNews[index]['url'])
                        )
                    );
                  },
                  child: Image.network(
                    articleTechnologyNews[index]['urlToImage'].toString(),
                    errorBuilder: (context, error, stackTrace) {
                      return const Image(image: AssetImage('images/Image_not_available.png'));
                    },),
                ),
              ),
              ListTile(
                title: Text(articleTechnologyNews[index]['title']),
              ),
            ],
          ),
          itemCount: articleTechnologyNews.length,
        ),
        ],
    )
    ),
  );
  }
}
