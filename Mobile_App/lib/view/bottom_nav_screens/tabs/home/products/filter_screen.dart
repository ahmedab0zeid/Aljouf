import 'package:aljouf/bloc/layout/categories/categories_states.dart';
import 'package:aljouf/shared/components.dart';
import 'package:aljouf/utilities/app_ui.dart';
import 'package:aljouf/utilities/app_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/layout/categories/categories_cubit.dart';
class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit = CategoriesCubit.get(context);

    return Scaffold(
      appBar: customAppBar(title: "filter".tr(),actions: [InkWell(
        onTap: (){
          cubit.sortGroupValue = "";
          cubit.orderGroupValue = "";
          cubit.orderGroupValue = "";
          cubit.catGroupValue = "";
          cubit.priceGroupValue = "";
          cubit.minPrice = "";
          cubit.maxPrice = "";
          cubit.emit(FilterChangeState());
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: CustomText(text: "clear".tr(),color: AppUI.greyColor,),
            ),
          ],
        ),
      ),]
      ),
      body: BlocBuilder<CategoriesCubit,CategoriesStates>(
        buildWhen: (_,state) => state is FilterChangeState,
        builder: (context, state) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: (){
                            cubit.setFilterType("sort");
                          },
                          child: Container(
                            height: 55,
                            decoration:  BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: AppUtil.rtlDirection(context)?const Radius.circular(0):const Radius.circular(15),bottomRight: AppUtil.rtlDirection(context)?const Radius.circular(0):const Radius.circular(15),topLeft: !AppUtil.rtlDirection(context)?const Radius.circular(0):const Radius.circular(15),bottomLeft: !AppUtil.rtlDirection(context)?const Radius.circular(0):const Radius.circular(15)),
                              color: cubit.filterType == "sort" ? AppUI.mainColor : AppUI.whiteColor
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 10,),
                                Image.asset("${AppUI.imgPath}circle.png",height: 10,),
                                const SizedBox(width: 10,),
                                CustomText(text: "sortBy".tr(),fontSize: 16,color: cubit.filterType == "sort"? AppUI.whiteColor:AppUI.blackColor),
                              ],
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: (){
                            cubit.setFilterType("order");
                          },
                          child: Container(
                            height: 55,
                            decoration:  BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: AppUtil.rtlDirection(context)?const Radius.circular(0):const Radius.circular(15),bottomRight: AppUtil.rtlDirection(context)?const Radius.circular(0):const Radius.circular(15),topLeft: !AppUtil.rtlDirection(context)?const Radius.circular(0):const Radius.circular(15),bottomLeft: !AppUtil.rtlDirection(context)?const Radius.circular(0):const Radius.circular(15)),
                              color: cubit.filterType == "order" ? AppUI.mainColor : AppUI.whiteColor
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 10,),
                                Image.asset("${AppUI.imgPath}circle.png",height: 10,),
                                const SizedBox(width: 10,),
                                CustomText(text: "orderBy".tr(),fontSize: 16,color: cubit.filterType == "order"? AppUI.whiteColor:AppUI.blackColor),
                              ],
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: (){
                            cubit.setFilterType("cat");
                          },
                          child: Container(
                            height: 55,
                            decoration:  BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: AppUtil.rtlDirection(context)?const Radius.circular(0):const Radius.circular(15),bottomRight: AppUtil.rtlDirection(context)?const Radius.circular(0):const Radius.circular(15),topLeft: !AppUtil.rtlDirection(context)?const Radius.circular(0):const Radius.circular(15),bottomLeft: !AppUtil.rtlDirection(context)?const Radius.circular(0):const Radius.circular(15)),
                              color: cubit.filterType == "cat" ? AppUI.mainColor : AppUI.whiteColor
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 10,),
                                Image.asset("${AppUI.imgPath}circle.png",height: 10,),
                                const SizedBox(width: 10,),
                                CustomText(text: "categories".tr(),fontSize: 16,color: cubit.filterType == "cat"? AppUI.whiteColor:AppUI.blackColor),
                              ],
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: (){
                            cubit.setFilterType("price");
                          },
                          child: Container(
                            height: 55,
                            decoration:  BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: AppUtil.rtlDirection(context)?const Radius.circular(0):const Radius.circular(15),bottomRight: AppUtil.rtlDirection(context)?const Radius.circular(0):const Radius.circular(15),topLeft: !AppUtil.rtlDirection(context)?const Radius.circular(0):const Radius.circular(15),bottomLeft: !AppUtil.rtlDirection(context)?const Radius.circular(0):const Radius.circular(15)),
                              color: cubit.filterType == "price" ? AppUI.mainColor : AppUI.whiteColor
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 10,),
                                Image.asset("${AppUI.imgPath}circle.png",height: 10,),
                                const SizedBox(width: 10,),
                                CustomText(text: "price".tr(),fontSize: 16,color: cubit.filterType == "price"? AppUI.whiteColor:AppUI.blackColor),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  Container(
                    height: double.infinity,
                    width: 1,
                    color: AppUI.shimmerColor,
                  ),
                  if(cubit.filterType == "sort")
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: InkWell(
                            onTap: (){
                              cubit.sortGroupValue = "name";
                              cubit.emit(FilterChangeState());
                            },
                            child: Row(
                              children: [
                                CustomText(text: "name".tr()),
                                const Spacer(),
                                Radio(value: "name", groupValue: cubit.sortGroupValue,activeColor: AppUI.mainColor, onChanged: (String? v){
                                  cubit.sortGroupValue = v!;
                                  cubit.emit(FilterChangeState());
                                })
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Divider(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: InkWell(
                            onTap: (){
                              cubit.sortGroupValue = "quantity";
                              cubit.emit(FilterChangeState());
                            },
                            child: Row(
                              children: [
                                CustomText(text: "quantity".tr()),
                                const Spacer(),
                                Radio(value: "quantity", groupValue: cubit.sortGroupValue,activeColor: AppUI.mainColor, onChanged: (String? v){
                                  cubit.sortGroupValue = v!;
                                  cubit.emit(FilterChangeState());
                                })
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Divider(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: InkWell(
                            onTap: (){
                              cubit.sortGroupValue = "rating";
                              cubit.emit(FilterChangeState());
                            },
                            child: Row(
                              children: [
                                CustomText(text: "rating".tr()),
                                const Spacer(),
                                Radio(value: "rating", groupValue: cubit.sortGroupValue,activeColor: AppUI.mainColor, onChanged: (String? v){
                                  cubit.sortGroupValue = v!;
                                  cubit.emit(FilterChangeState());
                                })
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Divider(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: InkWell(
                            onTap: (){
                              cubit.sortGroupValue = "date_added";
                              cubit.emit(FilterChangeState());
                            },
                            child: Row(
                              children: [
                                CustomText(text: "dateAdded".tr()),
                                const Spacer(),
                                Radio(value: "date_added", groupValue: cubit.sortGroupValue,activeColor: AppUI.mainColor, onChanged: (String? v){
                                  cubit.sortGroupValue = v!;
                                  cubit.emit(FilterChangeState());
                                })
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 70,),
                      ],
                    ),
                  )
                  else if(cubit.filterType == "order")
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: InkWell(
                              onTap: (){
                                cubit.orderGroupValue = "asc";
                                cubit.emit(FilterChangeState());
                              },
                              child: Row(
                                children: [
                                  CustomText(text: "asc".tr()),
                                  const Spacer(),
                                  Radio(value: "asc", groupValue: cubit.orderGroupValue,activeColor: AppUI.mainColor, onChanged: (String? v){
                                    cubit.orderGroupValue = v!;
                                    cubit.emit(FilterChangeState());
                                  })
                                ],
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Divider(),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: InkWell(
                              onTap: (){
                                cubit.orderGroupValue = "desc";
                                cubit.emit(FilterChangeState());
                              },
                              child: Row(
                                children: [
                                  CustomText(text: "desc".tr()),
                                  const Spacer(),
                                  Radio(value: "desc", groupValue: cubit.orderGroupValue,activeColor: AppUI.mainColor, onChanged: (String? v){
                                    cubit.orderGroupValue = v!;
                                    cubit.emit(FilterChangeState());
                                  })
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 70,),
                        ],
                      ),
                    )
                  else if(cubit.filterType == "cat")
                      Expanded(
                        flex: 2,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(cubit.categoriesModel!.data!.length, (index) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: InkWell(
                                      onTap: (){
                                        cubit.catGroupValue = cubit.categoriesModel!.data![index].categoryId!.toString();
                                        cubit.emit(FilterChangeState());
                                      },
                                      child: Row(
                                        children: [
                                          CustomText(text: cubit.categoriesModel!.data![index].name),
                                          const Spacer(),
                                          Radio(value: cubit.categoriesModel!.data![index].categoryId.toString(), groupValue: cubit.catGroupValue,activeColor: AppUI.mainColor, onChanged: (String? v){
                                            cubit.catGroupValue = v!;
                                            cubit.emit(FilterChangeState());
                                          })
                                        ],
                                      ),
                                    ),
                                  ),
                                  if(index != cubit.categoriesModel!.data!.length-1)
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                    child: Divider(),
                                  )
                                  else
                                    const SizedBox(height: 70,),
                                ],
                              );
                            }),
                          ),
                        ),
                      )
                  else if(cubit.filterType == "price")
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: InkWell(
                                  onTap: (){
                                    cubit.priceGroupValue = "0";
                                    cubit.minPrice = "0";
                                    cubit.maxPrice = "100";
                                    cubit.emit(FilterChangeState());
                                  },
                                  child: Row(
                                    children: [
                                      CustomText(text: "0 SAR - 100 SAR".tr()),
                                      const Spacer(),
                                      Radio(value: "0", groupValue: cubit.priceGroupValue,activeColor: AppUI.mainColor, onChanged: (String? v){
                                        cubit.priceGroupValue = v!;
                                        cubit.minPrice = "0";
                                        cubit.maxPrice = "100";
                                        cubit.emit(FilterChangeState());
                                      })
                                    ],
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Divider(),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: InkWell(
                                  onTap: (){
                                    cubit.priceGroupValue = "1";
                                    cubit.minPrice = "100";
                                    cubit.maxPrice = "200";
                                    cubit.emit(FilterChangeState());
                                  },
                                  child: Row(
                                    children: [
                                      CustomText(text: "100 SAR - 200 SAR".tr()),
                                      const Spacer(),
                                      Radio(value: "1", groupValue: cubit.priceGroupValue,activeColor: AppUI.mainColor, onChanged: (String? v){
                                        cubit.priceGroupValue = v!;
                                        cubit.minPrice = "100";
                                        cubit.maxPrice = "200";
                                        cubit.emit(FilterChangeState());
                                      })
                                    ],
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Divider(),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: InkWell(
                                  onTap: (){
                                    cubit.priceGroupValue = "2";
                                    cubit.minPrice = "200";
                                    cubit.maxPrice = "300";
                                    cubit.emit(FilterChangeState());
                                  },
                                  child: Row(
                                    children: [
                                      CustomText(text: "200 SAR - 300 SAR".tr()),
                                      const Spacer(),
                                      Radio(value: "2", groupValue: cubit.priceGroupValue,activeColor: AppUI.mainColor, onChanged: (String? v){
                                        cubit.priceGroupValue = v!;
                                        cubit.minPrice = "200";
                                        cubit.maxPrice = "300";
                                        cubit.emit(FilterChangeState());
                                      })
                                    ],
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Divider(),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: InkWell(
                                  onTap: (){
                                    cubit.priceGroupValue = "3";
                                    cubit.minPrice = "300";
                                    cubit.maxPrice = "400";
                                    cubit.emit(FilterChangeState());
                                  },
                                  child: Row(
                                    children: [
                                      CustomText(text: "300 SAR - 400 SAR".tr()),
                                      const Spacer(),
                                      Radio(value: "3", groupValue: cubit.priceGroupValue,activeColor: AppUI.mainColor, onChanged: (String? v){
                                        cubit.priceGroupValue = v!;
                                        cubit.minPrice = "300";
                                        cubit.maxPrice = "400";
                                        cubit.emit(FilterChangeState());
                                      })
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 70,),
                            ],
                          ),
                        ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: CustomButton(text: "showResults".tr().toUpperCase(),onPressed: (){
                  cubit.page = 1;
                  cubit.products.clear();
                  cubit.productsByCatID(cubit.catGroupValue,);
                  Navigator.pop(context);
                },),
              ),
            ],
          );
        }
      ),
    );
  }
}
