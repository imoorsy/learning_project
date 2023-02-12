import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:todoapp/modules/news_app/news_page/news_screen.dart';
import 'package:todoapp/modules/zekr_app//zekr_screen/cubit/cubit.dart';
import 'package:todoapp/shared/cubit/cubit.dart';
import 'package:todoapp/shared/cubit/states.dart';

Widget defaultTextFormField(
  context, {
  required TextEditingController controller,
  required TextInputType keyboardtype,
  ValueChanged<String>? submitFunction,
  required FormFieldValidator validator,
  required IconData prefix,
  required String labelText,
  bool isPassword = false,
  IconData? suflix,
  ValueChanged<String>? onchange,
  VoidCallback? suflixpressed,
  VoidCallback? onTap,
  String? value,
  bool autofocus = false,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboardtype,
      autofocus: autofocus,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
        prefixIcon: Icon(prefix),
        suffixIcon: suflix != null
            ? IconButton(icon: Icon(suflix), onPressed: suflixpressed)
            : null,
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber, width: 5)),
      ),
      obscureText: isPassword,
      onFieldSubmitted: submitFunction,
      onChanged: onchange,
      onTap: onTap,
      validator: validator,
      style: Theme.of(context).textTheme.headline1,
    );

Widget defultButton({
  double width = double.infinity,
  double height = 50,
  Color background = Colors.amber,
  double borderRadius = 5.0,
  required Function() pressfunction,
  required String text,
}) =>
    Container(
      width: width,
      height: height,
      child: MaterialButton(
          onPressed: pressfunction,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: background,
      ),
    );

Widget defaultSearchFormField(
  context, {
  required TextEditingController controller,
  required TextInputType keyboardtype,
  ValueChanged<String>? submitFunction,
  required FormFieldValidator validator,
  required IconData prefix,
  required String labelText,
  bool isPassword = false,
  IconData? suflix,
  ValueChanged<String>? onchange,
  VoidCallback? suflixpressed,
  VoidCallback? onTap,
  String value = '',
}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboardtype,
      autocorrect: true,
      decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(prefix),
          suffixIcon: suflix != null
              ? IconButton(icon: Icon(suflix), onPressed: suflixpressed)
              : null,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 3),
            borderRadius: BorderRadius.circular(20),
          ),
          labelStyle: Theme.of(context).textTheme.headline1,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 3),
            borderRadius: BorderRadius.circular(20),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 3),
            borderRadius: BorderRadius.circular(20),
          ),
          errorStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      obscureText: isPassword,
      onFieldSubmitted: submitFunction,
      onChanged: onchange,
      onTap: onTap,
      validator: validator,
      style: Theme.of(context).textTheme.headline1,
    );

Widget buildNewTaskItem(Map model, BuildContext context) {
  AppCubit cubit = AppCubit.get(context);
  var time = DateTime.now();
  return Dismissible(
    key: Key(model['id'].toString()),
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'done', id: model['id']);
                print(model);
              },
              icon: Icon(
                Icons.circle_outlined,
                color: Colors.grey,
                size: 30,
              )),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${model['title'].toString()}',
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // SizedBox(height: 5,),
                // BuildCondition(
                //   condition: model['time'] != DateFormat('jm').format(time),
                //   builder: (context) => Text(
                //     '${model['time'].toString()}',
                //     textAlign: TextAlign.start,
                //     style: const TextStyle(
                //       fontSize: 16,
                //       color: Colors.grey,
                //     ),
                //   ),
                //   fallback: (context) => const Text(
                //     'now',
                //     textAlign: TextAlign.start,
                //     style: TextStyle(
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.grey,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'archived', id: model['id']);
                print(model);
              },
              icon: const Icon(
                Icons.archive_outlined,
                color: Colors.grey,
              )),
        ],
      ),
    ),
    onDismissed: (direction) {
      cubit.deleteData(id: model['id']);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.blue,
          content: Text('Deleted ${model['title']}'),
          duration: Duration(milliseconds: 3000),
        ),
      );
    },
  );
}

