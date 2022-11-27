import 'package:aljouf/bloc/layout/profile/profile_cubit.dart';
import 'package:aljouf/bloc/layout/profile/profile_states.dart';
import 'package:aljouf/shared/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class StaticPage extends StatefulWidget {
  final String title,id;
  const StaticPage({Key? key,required this.id,required this.title}) : super(key: key);

  @override
  _StaticPageState createState() => _StaticPageState();
}

class _StaticPageState extends State<StaticPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProfileCubit.get(context).staticPage(widget.id);
  }
  @override
  Widget build(BuildContext context) {
    final cubit = ProfileCubit.get(context);
    return Scaffold(
      appBar: customAppBar(title: widget.title),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<ProfileCubit,ProfileStates>(
          buildWhen: (_,state) => state is StaticPageLoadedState || state is StaticPageLoadingState || state is StaticPageErrorState,
          builder: (context, state) {
            if(state is StaticPageLoadingState){
              return const LoadingWidget();
            }

            if(state is StaticPageErrorState){
              return const ErrorFetchWidget();
            }

            return SingleChildScrollView(
              child: Center(
                child: CustomText(text: cubit.aboutPageModel!.data![0].description!.isEmpty?"noDataAvailable".tr():cubit.aboutPageModel!.data![0].description,textAlign: TextAlign.center,),
              ),
            );
          }
        ),
      ),
    );
  }
}
