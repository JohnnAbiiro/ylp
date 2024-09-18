import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ylp/provider/controller.dart';
import '../provider/routes.dart';
import '../shimmer.dart';
import 'constants.dart';
import 'header.dart';
import 'containerconstants.dart';
class Poll extends StatefulWidget {
  const Poll({super.key});

  @override
  _PollState createState() => _PollState();
}

class _PollState extends State<Poll> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = 400.0;
    int crossAxisCount=0;
    if (screenWidth <= 400) {
      crossAxisCount = 2;
    }
    else if (screenWidth <= 600 && screenWidth<800) {
      crossAxisCount = (screenWidth/200).floor();
    }
    else if(screenWidth >=600 && screenWidth<1000)
    {
      crossAxisCount = (screenWidth/200).floor();
    }
    else
    {
      crossAxisCount = (screenWidth / itemWidth).floor();
    }
    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider value, Widget? child) {
        if(value.auth.currentUser==null){
          value.logout(context);
        }
        return Scaffold(
          // appBar: AppBar(
          //   title: Text(Constants.title),
          //   centerTitle: true,
          // ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: value.articles_category(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.hasError){
                  //return const Center(child: Text("Error!!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),));
                  return ShimmerDurationExample();
                }
                if(snapshot.connectionState==ConnectionState.waiting){
                  return  ShimmerDurationExample();

                  //return const Center(child: Text("Please wait",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),));
                }
                if(!snapshot.hasData){
                  return ShimmerDurationExample();
                  //return const Center(child: Text("Waiting for data!!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),));
                }
                return GridView.builder(
                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount, // Number of items per row
                    crossAxisSpacing: 10.0, // Space between items horizontally
                    mainAxisSpacing: 10.0, // Space between items vertically
                  ),
                  itemCount: snapshot.data.length, // Number of grid items
                  itemBuilder: (context, index) {
                      String shortname=snapshot.data[index]['shortName']??"No Shortname";
                      String id=snapshot.data[index]['id']??"No ID";
                      return InkWell(
                        onTap: (){
                          value.setarticle(id, shortname);
                          value.getarticle();
                          Navigator.pushNamed(context, Routes.article_category);
                          //print(id);
                        },
                          child: buildCategoryRow(context, shortname)
                      );
                  },
                );
                //   ListView(
                //   children: Items
                //   // [
                //   //   headerMenu("Poll","Service \n Request", context),
                //   //   buildCategoryRow(context, "Political Parties", "Parliament"),
                //   //   buildCategoryRow(context, "NCC", "Youth Opinion Polls"),
                //   //   buildCategoryRow(context, "Electoral Commission ", "CSOs and Stakeholders"),
                //   //   buildCategoryRow(context, "Online Library", "Online Training Centre"),
                //   //   buildCategoryRow(context, "Upcoming Events", "Ghana Government"),
                //   // ],
                // );
              },
            ),
          ),
        );
      },
    );
  }


     Widget buildCategoryRow(BuildContext context, String title1) {
    return  buildMenuContainer(context, title1, Icons.account_balance);
  }

     buildMenuContainer(BuildContext context, String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      color: ContainerConstants.pollOptionsContainer,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         const  SizedBox(height: 40.0),
          Icon(icon, size: 40.0, color: Colors.white),
         const  SizedBox(height: 10.0),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 12.0, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 5.0),
        ],
      ),
    );
  }
}

class PollPage extends StatefulWidget {
  final String category;
  final List<String> questions;
  final List<List<String>> options;
  const PollPage({super.key, required this.category, required this.questions, required this.options});

  @override
  _PollPageState createState() => _PollPageState();
}

class _PollPageState extends State<PollPage> {
  Map<int, String?> selectedAnswers = {};

  // void _submitAnswers() {
  //   bool allQuestionsAnswered = true;
  //   for (int i = 0; i < widget.questions.length; i++) {
  //     if (selectedAnswers[i] == null) {
  //       allQuestionsAnswered = false;
  //       break;
  //     }
  //   }
  //
  //   // if (allQuestionsAnswered) {
  //   //   showDialog(
  //   //     context: context,
  //   //     builder: (context) => AlertDialog(
  //   //       title: const Text("Submit Poll"),
  //   //       content: const Text("Are you sure you want to submit your answers?"),
  //   //       actions: [
  //   //         TextButton(
  //   //           onPressed: () {
  //   //             Navigator.of(context).pop();
  //   //           },
  //   //           child: const Text("Cancel"),
  //   //         ),
  //   //         TextButton(
  //   //           onPressed: () {
  //   //             Navigator.of(context).pop();
  //   //             _showSubmissionConfirmation();
  //   //           },
  //   //           child: const Text("Submit"),
  //   //         ),
  //   //       ],
  //   //     ),
  //   //   );
  //   // } else {
  //   //   _showIncompleteFormDialog();
  //   // }
  // }
  // void _showIncompleteFormDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text("Incomplete",style: TextStyle(fontSize: 12.0),),
  //       content: const Text("Please answer all the questions before submitting.",style: TextStyle(fontSize: 12.0),),
  //       actions: [
  //         TextButton(
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //           child: const Text("OK",style: TextStyle(fontSize: 12.0),),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  // void _showSubmissionConfirmation() {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text("Submitted",style: TextStyle(fontSize: 12.0),),
  //       content: const Text("Your answers have been successfully submitted.",style: TextStyle(fontSize: 12.0),),
  //       actions: [
  //         TextButton(
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //             Navigator.of(context).pop();
  //           },
  //           child: const Text("OK",style: TextStyle(fontSize: 12.0),),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} Poll Questions'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: widget.questions.length,
            //     itemBuilder: (context, index) {
            //       return Card(
            //         child: Padding(
            //           padding: const EdgeInsets.all(12.0),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text(
            //                 "${index + 1}. ${widget.questions[index]}",
            //                 style: const TextStyle(fontSize: 12.0),
            //               ),
            //               const SizedBox(height: 8.0),
            //               ...widget.options[index].map(
            //                     (option) {
            //                   return RadioListTile<String>(
            //                     title: Text(option),
            //                     value: option,
            //                     groupValue: selectedAnswers[index],
            //                     onChanged: (value) {
            //                       setState(() {
            //                         selectedAnswers[index] = value;
            //                       });
            //                     },
            //                   );
            //                 },
            //               ),
            //             ],
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
            // ElevatedButton(
            //   onPressed: _submitAnswers,
            //   child: const Text('Submit',style: TextStyle(fontSize: 12.0),),
            // ),
          ],
        ),
      ),
    );
  }
}
