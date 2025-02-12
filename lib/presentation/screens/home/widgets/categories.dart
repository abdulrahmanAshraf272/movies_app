import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/business_logic/cubit/movies_cubit.dart';
import 'package:movies_app/constants/app_colors.dart';
import 'package:movies_app/constants/strings.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final moviesCubit = context.read<MoviesCubit>();
    return SizedBox(
      height: 32.h,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(right: 20, left: 20),
          itemCount: categories.length,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                    moviesCubit.selectCategory(categories[index]);
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  //margin: const EdgeInsets.only(left: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: selectedIndex == index
                          ? AppColors.green.withValues(alpha: 0.1)
                          : Colors.transparent),
                  child: Text(
                    categories[index],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: selectedIndex == index
                            ? AppColors.green.withValues(alpha: 0.7)
                            : Colors.white.withValues(alpha: 0.4)),
                  ),
                ),
              )),
    );
  }
}
