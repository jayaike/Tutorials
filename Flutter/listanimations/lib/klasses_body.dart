import 'package:flutter/material.dart';
import 'package:listanimations/state/klass.dart';
import 'package:listanimations/state/klass_list.dart';
import 'package:listanimations/state/students.dart';
import 'package:provider/provider.dart';

class KlassesBody extends StatelessWidget {
  final Animation transformAnimation;
  final Animation opacityAnimation;

  KlassesBody({this.opacityAnimation, this.transformAnimation});

  @override
  Widget build(BuildContext context) {
    final KlassListState classes = Provider.of<KlassListState>(context);
    final KlassState selectedKlass = classes.selectedKlass;

    return Opacity(
      opacity: opacityAnimation.value,
      child: Container(
        transform: transformAnimation.value,
        child: ListView.builder(
          itemCount: selectedKlass.students.length,
          shrinkWrap: true,
          itemBuilder: (_, int i) => DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey)
              )
            ),
            child: StudentTile(student: selectedKlass.students[i],)
          )
        ),
      ),
    );
  }

}

class StudentTile extends StatelessWidget {
  final StudentState student;

  StudentTile({this.student});

  @override
  Widget build(BuildContext context) {

    return Material(
      type: MaterialType.transparency,
      child: Theme(
        data: Theme.of(context).copyWith(highlightColor: Colors.transparent),
        child: ListTile(
          onTap: () {},
          title: Text(student.name, style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.w700),),
          trailing: Icon(Icons.chevron_right),
        ),
      ),
    );
  }

}