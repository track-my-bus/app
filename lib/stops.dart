import 'package:flutter/material.dart';

import 'data/data.dart';
import 'data/stops_model/stops_model.dart';

class Stops extends StatefulWidget {
  const Stops({super.key});

  @override
  State<Stops> createState() => _StopsState();
}

final List<StopsModel> _Stops = [];

class _StopsState extends State<Stops> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final data = await getDB().getStopsData();

      _Stops.clear();
      _Stops.addAll(data);
      setState(() {
        _Stops.addAll(data);
      });
    });

    return Scaffold(
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          title: const Text('Available Stops'),
          leading: IconButton(
            icon:
                Image.asset('lib/asset/icon.png', alignment: Alignment.center),
            onPressed: () {},
          ),
          backgroundColor: Colors.blue[400],
        ),
        body: Container(
            height: 600,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  alignment: Alignment.center,
                  image: const AssetImage("lib/asset/icon.png"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.1), BlendMode.dstATop)),
            ),
            margin: const EdgeInsets.all(2),
            child: GridView.count(
              mainAxisSpacing: 5,
              crossAxisCount: 1,
              childAspectRatio: 8,
              children: List.generate(
                _Stops.length ~/ 2,
                (index) {
                  final name = _Stops[index];
                  return SizedBox(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("BusPage",
                            arguments: _Stops[index].busses);
                      },

                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.elliptical(7, 2)),
                                      side: BorderSide(
                                          color: Colors.black54, width: 0.4)))),
                      // style: TextButton.styleFrom(
                      //   shape:MaterialStateProperty,
                      //   side: const BorderSide(
                      //       style: BorderStyle.solid,
                      //       width: 0.2,
                      //       strokeAlign: StrokeAlign.outside),
                      // ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(name.stopName!,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 17)),
                      ),
                    ),
                  );
                },
              ),
            )));
  }
}
