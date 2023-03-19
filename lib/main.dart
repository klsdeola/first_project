import"package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import"dart:io";
import 'package:profanity_filter/profanity_filter.dart';



void main() {
  runApp(CodeTest());

}
class CodeTest extends StatefulWidget {
  const CodeTest({Key? key}) : super(key: key);

  @override
  State<CodeTest> createState() => _CodeTestState();
}

class _CodeTestState extends State<CodeTest> {
   late File _imageFile;


  Future<void> _getImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

   void _verifyContent() {

     if (_imageFile != null) {
       _checkImage();
     } else {
       print("no image found");
     }
   }


   Future<void> _checkImage() async {
     // TODO: Want to Implement image verification using a third-party service like Google's Vision API
   }


final _textController = TextEditingController();
final filter = ProfanityFilter();

String userText= "";
String dialogs ="";
String errorDailogs="Sorry your text contains a bad or profanity word it can't be displayed please check our privacy policy for more info";



  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Code Test"),
        ),
        body:
        Container(
          padding: EdgeInsets.all(60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              //display text
              Expanded
                (
                child: Container(
                  child: Center(
                    child:

                    Text(dialogs),
                  ),

                ),
              ),

              //text input
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: (){
                        //Clear textField
                        _textController.clear();
                      },
                      icon:Icon(Icons.clear) ,
                    ),
                    hintText: "type your message here",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap:(){
                  setState((){
                    userText = _textController.text;
                  badText(userText);
                   if(filter.hasProfanity(userText)== true){
                    dialogs =errorDailogs;



                   } else{
                     dialogs= userText;
                   };

                  });

                },

                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.send,
                  color: Colors.white,
                    size: 30,


                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Select Image'),
                onPressed: _getImage,
              ),
            ],
          ),
        ),
      ),
    );

  }
}

void badText(text){



    final filter = ProfanityFilter();

    //This string contains the profanity 'ass'
    String badString = text;

    //Check for profanity - returns a boolean (true if profanity is present)
    bool hasProfanity = filter.hasProfanity(badString);
    print('The string $badString has profanity: $hasProfanity');

    //Get the profanity used - returns a List<String>
    List<String> wordsFound = filter.getAllProfanity(badString);
    print('The string contains the words: $wordsFound');

    //Censor the string - returns a 'cleaned' string.
    String cleanString = filter.censor(badString);
    print('Censored version of "$badString" is "$cleanString"');


  }






