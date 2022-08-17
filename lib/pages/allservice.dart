import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:homeservice/model/model.dart';
import 'package:homeservice/repository/resgitration.repo.dart';
import 'package:homeservice/router/router.gr.dart';

class AllservicePage extends StatefulWidget {
  const AllservicePage({Key? key}) : super(key: key);

  @override
  State<AllservicePage> createState() => _AllservicePageState();
}

class _AllservicePageState extends State<AllservicePage> {
  List<String> image = [
    'https://firebasestorage.googleapis.com/v0/b/ehomeservice-722a5.appspot.com/o/plumber.jpg?alt=media&token=99b884f6-ee01-43b3-be4e-28e15123da94',
    'https://firebasestorage.googleapis.com/v0/b/ehomeservice-722a5.appspot.com/o/carpenter.jpg?alt=media&token=24b8c99e-fad8-4e19-87cb-c512ab479898',
    'https://firebasestorage.googleapis.com/v0/b/ehomeservice-722a5.appspot.com/o/tutor.jpg?alt=media&token=d26f9c94-d500-4dd5-bdb4-09fd88b29eb2',
    'https://firebasestorage.googleapis.com/v0/b/ehomeservice-722a5.appspot.com/o/Beautician.jpg?alt=media&token=38443053-06f6-4f8b-9e5c-ae0975ababbd',
    'https://firebasestorage.googleapis.com/v0/b/ehomeservice-722a5.appspot.com/o/gardener.jpg?alt=media&token=027f6950-27f2-4b43-933f-bbd7e9e82be2',
    'https://firebasestorage.googleapis.com/v0/b/ehomeservice-722a5.appspot.com/o/electronics.jpg?alt=media&token=62bf96f7-8162-4372-a52b-967ab753acf2',
    'https://firebasestorage.googleapis.com/v0/b/ehomeservice-722a5.appspot.com/o/electrician.jpg?alt=media&token=690654ef-a7f9-421a-a001-f85f2c88e760',
    'https://firebasestorage.googleapis.com/v0/b/ehomeservice-722a5.appspot.com/o/painter.jpg?alt=media&token=46af3d13-781e-45d3-994b-3d827fabe10d'
  ];
  List<ItemModel> datalist = [];
  @override
  void initState() {
    super.initState();
    getdata();
  }

  getdata() async {
    var _user = await ResgitrationRepo().Getdata();
    setState(() {
      datalist = _user!;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Services'),
      ),
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
            itemBuilder: (BuildContext ctx, index) {
              return InkWell(
                onTap: () {
                  switch (datalist[index].id) {
                    case 1:
                      {
                        context.router.push(DetailRoute(
                            data: datalist[index].data,
                            title: datalist[index].text,
                            serviceimage: image[index]));
                      }
                      break;
                    case 2:
                      {
                        context.router.push(DetailRoute(
                            data: datalist[index].data,
                            title: datalist[index].text,
                            serviceimage: image[index]));
                      }
                      break;
                    case 3:
                      {
                        context.router.push(DetailRoute(
                            data: datalist[index].data,
                            title: datalist[index].text,
                            serviceimage: image[index]));
                      }
                      break;
                    case 4:
                      {
                        context.router.push(DetailRoute(
                            data: datalist[index].data,
                            title: datalist[index].text,
                            serviceimage: image[index]));
                      }
                      break;
                    case 5:
                      {
                        context.router.push(DetailRoute(
                            data: datalist[index].data,
                            title: datalist[index].text,
                            serviceimage: image[index]));
                      }
                      break;
                    case 6:
                      {
                        context.router.push(DetailRoute(
                            data: datalist[index].data,
                            title: datalist[index].text,
                            serviceimage: image[index]));
                      }
                      break;
                    case 7:
                      {
                        context.router.push(DetailRoute(
                            data: datalist[index].data,
                            title: datalist[index].text,
                            serviceimage: image[index]));
                      }
                      break;
                    case 8:
                      {
                        context.router.push(DetailRoute(
                            data: datalist[index].data,
                            title: datalist[index].text,
                            serviceimage: image[index]));
                      }
                      break;

                    default:
                      print('This is Default');
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    color: Colors.white,
                    height: 170,
                    width: 170,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          image[index],
                          cacheHeight: 120,
                          cacheWidth: 120,
                          fit: BoxFit.fill,
                          filterQuality: FilterQuality.high,
                        ),
                        Text(
                          datalist[index].text,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            shrinkWrap: true,
            itemCount: datalist.length,
          ),
        ),
      ),
    );
  }
}
