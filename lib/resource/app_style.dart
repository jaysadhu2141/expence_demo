import 'package:expence_demo/device/device_utils.dart';
import 'package:expence_demo/resource/app_colors.dart';
import 'package:flutter/material.dart';

class AppStyle {



  static Widget expenseListBox(BuildContext? context,
      {String? title, String? amount, String? date, VoidCallback? onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 2.0,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          height: DeviceUtils.getScaledHeight(context!, 0.10),
          width: DeviceUtils.getScaledWidth(context, 0.9),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: AppColors.purple,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    Center(
                        child: Text(
                          '\$$amount.0' ?? '',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppColors.white),
                        )),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  height: DeviceUtils.getScaledHeight(context, 0.09),
                  width: DeviceUtils.getScaledWidth(context, 0.4),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title ?? '',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(date ?? ''),
                      ]),
                ),
                SizedBox(
                  width: DeviceUtils.getScaledWidth(context, 0.15),
                ),
                InkWell(
                    onTap:onPressed,
                    child: Icon(Icons.delete, color: AppColors.red)),
              ],
            ),
          ),
        ),
      ),
    );
  }



}