Widget buildDoneTaskItem(Map model, BuildContext context) {
  AppCubit cubit = AppCubit.get(context);
  var time = DateTime.now();
  return Dismissible(
    key: Key(model['id'].toString()),
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'new', id: model['id']);
                print(model);
              },
              icon: Icon(
                Icons.check_circle_sharp,
                color: Colors.blue,
                size: 30,
              )),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${model['title'].toString()}',
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // SizedBox(height: 5,),
                // BuildCondition(
                //   condition: model['time'] != DateFormat('jm').format(time),
                //   builder: (context) => Text(
                //     '${model['time'].toString()}',
                //     textAlign: TextAlign.start,
                //     style: const TextStyle(
                //       fontSize: 16,
                //       color: Colors.grey,
                //     ),
                //   ),
                //   fallback: (context) => const Text(
                //     'now',
                //     textAlign: TextAlign.start,
                //     style: TextStyle(
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.grey,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'archived', id: model['id']);
                print(model);
              },
              icon: const Icon(
                Icons.archive_outlined,
                color: Colors.grey,
              )),
        ],
      ),
    ),
    onDismissed: (direction) {
      cubit.deleteData(id: model['id']);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Deleted ${model['title']}'),
          duration: Duration(milliseconds: 3000),
        ),
      );
    },
  );
}

Widget buildArchivedTaskItem(Map model, BuildContext context) {
  AppCubit cubit = AppCubit.get(context);
  var time = DateTime.now();
  return Dismissible(
    key: Key(model['id'].toString()),
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'new', id: model['id']);
                print(model);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.blue,
                size: 30,
              )),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${model['title'].toString()}',
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // SizedBox(height: 5,),
                // BuildCondition(
                //   condition: model['time'] != DateFormat('jm').format(time),
                //   builder: (context) => Text(
                //     '${model['time'].toString()}',
                //     textAlign: TextAlign.start,
                //     style: const TextStyle(
                //       fontSize: 16,
                //       color: Colors.grey,
                //     ),
                //   ),
                //   fallback: (context) => const Text(
                //     'now',
                //     textAlign: TextAlign.start,
                //     style: TextStyle(
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.grey,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    ),
    onDismissed: (direction) {
      cubit.deleteData(id: model['id']);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Deleted ${model['title']}'),
          duration: Duration(milliseconds: 3000),
        ),
      );
    },
  );
}

