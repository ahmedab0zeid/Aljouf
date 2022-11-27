import 'package:aljouf/view/bottom_nav_screens/tabs/categories/sub_categories_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/layout/categories/categories_cubit.dart';
import '../../../../bloc/layout/categories/categories_states.dart';
import '../../../../shared/components.dart';
import '../../../../utilities/app_ui.dart';
import '../../../../utilities/app_util.dart';
import '../home/products/products_screen.dart';
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = CategoriesCubit.get(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<CategoriesCubit,CategoriesStates>(
          buildWhen: (_,states) => states is CategoriesLoadingState || states is CategoriesLoadedState || states is CategoriesErrorState,
          builder: (context, states) {
            if(states is CategoriesLoadingState){
              return const LoadingWidget();
            }
            if(states is CategoriesErrorState){
              return const ErrorFetchWidget();
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
                  children: List.generate(cubit.categoriesModel!.data!.length, (index) {
                    return InkWell(
                      onTap: () async {
                        AppUtil.dialog2(context, "", [
                          const LoadingWidget(),
                          const SizedBox(height: 30,),
                        ],backgroundColor: Colors.transparent,barrierDismissible: false);
                        await cubit.fetchSubCategories(cubit.categoriesModel!.data![index].categoryId);
                        if (!mounted) return;
                        Navigator.of(context, rootNavigator: true).pop();
                        if(cubit.subCategoriesModel!.data!.subCategories!.isNotEmpty) {
                          AppUtil.mainNavigator(context, SubCategoriesScreen(cat: cubit.categoriesModel!.data![index]));
                        }else{
                          AppUtil.mainNavigator(context, ProductsScreen(cat: cubit.categoriesModel!.data![index]),);
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: cubit.categoriesModel!.data![index].mobileImage!,
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
    );
  }
}
