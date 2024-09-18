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
  // Questions for each category
  // Map<String, List<String>> questionsWithOptions = {
  //   "Political Parties": [
  //     "Do you support the current structure of political parties?",
  //     "Do you believe political parties are representative of citizens’ interests?",
  //     "How would you rate the accountability of political parties?"
  //   ],
  //   "Parliament of the Republic of Ghana": [
  //     "Are you satisfied with the performance of Parliament?",
  //     "Do you feel Parliament is effectively representing your interests?",
  //     "What is your opinion on the level of transparency in Parliament?"
  //   ],
  //   "National Commission of Civic Education": [
  //     "Is the National Commission of Civic Education achieving its objectives?",
  //     "What is your opinion on the effectiveness of civic education programs?",
  //     "Should more resources be allocated to civic education?"
  //   ],
  //   "Youth Opinion Polls: Governance & Leadership Accountability": [
  //     "Do you believe youth have a strong voice in governance?",
  //     "Are leaders in Ghana accountable to the youth?",
  //     "How would you rate leadership transparency?"
  //   ],
  //   "Electoral Commission of Ghana": [
  //     "Do you trust the Electoral Commission to deliver free and fair elections?",
  //     "What improvements would you like to see in the election process?",
  //     "How do you perceive the transparency of election results?"
  //   ],
  //   "CSOs and Stakeholders Partnerships": [
  //     "Are Civil Society Organizations (CSOs) making an impact?",
  //     "Do you think the partnership between CSOs and the government is effective?",
  //     "Should more resources be allocated to CSO activities?"
  //   ],
  //   "Online Library": [
  //     "Do you find the online library resources helpful?",
  //     "Should the online library be expanded?",
  //     "How often do you use online resources for research?"
  //   ],
  //   "Online Training Centre": [
  //     "Are the training programs on the online training centre effective?",
  //     "Would you recommend these training programs to others?",
  //     "What improvements would you suggest for the online training centre?"
  //   ],
  //   "Upcoming Events": [
  //     "Are you aware of upcoming governance-related events?",
  //     "How likely are you to attend an upcoming event?",
  //     "What type of events would you like to see more of?"
  //   ],
  //   "Ghana Government": [
  //     "Are you satisfied with the current government's performance?",
  //     "Do you believe the government is transparent in its operations?",
  //     "How would you rate the government's response to public concerns?"
  //   ],
  // };
  // Map<String, List<List<String>>> optionsForQuestions = {
  //   "Political Parties": [
  //     ["Yes", "No", "Neutral"],
  //     ["Yes", "No", "Neutral"],
  //     ["Excellent", "Good", "Poor"]
  //   ],
  //   "Parliament of the Republic of Ghana": [
  //     ["Very Satisfied", "Satisfied", "Neutral", "Dissatisfied"],
  //     ["Yes", "No", "Sometimes"],
  //     ["High", "Medium", "Low"]
  //   ],
  //   "National Commission of Civic Education": [
  //     ["Yes", "No", "Neutral"],
  //     ["Effective", "Somewhat Effective", "Ineffective"],
  //     ["Yes", "No", "Maybe"]
  //   ],
  //   "Youth Opinion Polls: Governance & Leadership Accountability": [
  //     ["Yes", "No", "Neutral"],
  //     ["Yes", "No", "Maybe"],
  //     ["High", "Moderate", "Low"]
  //   ],
  //   "Electoral Commission of Ghana": [
  //     ["Yes", "No", "Neutral"],
  //     ["More Transparency", "Better Voter Education", "Improved Technology"],
  //     ["High", "Medium", "Low"]
  //   ],
  //   "CSOs and Stakeholders Partnerships": [
  //     ["Yes", "No", "Neutral"],
  //     ["Very Effective", "Effective", "Ineffective"],
  //     ["Yes", "No", "Maybe"]
  //   ],
  //   "Online Library": [
  //     ["Yes", "No", "Sometimes"],
  //     ["Yes", "No", "Maybe"],
  //     ["Daily", "Weekly", "Monthly", "Rarely"]
  //   ],
  //   "Online Training Centre": [
  //     ["Yes", "No", "Sometimes"],
  //     ["Yes", "No", "Maybe"],
  //     ["Better Content", "More Courses", "Improved Accessibility"]
  //   ],
  //   "Upcoming Events": [
  //     ["Yes", "No", "Not Sure"],
  //     ["Very Likely", "Somewhat Likely", "Unlikely"],
  //     ["Workshops", "Conferences", "Webinars"]
  //   ],
  //   "Ghana Government": [
  //     ["Very Satisfied", "Satisfied", "Neutral", "Dissatisfied"],
  //     ["Yes", "No", "Sometimes"],
  //     ["Excellent", "Good", "Average", "Poor"]
  //   ],
  // };
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
        if(value.auth==null){
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

  void _submitAnswers() {
    bool allQuestionsAnswered = true;
    for (int i = 0; i < widget.questions.length; i++) {
      if (selectedAnswers[i] == null) {
        allQuestionsAnswered = false;
        break;
      }
    }

    if (allQuestionsAnswered) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Submit Poll"),
          content: const Text("Are you sure you want to submit your answers?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showSubmissionConfirmation();
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      );
    } else {
      _showIncompleteFormDialog();
    }
  }
  void _showIncompleteFormDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Incomplete",style: TextStyle(fontSize: 12.0),),
        content: const Text("Please answer all the questions before submitting.",style: TextStyle(fontSize: 12.0),),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK",style: TextStyle(fontSize: 12.0),),
          ),
        ],
      ),
    );
  }
  void _showSubmissionConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Submitted",style: TextStyle(fontSize: 12.0),),
        content: const Text("Your answers have been successfully submitted.",style: TextStyle(fontSize: 12.0),),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text("OK",style: TextStyle(fontSize: 12.0),),
          ),
        ],
      ),
    );
  }

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
            Expanded(
              child: ListView.builder(
                itemCount: widget.questions.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${index + 1}. ${widget.questions[index]}",
                            style: const TextStyle(fontSize: 12.0),
                          ),
                          const SizedBox(height: 8.0),
                          ...widget.options[index].map(
                                (option) {
                              return RadioListTile<String>(
                                title: Text(option),
                                value: option,
                                groupValue: selectedAnswers[index],
                                onChanged: (value) {
                                  setState(() {
                                    selectedAnswers[index] = value;
                                  });
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _submitAnswers,
              child: const Text('Submit',style: TextStyle(fontSize: 12.0),),
            ),
          ],
        ),
      ),
    );
  }
}
