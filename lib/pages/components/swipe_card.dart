import 'package:flutter/material.dart';

class SwipeCard extends StatelessWidget {
  final String url;
  final String name;
  final Future<void> Function(bool) onClick;
  const SwipeCard(
      {super.key,
      required this.url,
      required this.name,
      required this.onClick});
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 1,
      child: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: NetworkImage(url),
                fit: BoxFit.cover,
                alignment: const Alignment(-0.3, 0))),
        child: FractionallySizedBox(
          widthFactor: 1,
          heightFactor: 0.2,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton.filled(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.white)),
                          onPressed: () => onClick(false),
                          icon: Icon(Icons.close, color: Colors.red.shade900)),
                      IconButton.filled(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.white)),
                          onPressed: () => onClick(true),
                          icon: Icon(Icons.favorite,
                              color: Colors.green.shade400))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
