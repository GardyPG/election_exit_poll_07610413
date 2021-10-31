import 'package:election_exit_poll_07610413/model/candidate.dart';
import 'package:election_exit_poll_07610413/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  //static const routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),
                _showCandidate(),
                _buntonResult(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/vote_hand.png', width: 100.0),
        ),
        Text('EXIT POLL', style: Theme.of(context).textTheme.headline2),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text('เลือกตั้ง อบต.',
              style: Theme.of(context).textTheme.headline2),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                'รายชื่อผู้สมัครรับเลือกตั้ง',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                'นายกองค์การบริหารส่วนตำบลเขาพระ',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                'อำเภอเมืองนครนายก จังหวัดนครนายก',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _showCandidate() {
    return Container(
      child: FutureBuilder<List<Candidate>>(

        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            var candidateList = snapshot.data;
            return SizedBox(
              height: 350,
              child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                itemCount: candidateList!.length,
                itemBuilder: (BuildContext context, int index) {
                  var candidate = candidateList[index];
                  return Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: const EdgeInsets.all(8.0),
                    elevation: 0.0,
                    color: Colors.white70,
                    child: InkWell(
                      onTap: () {
                        _vote(candidate.number);
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            color: Colors.green,
                            child: Center(
                              child: Text(
                                '${candidate.number}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                                '${candidate.title}${candidate.name}'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buntonResult() {
    return ElevatedButton(
      onPressed: () {},
      child: Text('ดูผล'),
    );
  }

  void _showMaterialDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title,
              style: GoogleFonts.fredokaOne(
                fontSize: 20.0,
                color: Colors.black,
              )),
          content: Text(message,
              style:
                  GoogleFonts.righteous(fontSize: 15.0, color: Colors.black)),
          actions: [
            TextButton(
              child: Text('OK',
                  style: GoogleFonts.righteous(
                    fontSize: 18.0,
                    color: Colors.indigo,
                  )),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<List<Candidate>> _loadCandidate() async {
    List list = await Api().fetch('exit_poll');
    var candidatelist = list.map((item) => Candidate.fromJson(item)).toList();
    return candidatelist;
  }

  Future<dynamic> _vote(int n) async {
    var list = await Api().submit('exit_poll', {'candidateNumber': n}) as List;

    _showMaterialDialog('SUCCESS', 'บันทึกข้อมูลสำเร็จ${list}');
  }

}




