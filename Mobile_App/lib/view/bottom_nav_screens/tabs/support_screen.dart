import 'package:aljouf/bloc/layout/profile/profile_cubit.dart';
import 'package:aljouf/bloc/layout/profile/profile_states.dart';
import 'package:aljouf/shared/components.dart';
import 'package:aljouf/utilities/app_ui.dart';
import 'package:aljouf/utilities/app_util.dart';
import 'package:aljouf/view/bottom_nav_screens/tabs/profile/pages/setting/static_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = ProfileCubit.get(context);
    return Container(
      color: AppUI.shimmerColor.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: "popularAsks".tr(),fontWeight: FontWeight.w600,),
              const SizedBox(height: 20,),
              BlocBuilder<ProfileCubit,ProfileStates>(
                buildWhen: (_,state) => state is AllStaticPageLoadingState || state is AllStaticPageLoadedState || state is AllStaticPageErrorState ,
                builder: (context, state) {
                  if(state is AllStaticPageLoadingState){
                    return const LoadingWidget();
                  }

                  if(state is AllStaticPageErrorState){
                    return const ErrorFetchWidget();
                  }

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomCard(
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        children: List.generate(cubit.allStaticPagesModel!.data!.length, (index) {
                          return Column(
                            children: [
                              ListTile(
                                onTap: (){
                                  AppUtil.mainNavigator(context, StaticPage(title: cubit.allStaticPagesModel!.data![index].title!, id: cubit.allStaticPagesModel!.data![index].id.toString(),));
                                },
                                contentPadding: EdgeInsets.zero,
                                title: CustomText(text: cubit.allStaticPagesModel!.data![index].title),
                                trailing: Icon(Icons.arrow_forward_ios,color: AppUI.greyColor,size: 16,),
                              ),
                              if(index!=cubit.allStaticPagesModel!.data!.length-1)
                              const SizedBox(height: 1,child:  Divider())
                            ],
                          );
                        }),
                      ),
                    ),
                  );
                }
              ),
              const SizedBox(height: 80,),

            ],
          ),
        ),
      ),
    );
  }
}
