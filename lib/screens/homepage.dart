import 'package:flutter/material.dart';
import 'package:recipie/services/api.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final MealDBApi mealDBApi = MealDBApi();

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Categories',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ))
          ],
        ),
        body: FutureBuilder(
            future: mealDBApi.fetchCategories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                List<Map<String, dynamic>>? categories = snapshot.data;
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0),
                    itemCount: categories!.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> category = categories[index];
                      return SizedBox(
                        width: 100,
                        height: 150,
                        child: Column(children: [
                          Image.network(category['strCategoryThumb']),
                          Text(category['strCategory'])
                        ]),
                      );
                    });
              }
            }));
  }
}
