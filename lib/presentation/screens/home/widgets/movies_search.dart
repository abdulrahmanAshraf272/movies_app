import 'package:flutter/material.dart';

class MoviesSearch extends StatelessWidget {
  const MoviesSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 48,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              color: Colors.white.withValues(alpha: 0.5),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
                child: TextField(
                    controller: TextEditingController(),
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none),
                    onChanged: (searchedMovie) {}))
          ],
        ));
  }
}