Widget buildNewsAppItem(Map model, BuildContext context) => TextButton(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: model['urlToImage'] ??
                  'https://upload.wikimedia.org/wikipedia/commons/d/d1/Image_not_available.png',
              imageBuilder: (context, imageProvider) => Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high),
                ),
              ),
              placeholder: (context, url) => Container(
                  width: double.infinity,
                  height: 200,
                  child: Center(child: CircularProgressIndicator())),
              errorWidget: (context, url, error) => Container(
                  width: double.infinity,
                  height: 200,
                  child: Center(
                      child: Icon(
                    Icons.refresh,
                    color: Colors.red,
                    size: 40,
                  ))),
            ),
            Text(
              model['title'],
              style: Theme.of(context).textTheme.headline1,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              model['description'] == null ? 'unknown' : model['description'],
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_history,
                      color: Colors.grey,
                    ),
                    TextButton(
                      child: BuildCondition(
                        condition: model['author'].toString().length > 50,
                        builder: (context) => Text(
                          'unknown',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        fallback: (context) => Text(
                          model['author'] == null ? 'unknown' : model['author'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                Text(
                  model['publishedAt'],
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => newsScreen(model: model),
            ));
      },
    );
Widget buildMatchAppItem(Map model, context) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 120,
            child: Column(
              children: [
                Container(
                  width: 70,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(
                        image: NetworkImage(model['team_home_badge'] != ""
                            ? model['team_home_badge']
                            : "https://w7.pngwing.com/pngs/729/357/png-transparent-flag-of-egypt-egypt-national-football-team-egypt-national-under-20-football-team-egypt-flag-egypt-logo.png"),
                        fit: BoxFit.contain),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  model['match_hometeam_name'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ],
            ),
          ),
          Container(
            color: Colors.black,
            padding: EdgeInsetsDirectional.all(10),
            child: Column(
              children: [
                Text(
                  model['match_live'] == "0"
                      ? model['match_time']
                      : model['match_status'],
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${model['match_awayteam_score']}:${model['match_hometeam_score']}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 120,
            child: Column(
              children: [
                Container(
                  width: 70,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(
                        image: NetworkImage(model['team_away_badge'] != ""
                            ? model['team_away_badge']
                            : "https://w7.pngwing.com/pngs/729/357/png-transparent-flag-of-egypt-egypt-national-football-team-egypt-national-under-20-football-team-egypt-flag-egypt-logo.png"),
                        fit: BoxFit.contain),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  model['match_awayteam_name'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ],
            ),
          ),
        ],
      ),
    );

Widget buildMatchAppVirticalItem(Map model) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            width: 120,
            child: Column(
              children: [
                Container(
                  width: 70,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(
                        image: NetworkImage(model['team_home_badge']),
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  model['match_hometeam_name'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.black,
            padding: EdgeInsetsDirectional.all(10),
            child: Column(
              children: [
                Text(
                  model['match_live'] == "0"
                      ? model['match_time']
                      : model['match_live'],
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${model['match_awayteam_score']}:${model['match_hometeam_score']}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 120,
            child: Column(
              children: [
                Container(
                  width: 70,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(
                        image: NetworkImage(model['team_away_badge']),
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  model['match_awayteam_name'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

Widget buildZekrItem(
    String? zekr, String? description, int? count, int index, context) {
  int counter = 0;
  return GestureDetector(
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.amberAccent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            zekr.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            description!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    print('Copied');
                  },
                  color: Colors.black,
                  icon: Icon(Icons.copy)),
              Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: 1,
                    valueColor: AlwaysStoppedAnimation(Colors.black12),
                  ),
                  CircularProgressIndicator(
                    value: count!.toDouble() -
                        (count.toDouble() - counter.toDouble()),
                    valueColor: AlwaysStoppedAnimation(Colors.black),
                  ),
                  BuildCondition(
                    condition: count.toDouble() != counter.toDouble(),
                    builder: (context) => Text(
                      '${(count.toDouble() - counter.toDouble()).toInt()}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    fallback: (context) => Icon(
                      Icons.check,
                      size: 30,
                    ),
                  ),
                ],
              ),
              IconButton(
                  onPressed: () {
                    print('Shared');
                    Share.share(zekr!, subject: zekr);
                  },
                  color: Colors.black,
                  icon: Icon(Icons.share)),
            ],
          )
        ],
      ),
    ),
    onTap: () {
      counter++;
      print(counter);
      zekrCubit.get(context).changeZekr();
    },
  );
}

Widget buildMainZekrItem(
        String lable, IconData icon, context, Widget goPage, String jsonfile) =>
    GestureDetector(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: HexColor('E7AB79'),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              lable,
              style: Theme.of(context).textTheme.headline1,
            )
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: HexColor('2C3333'),
        ),
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => goPage));
        zekrCubit.get(context).goToZekr(jsonfile);
      },
    );

Widget buildArticles(List list, context, {isSearch = false}) => BuildCondition(
      condition: list.isEmpty,
      fallback: (context) => ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) =>
              buildNewsAppItem(list[index], context),
          separatorBuilder: (context, index) => Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey,
              ),
          itemCount: list.length),
      builder: (context) =>
          isSearch ? Container() : Center(child: CircularProgressIndicator()),
    );

void navigatorGoto(context, Widget widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));

void navigateAndFinish(context, Widget widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

enum SnackState { SUCCESS, ERROR, WARNING }

void showSnackBar(context, msg, SnackState state) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: chooseSnackColor(state),
    ));

Color chooseSnackColor(SnackState state) {
  Color color;
  switch (state) {
    case SnackState.SUCCESS:
      color = Colors.green;
      break;
    case SnackState.ERROR:
      color = Colors.red;
      break;
    case SnackState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

