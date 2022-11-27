import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../../../../../bloc/layout/categories/categories_cubit.dart';
import '../../../../../../../models/home/products_model.dart';
class InfoAndCare extends StatefulWidget {
  final Customtabs nitrate;
  const InfoAndCare({Key? key, required this.nitrate}) : super(key: key);

  @override
  State<InfoAndCare> createState() => _InfoAndCareState();
}

class _InfoAndCareState extends State<InfoAndCare> {
  @override
  Widget build(BuildContext context) {
    final cubit = CategoriesCubit.get(context);
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        // child: Column(
        //   children: List.generate(widget.nitrate.customtabs!.length, (index) {
        //     return Image.memory(base64Decode(widget.nitrate.customtabs![index].description!.split("src=&quot;")[1]));
        //   })
        // ),
      ),
    );
  }
}
