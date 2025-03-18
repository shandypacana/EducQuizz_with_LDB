import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'models/leaderboard_entry.dart';
import 'main.dart';

class MathQuiz extends StatefulWidget {
  final String userName;
  final String profileImage;

  MathQuiz({required this.userName, required this.profileImage});

  @override
  _MathQuizState createState() => _MathQuizState();
}

class _MathQuizState extends State<MathQuiz> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  int _timeLeft = 30;
  int _countdown = 3; // Countdown timer
  Timer? _timer;
  Timer? _countdownTimer; // Countdown timer
  AudioPlayer _audioPlayer = AudioPlayer();
  AudioCache _audioCache = AudioCache();
  AudioPlayer _backgroundMusicPlayer = AudioPlayer();
  bool _isMuted = false;

  List<Map<String, Object>> _questions = [
    {
      'question': 'What is 2 + 2?',
      'answers': ['3', '4', '5', '6'],
      'correctAnswer': '4'
    },
    {
      'question': 'What is the square root of 16?',
      'answers': ['2', '3', '4', '5'],
      'correctAnswer': '4'
    },
    {
      'question': 'What is 10 / 2?',
      'answers': ['2', '3', '4', '5'],
      'correctAnswer': '5'
    },
    {
      'question': 'What is 7 * 3?',
      'answers': ['21', '24', '27', '30'],
      'correctAnswer': '21'
    },
    {
      'question': 'What is 9 - 3?',
      'answers': ['3', '4', '5', '6'],
      'correctAnswer': '6'
    },
  ];

  @override
  void initState() {
    super.initState();
    _startCountdown();
    _playBackgroundMusic();
  }

  void _startCountdown() {
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _countdownTimer?.cancel();
          _startTimer();
        }
      });
    });
  }

  void _startTimer() {
    _timer?.cancel(); // Cancel any existing timer
    _timeLeft = 30;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _timer?.cancel();
          _answerQuestion(null);
        }
      });
    });
  }

  void _playBackgroundMusic() async {
    if (!_isMuted) {
      await _backgroundMusicPlayer.setReleaseMode(ReleaseMode.LOOP);
      await _backgroundMusicPlayer.play('backmus.mp3', isLocal: true);
    }
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      if (_isMuted) {
        _backgroundMusicPlayer.pause();
      } else {
        _playBackgroundMusic();
      }
    });
  }

  void _answerQuestion(String? answer) async {
    if (answer == _questions[_currentQuestionIndex]['correctAnswer']) {
      _score++;
      if (!_isMuted) {
        await _audioCache.play('correct.mp3');
      }
    } else {
      if (!_isMuted) {
        await _audioCache.play('wrong.mp3');
      }
    }

    setState(() {
      _currentQuestionIndex++;
    });

    if (_currentQuestionIndex >= _questions.length) {
      _timer?.cancel();
      _showResult();
    } else {
      _startTimer();
    }
  }

  void _showResult() async {
    final entry = LeaderboardEntry(
      userName: widget.userName,
      profileImage: widget.profileImage,
      score: _score,
      category: 'Math',
    );
    await saveLeaderboardEntry(entry);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          score: _score,
          userName: widget.userName,
          profileImage: widget.profileImage,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _countdownTimer?.cancel(); // Cancel countdown timer
    _audioPlayer.dispose();
    _backgroundMusicPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Math Quiz'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white, // Set text and icon color to white
        actions: [
          IconButton(
            icon: Icon(_isMuted ? Icons.volume_off : Icons.volume_up),
            onPressed: _toggleMute,
          ),
        ],
      ),
      backgroundColor: Colors.purple,
      body: Center(
        child: _countdown > 0
            ? Text(
                '$_countdown',
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
              )
            : Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _currentQuestionIndex < _questions.length
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 10,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        CircularProgressIndicator(
                                          value: _timeLeft / 30,
                                          strokeWidth: 6.0,
                                          backgroundColor: Colors.grey[300],
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                                        ),
                                        Text(
                                          '$_timeLeft',
                                          style: TextStyle(fontSize: 20, color: Colors.red),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 40),
                                    Text(
                                      _questions[_currentQuestionIndex]['question'] as String,
                                      style: TextStyle(fontSize: 24, color: Colors.black),
                                    ),
                                    SizedBox(height: 40),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              ...(_questions[_currentQuestionIndex]['answers'] as List<String>)
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                int idx = entry.key;
                                String answer = entry.value;
                                Color buttonColor;
                                switch (idx) {
                                  case 0:
                                    buttonColor = Colors.red;
                                    break;
                                  case 1:
                                    buttonColor = Colors.blue;
                                    break;
                                  case 2:
                                    buttonColor = Colors.yellow;
                                    break;
                                  case 3:
                                    buttonColor = Colors.green;
                                    break;
                                  default:
                                    buttonColor = Colors.grey;
                                }
                                return Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () => _answerQuestion(answer),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: buttonColor,
                                        minimumSize: Size(250, 50), // Square button
                                      ),
                                      child: Text(answer, style: TextStyle(color: Colors.white)),
                                    ),
                                    SizedBox(height: 10), // Add space between buttons
                                  ],
                                );
                              }).toList(),
                            ],
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                  ],
                ),
              ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final int score;
  final String userName;
  final String profileImage;

  ResultScreen({required this.score, required this.userName, required this.profileImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white, // Set text and icon color to white
      ),
      backgroundColor: Colors.purple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(profileImage),
            ),
            SizedBox(height: 20),
            Text(
              'Congratulations, $userName!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Your Score: $score',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LeaderboardPage(category: 'Math'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 208, 0),
                minimumSize: Size(200, 50),
              ),
              child: Text('Go to Leaderboard', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}