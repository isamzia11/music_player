import 'package:flutter/material.dart';
import 'package:music_player/constants/app_color.dart';
import 'package:music_player/model/muisic_model.dart';
import 'package:music_player/screen/player_list_screen.dart';
import 'package:music_player/widget/NeumorphismBtn.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  int _currentItemPlaying = 0;
  double _currentPlayback = 0;
  String formatePlayerTime(double time) {
    final min = time ~/ 60;
    final sec = time % 60;

    return '$min:${sec.toStringAsFixed(0).padRight(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NeumorphismBtn(
                    size: 65,
                    child: Icon(
                      musicList[_currentItemPlaying].isFav
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: AppColor.secondaryTextColor,
                    ),
                  ),
                  Text(
                    'Playing now'.toUpperCase(),
                    style: TextStyle(
                        color: AppColor.secondaryTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  NeumorphismBtn(
                    size: 65,
                    onPressed: () async {
                      int selectedindex = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlayerListScreen(
                                    selectedIndex: _currentItemPlaying,
                                  )));
                      setState(() {
                        _currentItemPlaying = selectedindex;
                      });
                    },
                    child: Icon(
                      Icons.menu,
                      color: AppColor.secondaryTextColor,
                    ),
                  )
                ],
              ),
              NeumorphismBtn(
                size: size.width * 0.8,
                padding: 10,
                distance: 20,
                imageUrl: musicList[_currentItemPlaying].imageUrl,
              ),
              Column(
                children: [
                  Text(
                    musicList[_currentItemPlaying].name.toString(),
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primaryTextColor),
                  ),
                  Text(
                    musicList[_currentItemPlaying].artist.toString(),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColor.secondaryTextColor),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formatePlayerTime(_currentPlayback),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColor.secondaryTextColor),
                        ),
                        Text(
                          formatePlayerTime(
                              musicList[_currentItemPlaying].length),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColor.secondaryTextColor),
                        ),
                      ],
                    ),
                  ),
                  Slider(
                      value: _currentPlayback,
                      max: musicList[_currentItemPlaying].length,
                      thumbColor: AppColor.blue,
                      activeColor: AppColor.blue,
                      inactiveColor: AppColor.bgDark,
                      onChanged: (value) {
                        setState(() {
                          _currentPlayback = value;
                        });
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      NeumorphismBtn(
                        size: 80,
                        onPressed: () {
                          if (_currentItemPlaying > 0) {
                            setState(() {
                              _currentItemPlaying--;
                            });
                          }
                        },
                        child: Icon(
                          Icons.skip_previous_rounded,
                          color: AppColor.secondaryTextColor,
                          size: 35,
                        ),
                      ),
                      NeumorphismBtn(
                        size: 80,
                        colors: [AppColor.blueTopDark, AppColor.blue],
                        child: Icon(
                          Icons.pause,
                          color: AppColor.white,
                          size: 35,
                        ),
                      ),
                      NeumorphismBtn(
                        size: 80,
                        onPressed: () {
                          if (_currentItemPlaying < musicList.length - 1) {
                            setState(() {
                              _currentItemPlaying++;
                            });
                          }
                        },
                        child: Icon(
                          Icons.skip_next_rounded,
                          color: AppColor.secondaryTextColor,
                          size: 35,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
