import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
enum BACStatus {
  sober,
  mildImpairment,
  increasedImpairment,
  severeImpairment,
  lifeThreatening,
}

class _HomePageState extends State<HomePage> {
  double _bac = 0.0;
  BACStatus _bacStatus = BACStatus.sober;

  void _updateBAC(double newBAC) {
    setState(() {
      _bac = newBAC;
      if (_bac <= 0.0) {
        _bacStatus = BACStatus.sober;
      } else if (_bac > 0.0 && _bac <= 0.05) {
        _bacStatus = BACStatus.mildImpairment;
      } else if (_bac > 0.06 && _bac <= 0.15) {
        _bacStatus = BACStatus.increasedImpairment;
      } else if (_bac > 0.15 && _bac <= 0.3) {
        _bacStatus = BACStatus.severeImpairment;
      } else {
        _bacStatus = BACStatus.lifeThreatening;
      }
    });
  }

  void _incrementBAC() {
    setState(() {
      if (_bac < 1.0) {
        _bac += 0.01;
        _updateBAC(_bac);
      }
    });
  }

  void _decrementBAC() {
    setState(() {
      if (_bac > 0.0) {
        _bac -= 0.01;
        _updateBAC(_bac);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Color statusBoxColor;
    String bacStatusString;
    String bacInfoString;
    switch (_bacStatus) {
      case BACStatus.sober:
        statusBoxColor = Colors.lightGreen;
        bacStatusString = "Sober";
        bacInfoString = "You're sober with no alcohol in your system";
        break;
      case BACStatus.mildImpairment:
        statusBoxColor = Colors.yellow;
        bacStatusString = "Mild Impairment";
        bacInfoString = "You may feel relaxed, slightly lightheaded, and have a slower reaction time. This level of impairment can affect the ability to drive safely and make good decisions.";
        break;
      case BACStatus.increasedImpairment:
        statusBoxColor = Colors.orange;
        bacStatusString = "Increased Impairment";
        bacInfoString = "Legally intoxicated. A person may experience slurred speech, impaired balance, and a loss of coordination. They may also experience impaired judgment and a decreased ability to make good decisions.";
        break;
      case BACStatus.severeImpairment:
        statusBoxColor = Colors.orangeAccent;
        bacStatusString = "Severe Impairment";
        bacInfoString = "You may have difficulty walking, blurred vision, and may vomit. At this level, a person may have difficulty controlling their movements and may have a significantly impaired ability to make decisions. It is important to note that at this level, there is a high risk of blackouts and memory loss.";
        break;
      case BACStatus.lifeThreatening:
        statusBoxColor = Colors.red;
        bacStatusString = "Life-Threatening";
        bacInfoString = "At this level, a person may experience respiratory depression, which can lead to coma or death. They may also experience a loss of consciousness, and the ability to remain awake. It is important to note that a BAC of 0.40% or higher can be lethal for many people.";
        break;
    }
    Color statusTextColor = Colors.black;

    return Container(
      color: Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Blood Alcohol Level (BAC)',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 200.0,
                height: 200.0,
                child: CircularProgressIndicator(
                    value: _bac / 0.3,
                    strokeWidth: 10.0,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color.lerp(
                          Colors.green,
                          Colors.red,
                          _bac < 0.3 ? _bac*(1/0.3) : 1.0
                      ) ?? Colors.grey,
                    )
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _bac.toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    bacStatusString,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 32.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _decrementBAC,
                child: Text('-0.01'),
              ),
              SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: _incrementBAC,
                child: Text('+0.01'),
              ),
            ],
          ),
          Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 20),
                child: Text(
                    bacInfoString,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    )
                ),
              )),
          ElevatedButton(onPressed: null, child: Text('Connect Bluetooth')),
          ElevatedButton(onPressed: null, child: Text('Record Sensor Reading')),
        ],
      ),
    );
  }
}
