import 'package:aljouf/models/home/products_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../../../../bloc/layout/categories/categories_cubit.dart';
import '../../../../../../../bloc/layout/categories/categories_states.dart';
import '../../../../../../../shared/components.dart';
import '../../../../../../../utilities/app_ui.dart';
import '../../../../../../../utilities/app_util.dart';
import '../../products_screen.dart';
class ReviewsTab extends StatefulWidget {
  final Products product;
  const ReviewsTab({Key? key, required this.product}) : super(key: key);

  @override
  State<ReviewsTab> createState() => _ReviewsTabState();
}

class _ReviewsTabState extends State<ReviewsTab> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.product.reviews!.reviews??=[];
    CategoriesCubit.get(context).sortReviews(widget.product.reviews!.reviews!);
  }
  @override
  Widget build(BuildContext context) {
    final cubit = CategoriesCubit.get(context);
    return BlocBuilder<CategoriesCubit,CategoriesStates>(
      buildWhen: (_,state) => state is AddReviewsLoadedState,
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: [
                            Column(
                              children: [
                                CustomText(text: cubit.averageCount.round().toString(),fontSize: 30,fontWeight: FontWeight.w600,),
                                CustomText(text: "${widget.product.reviews!.reviews!.length} ${"rating".tr()}",),
                              ],
                            ),
                            const SizedBox(width: 30,),
                            Column(
                              children: [
                                SizedBox(
                                  width: AppUtil.responsiveWidth(context)*0.7,
                                  child: Row(
                                    children: [
                                      const CustomText(text: "5",fontSize: 18,),
                                      const SizedBox(width: 2,),
                                      Icon(Icons.star,color: AppUI.ratingColor,),
                                      const SizedBox(width: 7,),
                                      Expanded(
                                        flex: 9,
                                        child: ClipRRect(
                                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                                            child: LinearProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppUI.ratingColor),minHeight: 12,value: widget.product.reviews!.reviews!.isEmpty?0:cubit.rating5/widget.product.reviews!.reviews!.length,backgroundColor: AppUI.backgroundColor,)),
                                      ),
                                      const SizedBox(width: 10,),
                                      Expanded(flex: 3,child: CustomText(text: widget.product.reviews!.reviews!.isEmpty?"0 %":"${((cubit.rating5/widget.product.reviews!.reviews!.length)*100).round()} %",fontSize: 18,)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: AppUtil.responsiveWidth(context)*0.7,
                                  child: Row(
                                    children: [
                                      CustomText(text: "4",fontSize: 18,),
                                      const SizedBox(width: 2,),
                                      Icon(Icons.star,color: AppUI.ratingColor,),
                                      const SizedBox(width: 7,),
                                      Expanded(
                                        flex: 9,
                                        child: ClipRRect(
                                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                                            child: LinearProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppUI.ratingColor),minHeight: 12,value: widget.product.reviews!.reviews!.isEmpty?0:cubit.rating4/widget.product.reviews!.reviews!.length,backgroundColor: AppUI.backgroundColor,)),
                                      ),
                                      const SizedBox(width: 10,),
                                      Expanded(flex: 3,child: CustomText(text: widget.product.reviews!.reviews!.isEmpty?"0 %":"${((cubit.rating4/widget.product.reviews!.reviews!.length)*100).round()} %",fontSize: 18,)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: AppUtil.responsiveWidth(context)*0.7,
                                  child: Row(
                                    children: [
                                      const CustomText(text: "3",fontSize: 18,),
                                      const SizedBox(width: 2,),
                                      Icon(Icons.star,color: AppUI.ratingColor,),
                                      const SizedBox(width: 7,),
                                      Expanded(
                                        flex: 9,
                                        child: ClipRRect(
                                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                                            child: LinearProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppUI.ratingColor),minHeight: 12,value: widget.product.reviews!.reviews!.isEmpty?0:cubit.rating3/widget.product.reviews!.reviews!.length,backgroundColor: AppUI.backgroundColor,)),
                                      ),
                                      const SizedBox(width: 10,),
                                      Expanded(flex: 3,child: CustomText(text: widget.product.reviews!.reviews!.isEmpty?"0 %":"${((cubit.rating3/widget.product.reviews!.reviews!.length)*100).round()} %",fontSize: 18,)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: AppUtil.responsiveWidth(context)*0.7,
                                  child: Row(
                                    children: [
                                      const CustomText(text: "2",fontSize: 18,),
                                      const SizedBox(width: 2,),
                                      Icon(Icons.star,color: AppUI.ratingColor,),
                                      const SizedBox(width: 7,),
                                      Expanded(
                                        flex: 9,
                                        child: ClipRRect(
                                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                                            child: LinearProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppUI.ratingColor),minHeight: 12,value: widget.product.reviews!.reviews!.isEmpty?0:cubit.rating2/widget.product.reviews!.reviews!.length,backgroundColor: AppUI.backgroundColor,)),
                                      ),
                                      const SizedBox(width: 10,),
                                      Expanded(flex: 3,child: CustomText(text: widget.product.reviews!.reviews!.isEmpty?"0 %":"${((cubit.rating2/widget.product.reviews!.reviews!.length)*100).round()} %",fontSize: 18,)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: AppUtil.responsiveWidth(context)*0.7,
                                  child: Row(
                                    children: [
                                      const CustomText(text: "1",fontSize: 18,),
                                      const SizedBox(width: 2,),
                                      Icon(Icons.star,color: AppUI.ratingColor,),
                                      const SizedBox(width: 7,),
                                      Expanded(
                                        flex: 9,
                                        child: ClipRRect(
                                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                                            child: LinearProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppUI.ratingColor),minHeight: 12,value: widget.product.reviews!.reviews!.isEmpty?0:cubit.rating1/widget.product.reviews!.reviews!.length,backgroundColor: AppUI.backgroundColor,)),
                                      ),
                                      const SizedBox(width: 10,),
                                      Expanded(flex: 3,child: CustomText(text: widget.product.reviews!.reviews!.isEmpty?"0 %":"${((cubit.rating1/widget.product.reviews!.reviews!.length)*100).round()} %",fontSize: 18,)),
                                    ],
                                  ),
                                ),

                              ],
                            )
                          ],
                        ),

                        const SizedBox(height: 10,),
                        const Divider(thickness: 1,),
                        const SizedBox(height: 10,),
                        CustomText(text: "${"reviews".tr()} (${widget.product.reviews!.reviews!.length})",color: AppUI.blackColor,fontSize: 16,fontWeight: FontWeight.w700,),
                        const SizedBox(height: 10,),

                        Column(
                          children: List.generate(widget.product.reviews!.reviews!.length, (index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RatingBar.builder(
                                  initialRating: double.parse(widget.product.reviews!.reviews![index].rating.toString()),
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                                  itemCount: 5,
                                  ignoreGestures: true,
                                  itemSize: 22,
                                  unratedColor: AppUI.mainColor.withOpacity(0.1),
                                  onRatingUpdate: (rating) {
                                    // cubit.setRate(rating);
                                  },
                                  itemBuilder: (BuildContext context, int index) {return const Icon(Icons.star,size: 30,color: Colors.amber,) ; },
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomText(text: widget.product.reviews!.reviews![index].author,color: AppUI.blackColor,fontSize: 16,fontWeight: FontWeight.w700,),
                                    const Spacer(),
                                    CustomText(text: widget.product.reviews!.reviews![index].dateAdded!,),
                                  ],
                                ),
                                CustomText(text: widget.product.reviews!.reviews![index].text,color: AppUI.blackColor,fontSize: 16,),
                                const Divider(thickness: 1,),
                              ],
                            );
                          }),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            CustomText(text: "doYouOwnOrHaveUsedTheProduct".tr(),fontWeight: FontWeight.w600,textAlign: TextAlign.center,),
                            CustomText(text: "tellUsYourOpinionByRating".tr(),textAlign: TextAlign.center,fontSize: 12,),
                            const SizedBox(height: 10,),
                            RatingBar.builder(
                              initialRating: 5,
                              minRating: 1,
                              direction: Axis.horizontal,
                              itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                              itemCount: 5,
                              itemSize: 35,
                              unratedColor: AppUI.mainColor.withOpacity(0.1),
                              onRatingUpdate: (rating) {
                                cubit.rateAdded = rating;
                              },
                              itemBuilder: (BuildContext context, int index) {return const Icon(Icons.star,size: 30,color: Colors.amber,) ; },
                            ),
                            const SizedBox(height: 10,),
                            SizedBox(width: AppUtil.responsiveWidth(context)*0.9,child: CustomInput(controller: cubit.commentController, textInputType: TextInputType.text,maxLines: 3,)),
                            const SizedBox(height: 20,),
                            BlocBuilder<CategoriesCubit,CategoriesStates>(
                                buildWhen: (_,state) => state is AddReviewsLoadingState || state is AddReviewsLoadedState || state is AddReviewsErrorState ,
                                builder: (context, state) {
                                  if(state is AddReviewsLoadingState){
                                    return const LoadingWidget();
                                  }
                                  return CustomButton(text: "addReview".tr(),width: 120,onPressed: () async {
                                    if(cubit.commentController.text.isEmpty){
                                      AppUtil.errorToast(context, "pleaseAddComment".tr());
                                      return;
                                    }
                                    await cubit.addReview(widget.product.id,context,widget.product.reviews!.reviews);
                                  }
                                  );
                                }
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),
        );
      }
    );
  }
}
