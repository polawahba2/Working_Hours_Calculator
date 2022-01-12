import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:work_time_calculator/Compounent/Constants.dart';
import 'package:work_time_calculator/Cubit/Cubit.dart';
import 'package:work_time_calculator/Cubit/States.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, states>(
      listener: (context, state) {},
      builder: (context, state) {
        var size = MediaQuery.of(context).size;
        var times = AppCubit.getCubit(context).times;
        return BuildCondition(
          condition: times.isNotEmpty,
          builder: (context) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Builder(builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 3.0,
                          right: 2.0,
                          top: 2.0,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Num',
                                  style: titleStyle(),
                                ),
                                flex: 1,
                              ),
                              Expanded(
                                child: Text(
                                  'From',
                                  style: titleStyle(),
                                ),
                                flex: 1,
                              ),
                              Expanded(
                                child: Text(
                                  'To',
                                  style: titleStyle(),
                                ),
                                flex: 1,
                              ),
                              Expanded(
                                child: Text(
                                  '   Date',
                                  style: titleStyle(),
                                ),
                                flex: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return buildItem(size, index, context);
                        },
                        separatorBuilder: (context, index) => Container(
                          height: 1,
                          // color: Colors.blue[200],
                        ),
                        itemCount: times.length,
                      ),
                    ],
                  ),
                );
              }),
            );
          },
          fallback: (context) => Center(
            child: Text(
              'There Is No Data Yet !! ',
              style: mainStyle(),
            ),
          ),
        );
      },
    );
  }
}
//how to sho

Widget buildItem(var size, var index, context) {
  var times = AppCubit.getCubit(context).times;
  return Dismissible(
    onDismissed: (direction) {
      AppCubit.getCubit(context).deleteFromDataBase(times[index]['id']);
    },
    key: UniqueKey(),
    child: InkWell(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 14.0,
          right: 5.0,
        ),
        child: SizedBox(
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(index.toString()),
                Text('${times[index][startTime]}'),
                Text('${times[index][endTime]}'),
                Text('${times[index][date]}'),
              ],
            ),
          ),
        ),
      ),
      onTap: () {},
      onLongPress: () {},
      splashColor: Colors.blue[700],
    ),
  );
}
