import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeservice/logic/counter/counter_cubit.dart';
import 'package:homeservice/model/model.dart';
import 'package:homeservice/pages/sidemenu.dart';
import 'package:homeservice/repository/resgitration.repo.dart';
import 'package:homeservice/router/router.gr.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:marquee/marquee.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  List<String> img = [
    'https://firebasestorage.googleapis.com/v0/b/ehomeservice-722a5.appspot.com/o/electrician%20copy.jpg?alt=media&token=64e3a228-b9a2-4ea4-b288-8dbca4a40b2e',
    'https://firebasestorage.googleapis.com/v0/b/ehomeservice-722a5.appspot.com/o/hometutor%20copy.jpg?alt=media&token=c2e6ef9c-048f-4c6b-8747-24a545068f89',
    'https://firebasestorage.googleapis.com/v0/b/ehomeservice-722a5.appspot.com/o/wallpainter%20copy.jpg?alt=media&token=75ec65ce-9b0e-4f32-9217-a1b5b1a7997e',
  ];
  String getusername = '';
  String? usernamefinal;
  String userna = '';
  List<ItemModel> datalist = [];
  int _current = 0;

  @override
  void initState() {
    super.initState();
    getdata();
  }

  getdata() async {
    var _user = await ResgitrationRepo().Getdata();
    var data = await context.read<CounterCubit>().diskrepo.retrieve1();
    setState(() {
      datalist = _user!;
      userna = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      backgroundColor: const Color(0xff82868E),
      appBar: AppBar(title: const Text("Home Services Provider")),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffFFFBFB),
                Color(0xffEEEEEE),
              ],
            ),
          ),
          child: Column(children: [
            Expanded(
              flex: 24,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 5, top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Hello $userna",
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Popular Services ',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 94, 0),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                  CarouselSlider.builder(
                      itemBuilder: (context, index, realIndex) {
                        return Container(
                          margin: const EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: NetworkImage(img[index]),
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      },
                      itemCount: img.length,
                      options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: true,
                          viewportFraction: 0.70,
                          height: 200,
                          onPageChanged: (i, r) {
                            setState(() {
                              _current = i;
                            });
                          })),
                  AnimatedSmoothIndicator(
                    activeIndex: _current,
                    count: img.length,
                    effect: const WormEffect(
                        spacing: 8.0,
                        radius: 2.0,
                        dotWidth: 7.0,
                        dotHeight: 7.0,
                        paintStyle: PaintingStyle.stroke,
                        strokeWidth: 1.5,
                        activeDotColor: Colors.pinkAccent),
                  ),
                  SizedBox(
                    height: 30,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Marquee(
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 4, 8, 214),
                        ),

                        blankSpace: 200,

                        velocity: 150,

                        pauseAfterRound: const Duration(seconds: 1),
                        showFadingOnlyWhenScrolling: true,
                        //fadingEdgeStartFraction: 0.1,
                        //fadingEdgeEndFraction: 0.1,
                        startPadding: 11,
                        accelerationDuration: const Duration(seconds: 1),
                        accelerationCurve: Curves.linear,
                        decelerationDuration: const Duration(milliseconds: 600),
                        decelerationCurve: Curves.easeOut,

                        text: 'Choose Your Services According To Your Needs',
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text('Services',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 94, 0),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                            onPressed: () =>
                                context.router.push(AllserviceRoute()),
                            child: const Text(
                              'See all',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 221, 103, 241),
                                  fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 25,
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
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
                            height: 171,
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
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
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
            ),
            const SizedBox(
              height: 20,
            )
          ]),
        ),
      ),
    );
  }
}
