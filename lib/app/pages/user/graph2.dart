import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:github_stats/model/graphModal.dart';

// ignore: must_be_immutable
class Graph2 extends StatelessWidget {
  List<GraphRepo> data;
  Map<String, int> forks = new Map<String, int>();

  Graph2({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    data.forEach((element) {
      if (element.forksCount > 0) {
        forks[element.name] = element.forksCount;
      }
    });
    print(forks);
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: charts.BarChart(
              _createSampleData2(),
              vertical: false,
              animate: true,
              animationDuration: Duration(seconds: 1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              child: Text("Forks"),
              alignment: Alignment.topCenter,
            ),
          ),
        ],
      ),
    );
  }

  List<charts.Series<Forks, String>> _createSampleData2() {
    var graphData = List<Forks>();

    forks.forEach((key, value) {
      if (key.toString().length < 10){
        graphData.add(new Forks(key.toString(), value));
      } else {
        graphData.add(new Forks(key.toString().substring(0, 10) + "...", value));
      }
    });

    return [
      new charts.Series<Forks, String>(
        id: 'Forks',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Forks forks, _) => forks.name,
        measureFn: (Forks forks, _) => forks.count,
        data: graphData,
      )
    ];
  }
}

class Forks {
  final String name;
  final int count;

  Forks(this.name, this.count);
}
