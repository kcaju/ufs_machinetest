import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ufs_machinetest/controller/detailscreen_controller.dart';
import 'package:ufs_machinetest/utils/color_constants.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.id});
  final int id;
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context
            .read<DetailscreenController>()
            .getDetails(id: widget.id.toString());
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.black,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Details Screen",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorConstants.black,
              fontSize: 25,
            ),
          ),
        ),
        body: Consumer<DetailscreenController>(
          builder: (context, detailProv, child) => detailProv.isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 400,
                          decoration: BoxDecoration(
                              color: ColorConstants.blue,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: CachedNetworkImageProvider(
                                      detailProv.detailObj!.image ?? "")),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          detailProv.detailObj!.title ?? "",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.white,
                            fontSize: 25,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Catergory :",
                              style: TextStyle(
                                  color: ColorConstants.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${detailProv.detailObj!.category ?? ""}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: ColorConstants.white,
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              "Price:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorConstants.white,
                                fontSize: 25,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${detailProv.detailObj!.price ?? ""}\$",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: ColorConstants.white,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Description :",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.white,
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          detailProv.detailObj!.description ?? "",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: ColorConstants.white,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ));
  }
}
