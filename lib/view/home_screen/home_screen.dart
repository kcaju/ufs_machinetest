import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ufs_machinetest/controller/homescreen_controller.dart';
import 'package:ufs_machinetest/utils/color_constants.dart';
import 'package:ufs_machinetest/view/details_screen/details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context.read<HomescreenController>().fetchProducts();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstants.blue,
        onPressed: () {
          TextEditingController title = TextEditingController();
          TextEditingController price = TextEditingController();
          TextEditingController description = TextEditingController();
          TextEditingController category = TextEditingController();

          final formkey = GlobalKey<FormState>();

          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              return null;
                            } else {
                              return "must fill";
                            }
                          },
                          controller: title,
                          decoration: InputDecoration(
                              hintText: "Title",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              return null;
                            } else {
                              return "must fill";
                            }
                          },
                          controller: price,
                          decoration: InputDecoration(
                              hintText: "Price",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              return null;
                            } else {
                              return "must fill";
                            }
                          },
                          controller: category,
                          decoration: InputDecoration(
                              hintText: "Category",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              return null;
                            } else {
                              return "must fill";
                            }
                          },
                          controller: description,
                          decoration: InputDecoration(
                              hintText: "Description",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            //exit dialog box
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: ColorConstants.red, fontSize: 18),
                          )),
                      ElevatedButton(
                          onPressed: () async {
                            //add product to list
                            if (formkey.currentState!.validate()) {
                              Navigator.pop(context);

                              await context
                                  .read<HomescreenController>()
                                  .addProduct(
                                      title: title.text,
                                      price: double.parse(price.text),
                                      category: category.text,
                                      image: "",
                                      description: description.text);
                            }
                          },
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                color: ColorConstants.blue, fontSize: 18),
                          )),
                    ],
                  )
                ],
              );
            },
          );
        },
        child: Icon(
          Icons.add,
          size: 25,
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Home Screen",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorConstants.black,
            fontSize: 25,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Explore our products :",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.white,
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Consumer<HomescreenController>(
                builder: (context, provObj, child) => provObj.isProductLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                //navigate to details screen
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                        id: provObj.plist[index].id ?? 0,
                                      ),
                                    ));
                              },
                              child: Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                              provObj.plist[index].image ??
                                                  "")),
                                  title: Text(
                                    provObj.plist[index].title ?? "",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstants.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "${provObj.plist[index].price}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: ColorConstants.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                  trailing: InkWell(
                                    onTap: () async {
                                      //to delete product
                                      await context
                                          .read<HomescreenController>()
                                          .deleteProduct(
                                              id: "${provObj.plist[index].id ?? 0}");
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: ColorConstants.red,
                                      size: 26,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 15,
                            ),
                        itemCount: provObj.plist.length),
              )
            ],
          ),
        ),
      ),
    );
  }
}
