import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Age Calculator',
     
      
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{

  DateTime _selectedDate;
 
  Animation animation;
  Animation animation1;  
  Animation animation2;
  AnimationController animationController;


  @override
  void initState() {
    animationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 1500));
    animation = animationController;
    animation1=animationController;
    animation2=animationController;
    
    super.initState();
  }



  @override
  void dispose() {
    
    super.dispose();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return null;
      } else {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Age Calculator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlineButton(
              onPressed: () {
                _presentDatePicker();
              },
              borderSide: new BorderSide(color: Colors.black, width: 3.0),
              color: Colors.white,
              child:  _selectedDate == null
                  ? Text('Select Your Birth Date')
                  : Text('Selected Date:  ' +
                      DateFormat.yMMMMEEEEd().format(_selectedDate)),
             
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              child: Text('Calculate'),
              
              onPressed: _selectedDate == null? null: calculateAge,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).primaryTextTheme.button.color,
            ),
            
            SizedBox(
              height: 20,
            ),
            Text(
              "Your Age is",
              style: new TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic
              ),
            

            ),
            AnimatedBuilder(
              animation: animation,
              builder: (context, child) => new Text(
                "${animation.value.toStringAsFixed(0)} Years",
                style: new TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
            ),
            AnimatedBuilder(
              animation: animation1,
              builder: (context, child) => new Text(
                "${animation1.value.toStringAsFixed(0)} Months",
                style: new TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
            ),
            AnimatedBuilder(
              animation: animation2,
              builder: (context, child) => new Text(
                "${animation2.value.toStringAsFixed(0)} Days",
                style: new TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
            )

          ],
        ),
      ),
    );
  }


  void calculateAge() {
    setState(() {

      final cDate = DateTime.now();
      int day2=cDate.day, day1=_selectedDate.day, 
          mon2=cDate.month, mon1=_selectedDate.month, 
          year2=cDate.year, year1=_selectedDate.year;


      int day_diff = day2 - day1;
      if (day_diff<0) {
        //borrows day from last month
        //first calculate how much days you have in last month
        //obtain that no of days and add it to current
        //and after that cut one month from cDate
        if (mon2 == 3) {
          //this is March we need to borrow days from Feb 
          //first we need to check leap year
          //check whether year is a leap year
          if ((year2 % 4 == 0 && year2 % 100 != 0) ||
              (year2 % 400 == 0)) {
            day_diff += 29;
          } else {
            day_diff += 28;
          }
        }

        // borrow days from April or June or September or November
        else if (mon2 == 5 ||
            mon2 == 7 ||
            mon2 == 10 ||
            mon2 == 12) {
          day_diff += 30;
        }

        // borrow days from Jan or Mar or May or July or Aug or Oct or Dec

        else {
          day_diff+= 31;
        }

        mon2 = mon2 - 1;
      }

      int mon_diff = mon2 - mon1;
      if (mon_diff<0) {
        mon_diff += 12;
        year2 -= 1;
      }
      
      
      
      int year_diff = year2 - year1;

     
      
      animation = new Tween<double>(begin: 0.0, end: year_diff.toDouble()).animate(
          new CurvedAnimation(
              curve: Curves.fastOutSlowIn, parent: animationController));

      animation1 = new Tween<double>(begin: 0.0, end: mon_diff.toDouble()).animate(
          new CurvedAnimation(
              curve: Curves.fastOutSlowIn, parent: animationController));
      
      animation2 = new Tween<double>(begin: 0.0, end: day_diff.toDouble()).animate(
          new CurvedAnimation(
              curve: Curves.fastOutSlowIn, parent: animationController));
      

      animationController.forward(from: 0.0);
    });
  }

}
