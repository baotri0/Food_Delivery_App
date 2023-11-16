import 'package:flutter/material.dart';

import '../../constants/routes.dart';
import '../../firebase_helper/firebase_firestore.dart';
import '../../models/category_model.dart';
import '../../models/product_model.dart';
import '../../widgets/top_titles/top_titles.dart';
import '../product_details/product_details.dart';

class CategoryView extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryView({super.key, required this.categoryModel});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ProductModel> productsList = [];
  bool isLoading = false;
  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    productsList = await FirebaseFirestoreHelper.instance
        .getCategoryViewProduct(widget.categoryModel.id);
    productsList.shuffle();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: kToolbarHeight,),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        const BackButton(),
                        Text(
                          widget.categoryModel.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  productsList.isEmpty
                      ? Center(
                          child: Text("Products is empty"),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: GridView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              primary: false,
                              itemCount: productsList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 20,
                                childAspectRatio: 0.75,
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (ctx, index) {
                                ProductModel singleProduct =
                                    productsList[index];
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Image.network(
                                        singleProduct.image,
                                        height: 100,
                                        width: 100,
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        singleProduct.name,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Price: \$${singleProduct.price}",
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 45,
                                        width: 140,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            Routes.instance.push(
                                                widget: ProductDetails(
                                                    singleProduct:
                                                        singleProduct),
                                                context: context);
                                          },
                                          style: OutlinedButton.styleFrom(
                                            foregroundColor: Colors.red,
                                            disabledBackgroundColor:
                                                Colors.red.withOpacity(0.3),
                                            side: BorderSide(
                                              color: Colors.red,
                                              width: 2,
                                            ),
                                          ),
                                          child: Text("Detail"),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                ],
              ),
            ),
    );
  }
}
