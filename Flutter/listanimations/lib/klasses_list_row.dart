import 'package:flutter/material.dart';
import 'package:listanimations/state/klass.dart';
import 'package:listanimations/state/klass_list.dart';
import 'package:listanimations/utilities/gradients.dart';
import 'package:provider/provider.dart';

class KlassesListRow extends StatelessWidget {
  final Function(int, KlassState) onTabTapped;
  final ScrollController scrollController;

  KlassesListRow({this.onTabTapped, this.scrollController});

  @override
  Widget build(BuildContext context) {
    final KlassListState klassListState = Provider.of<KlassListState>(context);
    final List<KlassState> klasses = klassListState.klasses;
    final colors = kGradients;

    return Container(
      height: 120.0,
      child: ListView.builder(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: klasses.length,
        itemBuilder: (_, int i) => Column(
          children: [
            Expanded(
              child: KlassItem(
                index: i,
                gradient: colors[i % colors.length],
                klass: klasses[i],
                onTabTapped: onTabTapped,
              ),
            ),
            Container(height: 10.0),
            Container(
              width: 120.0,
              height: 3.0,
              decoration: BoxDecoration(
                color: klassListState.selectedKlassId == klasses[i].id
                  ? Theme.of(context).indicatorColor
                  : Colors.transparent,
                borderRadius: BorderRadius.circular(20.0)
              ),
            )
          ],
        )
      )
    );
  }
}


class KlassItem extends StatelessWidget {
  final int index;
  final List<Color> gradient;
  final KlassState klass;
  final Function(int, KlassState) onTabTapped;

  KlassItem({Key key,this.index, this.gradient, this.klass, this.onTabTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradient),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () =>
            onTabTapped(index, klass),
          borderRadius: BorderRadius.circular(15),
          child: Row(
            children: [
              Flexible(
                flex: 5,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child: Container(),),
                      Text(
                        klass.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text("${klass.students.length} students", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),)
                    ],
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

}