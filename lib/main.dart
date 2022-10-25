import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late List<charts.Series<Task, String>> _seriesPieData;
  late List<charts.Series<Employee, String>> _seriesBarData;

  _generateData() {

    var emp1 = [
      Employee('2010', 'Shyamoli', 100),
      Employee('2010', 'Banani', 86)
    ];
    var emp2 = [
      Employee('2015', 'Shyamoli', 230),
      Employee('2015', 'Banani', 112)
    ];
    var emp3 = [
      Employee('2020', 'Shyamoli', 286),
      Employee('2020', 'Banani', 167)
    ];

    var pieData = [
      Task('bKash AML', 23.3, Colors.redAccent),
      Task('bKash SiS', 13.3, Colors.green),
      Task('TrainingPro', 23.3, Colors.purple),
      Task('Tracks', 43.3, Colors.blueAccent),
      Task('HRM - KPI', 23.3, Colors.brown),
    ];

    _seriesPieData.add(
      charts.Series(
          data: pieData,
          domainFn: (Task task, _) => task.task,
          measureFn: (Task task, _) => task.taskValue,
          colorFn: (Task task, _) =>
              charts.ColorUtil.fromDartColor(task.colorVal),
          id: 'Daily Task',
          labelAccessorFn: (Task row,_)=>'${row.taskValue}%',
      ),
    );

    _seriesBarData.add(
      charts.Series(
        domainFn: (Employee employee, _) => employee.branch,
        measureFn: (Employee employee, _) => employee.employeeCount,
        id: '2010',
        data: emp1,
        labelAccessorFn: (Employee employee, _) => 'Year ${employee.year}',
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Employee employee, _) =>
            charts.ColorUtil.fromDartColor(Colors.redAccent)
      ),
    );

    _seriesBarData.add(
      charts.Series(
          domainFn: (Employee employee, _) => employee.branch,
          measureFn: (Employee employee, _) => employee.employeeCount,
          id: '2015',
          data: emp2,
          labelAccessorFn: (Employee employee, _) => 'Year ${employee.year}',
          fillPatternFn: (_, __) => charts.FillPatternType.solid,
          fillColorFn: (Employee employee, _) =>
              charts.ColorUtil.fromDartColor(Colors.redAccent)
      ),
    );

    _seriesBarData.add(
      charts.Series(
          domainFn: (Employee employee, _) => employee.branch,
          measureFn: (Employee employee, _) => employee.employeeCount,
          id: '2020',
          data: emp3,
          labelAccessorFn: (Employee employee, _) => 'Year ${employee.year}',
          fillPatternFn: (_, __) => charts.FillPatternType.solid,
          fillColorFn: (Employee employee, _) =>
              charts.ColorUtil.fromDartColor(Colors.redAccent)
      ),
    );

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesPieData = <charts.Series<Task, String>>[];
    _seriesBarData = <charts.Series<Employee, String>>[];
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(

        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Todays Task: Demo Chart'),
            backgroundColor: Colors.blueAccent,
            bottom: const TabBar(
              indicatorColor: Colors.blueAccent,
              tabs: [
                Tab(
                  icon: Icon(Icons.pie_chart),
                  text: 'Pie Chart',
                ),
                Tab(
                  icon: Icon(Icons.bar_chart),
                  text: 'Bar Chart',
                ),
                Tab(
                  icon: Icon(Icons.book),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      const Text(
                        'Project Investments',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 10.0,),
                      Expanded(
                          child: charts.PieChart<String>(
                            _seriesPieData,
                            animate: true,
                            animationDuration: const Duration(seconds: 1),
                            behaviors: [
                              charts.DatumLegend(
                                outsideJustification: charts.OutsideJustification.endDrawArea,
                                horizontalFirst: false,
                                desiredMaxRows: 2,
                                cellPadding: const EdgeInsets.only(right: 4.0, bottom: 4.0),
                                entryTextStyle: charts.TextStyleSpec(
                                  color: charts.MaterialPalette.purple.shadeDefault,
                                  fontFamily: 'Arial',
                                  fontSize: 11
                                )
                              )
                            ],
                            defaultRenderer: charts.ArcRendererConfig(
                              arcWidth: 100,
                              arcRendererDecorators: [
                                charts.ArcLabelDecorator(
                                  labelPosition: charts.ArcLabelPosition.inside
                                )
                              ]
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  const Text(
                    'DataSoft Employee Count',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  Expanded(
                      child: charts.BarChart(
                        _seriesBarData,
                        animate: true,
                        // vertical: false,
                        barGroupingType: charts.BarGroupingType.grouped,
                        animationDuration: const Duration(seconds: 1),
                        barRendererDecorator: charts.BarLabelDecorator<String>(),
                        // domainAxis:
                        // charts.OrdinalAxisSpec(renderSpec: const charts.NoneRenderSpec()),

                      )
                  ),
                ],
              ),
            ),
          ),
              Padding(padding: const EdgeInsets.all(8.0),),
            ],
          ),
        ),
      ),
    );
  }
}


class Task {
  String task;
  double taskValue;
  Color colorVal;

  Task(this.task, this.taskValue, this.colorVal);
}

class Employee {
  final String year;
  final String branch;
  final int employeeCount;

  Employee(this.year, this.branch, this.employeeCount);
}