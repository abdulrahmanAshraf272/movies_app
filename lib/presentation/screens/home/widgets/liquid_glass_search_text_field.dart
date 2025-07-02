import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:movies_app/business_logic/cubit/movies_cubit.dart';

class LiquidGlassSearchTextField extends StatelessWidget {
  const LiquidGlassSearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesCubit = context.read<MoviesCubit>();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: LiquidGlass(
        settings: const LiquidGlassSettings(
            ambientStrength: 2,
            lightAngle: 0.4 * math.pi,
            glassColor: Colors.black12,
            thickness: 30,
            blur: 4),
        shape: const LiquidRoundedSuperellipse(
          borderRadius: Radius.circular(40),
        ),
        glassContainsChild: false,
        child: Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: TextField(
            controller: moviesCubit.textEditingController,
            //focusNode: _searchFocusNode,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            onChanged: (query) => moviesCubit.searchMovies(query),
            decoration: const InputDecoration(
              hintText: 'Search ...',
              hintStyle: TextStyle(
                color: Colors.white60,
                fontSize: 15,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white60,
                size: 22,
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 12,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
