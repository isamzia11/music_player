import 'package:flutter/material.dart';
import 'package:music_player/constants/app_color.dart';
import 'package:music_player/widget/NeumorphismBtn.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NeumorphismBtn(
                    size: 65,
                    child: Icon(
                      Icons.favorite_border_outlined,
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
                    child: Icon(
                      Icons.menu,
                      color: AppColor.secondaryTextColor,
                    ),
                  )
                ],
              ),
              NeumorphismBtn(
                size: size.width * 0.8,
                imageUrl: 'assets/images/1.jpg',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
