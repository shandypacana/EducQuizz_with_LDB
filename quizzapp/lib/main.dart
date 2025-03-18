import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_input.dart';
import 'models/leaderboard_entry.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: Container(
        color: Colors.purple,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                width: 400,
                height: 300,
              ),
              SizedBox(height: 240),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CategorySelectionPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 200, 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                    side: BorderSide(color: const Color.fromARGB(255, 21, 21, 21), width: 3),
                  ),
                  minimumSize: Size(200, 60),
                ),
                child: Text(
                  'Start Quiz!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(1.5, 1.5),
                        color: Colors.black,
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.facebook, color: Colors.white, size: 40),
                    onPressed: () {
                      // Add your Facebook link here
                    },
                  ),
                  SizedBox(width: 50),
                  IconButton(
                    icon: Icon(Icons.camera_alt, color: Colors.white, size: 40),
                    onPressed: () {
                      // Add your Instagram link here
                    },
                  ),
                  SizedBox(width: 50),
                  IconButton(
                    icon: Icon(Icons.alternate_email, color: Colors.white, size: 40),
                    onPressed: () {
                      // Add your Twitter link here
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CategorySelectionPage extends StatelessWidget {
  final Key? key;

  CategorySelectionPage({this.key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Select Category'),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 24),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.purple,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserInputScreen(category: 'Science')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                child: Stack(
                  children: [
                    Ink(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/sci.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        width: 500,
                        height: 150,
                        alignment: Alignment.center,
                        child: Text(
                          'Science Quiz',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                offset: Offset(1.5, 1.5),
                                color: Colors.black,
                                blurRadius: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: IconButton(
                        icon: Icon(Icons.emoji_events, color: Colors.yellow, size: 50),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LeaderboardPage(category: 'Science')),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserInputScreen(category: 'Math')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                child: Stack(
                  children: [
                    Ink(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/histo.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        width: 500,
                        height: 150,
                        alignment: Alignment.center,
                        child: Text(
                          'Math Quiz',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                offset: Offset(1.5, 1.5),
                                color: Colors.black,
                                blurRadius: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: IconButton(
                        icon: Icon(Icons.emoji_events, color: Colors.yellow, size: 50),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LeaderboardPage(category: 'Math')),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserInputScreen(category: 'History')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                child: Stack(
                  children: [
                    Ink(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/histo1.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        width: 500,
                        height: 150,
                        alignment: Alignment.center,
                        child: Text(
                          'History Quiz',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                offset: Offset(1.5, 1.5),
                                color: Colors.black,
                                blurRadius: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: IconButton(
                        icon: Icon(Icons.emoji_events, color: Colors.yellow, size: 50),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LeaderboardPage(category: 'History')),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LeaderboardPage extends StatelessWidget {
  final String? category;

  LeaderboardPage({this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(category != null ? '$category Leaderboard' : 'Leaderboard'),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.purple,
        child: FutureBuilder<List<LeaderboardEntry>>(
          future: getLeaderboardEntries(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error loading leaderboard'));
            } else {
              final entries = snapshot.data ?? [];
              final filteredEntries = category != null
                  ? entries.where((entry) => entry.category == category).toList()
                  : entries;

              filteredEntries.sort((a, b) => b.score.compareTo(a.score));

              return Center(
                child: Card(
                  color: Colors.white,
                  margin: EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 700, // Set the height of the card
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredEntries.length,
                        itemBuilder: (context, index) {
                          final entry = filteredEntries[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: AssetImage(entry.profileImage),
                              radius: 30,
                              backgroundColor: Colors.yellow,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.yellow,
                                    width: 3,
                                  ),
                                ),
                              ),
                            ),
                            title: Row(
                              children: [
                                Text('${index + 1}. ${entry.userName}'),
                                SizedBox(width: 300),
                                Text('Score: '),
                                SizedBox(width: 10),
                                Text('${entry.score}'),
                              ],
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

// Save leaderboard entry
Future<void> saveLeaderboardEntry(LeaderboardEntry entry) async {
  final prefs = await SharedPreferences.getInstance();
  final List<String> leaderboard = prefs.getStringList('leaderboard') ?? [];
  leaderboard.add(jsonEncode(entry.toJson()));
  await prefs.setStringList('leaderboard', leaderboard);
}

// Get leaderboard entries
Future<List<LeaderboardEntry>> getLeaderboardEntries() async {
  final prefs = await SharedPreferences.getInstance();
  final List<String> leaderboard = prefs.getStringList('leaderboard') ?? [];
  return leaderboard.map((e) => LeaderboardEntry.fromJson(jsonDecode(e))).toList();
}
