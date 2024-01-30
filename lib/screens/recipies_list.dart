import 'package:flutter/material.dart';
import 'package:recipie/services/api.dart';

class RecipieList extends StatelessWidget {
  const RecipieList({super.key, required this.category});
  final String category;

  @override
  Widget build(BuildContext context) {
    final MealDBApi mealDBApi = MealDBApi();
    return Scaffold(
      appBar: AppBar(title: Text('$category'),
      actions: []),
      body: FutureBuilder(future: mealDBApi.fetchRecipieList(category), builder: (context,snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }else{
                List<Map<String, dynamic>>? recipies = snapshot.data;
                return ListView.builder(
                  itemCount:recipies!.length,
                  itemBuilder: (context, index){
                    Map<String,dynamic> recipie = recipies[index];
                    return GestureDetector(
                      onTap: (){},
                      child: Container(
                        margin:EdgeInsets.all(8.0),
                        decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10.0)),
                        child: ListTile(
                        leading: Image.network(recipie['strMealThumb'],scale: 0.5,fit: BoxFit.fill,),
                        title: Text('${recipie['strMeal']}'),
                        trailing: IconButton(onPressed: (){},icon: Icon(Icons.favorite),),
                      ),
                      )
                    );
                  },
                  );
              }
      }),
    );
  }
}