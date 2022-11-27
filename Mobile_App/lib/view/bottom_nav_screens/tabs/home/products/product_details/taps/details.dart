import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../../bloc/layout/categories/categories_cubit.dart';
import '../../../../../../../bloc/layout/categories/categories_states.dart';
import '../../../../../../../models/home/products_model.dart';
import '../../../../../../../shared/components.dart';
import '../../../../../../../utilities/app_ui.dart';
import '../../../../../../../utilities/app_util.dart';
import '../../products_screen.dart';

class Details extends StatefulWidget {
  final String? desc;
  const Details({Key? key, this.desc}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    final cubit = CategoriesCubit.get(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomText(text: widget.desc),
            const SizedBox(height: 30,),

          ],
        ),
      ),
    );
  }
}
