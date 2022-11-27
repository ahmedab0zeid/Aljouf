import 'package:aljouf/models/home/categories_model.dart';
import 'package:aljouf/view/bottom_nav_screens/tabs/home/products/products_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/layout/categories/categories_cubit.dart';
import '../../../../bloc/layout/categories/categories_states.dart';
import '../../../../shared/components.dart';
import '../../../../utilities/app_ui.dart';
import '../../../../utilities/app_util.dart';
class SubCategoriesScreen extends StatefulWidget {
  final Data cat;
  const SubCategoriesScreen({Key? key, required this.cat}) : super(key: key);

  @override
  _SubCategoriesScreenState createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // CategoriesCubit.get(context).fetchSubCategories(widget.cat.categoryId);
  }
  @override
  Widget build(BuildContext context) {
    final cubit = CategoriesCubit.get(context);

    return Scaffold(
      appBar: customAppBar(title: widget.cat.name),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<CategoriesCubit,CategoriesStates>(
            buildWhen: (_,states) => states is SubCategoriesLoadingState || states is SubCategoriesLoadedState || states is SubCategoriesErrorState || states is SubCategoriesEmptyState,
            builder: (context, states) {
              if(states is SubCategoriesLoadingState){
                return const LoadingWidget();
              }
              if(states is SubCategoriesErrorState){
                return const ErrorFetchWidget();
              }

              if(states is SubCategoriesEmptyState){
                return const EmptyWidget();
              }

              return Column(
                children: [
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      // physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(5),
                      crossAxisSpacing: 20,
                      childAspectRatio: (150/160),
                      children: List.generate(cubit.subCategoriesModel!.data!.subCategories!.length, (index) {
                        return InkWell(
                          onTap: (){
                            AppUtil.mainNavigator(context, ProductsScreen(cat: cubit.subCategoriesModel!.data!.subCategories![index],));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: CachedNetworkImage(
                              imageUrl: cubit.subCategoriesModel!.data!.subCategories![index].mobileImage!,
                              placeholder: (context, url) => Image.asset("${AppUI.imgPath}catJouf.png"),
                              errorWidget: (context, url, error) => Image.asset("${AppUI.imgPath}catJouf.png"),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 40,)

                ],
              );
            }
        ),
      ),
    );
  }
}
