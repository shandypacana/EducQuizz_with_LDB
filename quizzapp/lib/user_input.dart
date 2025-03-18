import 'package:flutter/material.dart';
import 'science_quiz.dart';
import 'math_quiz.dart';
import 'history_quiz.dart';

class UserInputScreen extends StatefulWidget {
  final String category;

  UserInputScreen({required this.category});

  @override
  _UserInputScreenState createState() => _UserInputScreenState();
}

class _UserInputScreenState extends State<UserInputScreen> {
  final _nameController = TextEditingController();
  String? _selectedImage;

  void _startQuiz() {
    if (_nameController.text.isNotEmpty && _selectedImage != null) {
      Widget quizScreen;
      switch (widget.category) {
        case 'Math':
          quizScreen = MathQuiz(
            userName: _nameController.text,
            profileImage: _selectedImage!,
          );
          break;
        case 'History':
          quizScreen = HistoryQuiz(
            userName: _nameController.text,
            profileImage: _selectedImage!,
          );
          break;
        case 'Science':
        default:
          quizScreen = ScienceQuiz(
            userName: _nameController.text,
            profileImage: _selectedImage!,
          );
          break;
      }

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => quizScreen,
        ),
      );
    } else {
      // Show an error message if name or image is not provided
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your name and select an image')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Your Details'),
        titleTextStyle: TextStyle(color: Colors.white,fontSize: 24),
        backgroundColor: Colors.purple,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.purple,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_selectedImage != null)
              Container(
                width: 400, // Set the width of the card
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(_selectedImage!),
                      backgroundColor: Colors.yellow,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.yellow,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _nameController.text,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Select an Image:',
                    style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildImageOption('assets/images/cat1.png'),
                      _buildImageOption('assets/images/cat2.png'),
                      _buildImageOption('assets/images/cat3.png'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 350,
              decoration: BoxDecoration(
                color: Colors.white, // Set background color to white
                border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: InputBorder.none,
                ),
                onChanged: (text) {
                  setState(() {});
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startQuiz,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Start Quiz'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageOption(String imagePath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedImage = imagePath;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: _selectedImage == imagePath ? const Color.fromARGB(255, 243, 243, 33) : Colors.transparent,
            width: 3,
          ),
        ),
        child: Image.asset(
          imagePath,
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}