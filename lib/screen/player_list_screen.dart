import 'package:flutter/material.dart';
import 'package:music_player/constants/app_color.dart';
import 'package:music_player/model/muisic_model.dart';
import 'package:music_player/widget/NeumorphismBtn.dart';

class PlayerListScreen extends StatefulWidget {
  const PlayerListScreen({super.key, required this.selectedIndex});
  final int selectedIndex;

  @override
  State<PlayerListScreen> createState() => _PlayerListScreenState();
}

class _PlayerListScreenState extends State<PlayerListScreen> {
  late int selectedIndex;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    selectedIndex = widget.selectedIndex;
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        calculateScrollposition(scrollController);
      },
    );
    super.initState();
  }

  calculateScrollposition(ScrollController scrollController) {
    int totalLength = musicList.length;
    final maxScroll = scrollController.position.maxScrollExtent;

    scrollController.animateTo(maxScroll / totalLength * selectedIndex,
        duration: Duration(milliseconds: 10), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'Flume * kai'.toUpperCase(),
            style: TextStyle(
                color: AppColor.secondaryTextColor,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: size.height * 0.3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NeumorphismBtn(
                  size: 65,
                  onPressed: () {
                    Navigator.pop(context, selectedIndex);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: AppColor.secondaryTextColor,
                  ),
                ),
                NeumorphismBtn(
                  size: size.width * 0.45,
                  distance: 20,
                  padding: 8,
                  imageUrl: musicList[selectedIndex].imageUrl,
                ),
                NeumorphismBtn(
                  size: 65,
                  child: Icon(
                    musicList[selectedIndex].isFav
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: AppColor.secondaryTextColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: musicList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        decoration: selectedIndex == index
                            ? BoxDecoration(
                                color: AppColor.secondaryTextColor
                                    .withOpacity(0.3),
                                borderRadius: BorderRadius.circular(20))
                            : null,
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  musicList[index].name,
                                  style: TextStyle(
                                      color: AppColor.primaryTextColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  musicList[index].artist,
                                  style: TextStyle(
                                      color: AppColor.secondaryTextColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Spacer(),
                            selectedIndex == index
                                ? NeumorphismBtn(
                                    size: 50,
                                    colors: [
                                      AppColor.blueTopDark,
                                      AppColor.blue
                                    ],
                                    child: Icon(
                                      Icons.pause_rounded,
                                      color: AppColor.white,
                                    ))
                                : NeumorphismBtn(
                                    size: 50,
                                    child: Icon(
                                      Icons.play_arrow_rounded,
                                      color: AppColor.secondaryTextColor,
                                    ))
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      )),
    );
  }
}
