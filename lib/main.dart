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
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _selectedDate;

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
            FlatButton.icon(
              onPressed: () {
                _presentDatePicker();
              },
              label: _selectedDate == null
                  ? Text('Select Your Birth Date')
                  : Text('Selected Date:  ' +
                      DateFormat.yMMMMEEEEd().format(_selectedDate)),
              icon: Icon(Icons.calendar_today),
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              onPressed: _selectedDate == null
                  ? null
                  : () {
                      final cDate = DateTime.now();

                      

                      int day2=cDate.day, day1=_selectedDate.day, 
                          mon2=cDate.month, mon1=_selectedDate.month, 
                          year2=cDate.year, year1=_selectedDate.year;

                      if (day2 < day1) {
                        // borrow days from february
                        if (mon2 == 3) {
                          //  check whether year is a leap year
                          if ((year2 % 4 == 0 && year2 % 100 != 0) ||
                              (year2 % 400 == 0)) {
                            day2 += 29;
                          } else {
                            day2 += 28;
                          }
                        }

                        // borrow days from April or June or September or November
                        else if (mon2 == 5 ||
                            mon2 == 7 ||
                            mon2 == 10 ||
                            mon2 == 12) {
                          day2 += 30;
                        }

                        // borrow days from Jan or Mar or May or July or Aug or Oct or Dec
                        else {
                          day2 += 31;
                        }

                        mon2 = mon2 - 1;
                      }

                      if (mon2 < mon1) {
                        mon2 += 12;
                        year2 -= 1;
                      }

                      int day_diff = day2 - day1;
                      int mon_diff = mon2 - mon1;
                      int year_diff = year2 - year1;

                      print(day_diff);
                      print(mon_diff);
                      print(year_diff);
                    },
              child: Text('Calculate'),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Your Age is 20',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
