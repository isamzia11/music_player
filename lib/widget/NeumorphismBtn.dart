import 'package:flutter/material.dart';
import 'package:music_player/constants/app_color.dart';

class NeumorphismBtn extends StatelessWidget {
  const NeumorphismBtn({
    super.key,
    required this.size,
    this.child,
    this.onPressed,
    this.blur = 20,
    this.distance = 10,
    this.colors,
    this.imageUrl,
    this.padding,
  });

  final double size;
  final Widget? child;
  final VoidCallback? onPressed;
  final double blur;
  final double distance;
  final List<Color>? colors;
  final String? imageUrl;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        padding: EdgeInsets.all(padding ?? 3),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
            color: colors == null ? AppColor.bgColor : colors![1],
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: AppColor.white,
                  blurRadius: blur,
                  offset: Offset(
                    -distance,
                    -distance,
                  )),
              BoxShadow(
                  color: AppColor.bgDark,
                  blurRadius: blur,
                  offset: Offset(
                    distance,
                    distance,
                  ))
            ]),
        child: imageUrl != null
            ? CircleAvatar(
                backgroundImage: AssetImage(imageUrl!),
              )
            : Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.bgColor,
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: colors ?? [AppColor.white, AppColor.bgDark])),
                child: child,
              ),
      ),
    );
  }
}
