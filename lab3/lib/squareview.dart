import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:lab3/config.dart';
import 'package:lab3/details.dart';
import 'package:lab3/mainpage.dart';
import 'package:lab3/product.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class SquareView extends StatefulWidget {
  const SquareView({Key? key, }) : super(key: key);

  @override
  State<SquareView> createState() => _SquareViewState();
}

class _SquareViewState extends State<SquareView> {
  late double screenWidth, screenHeight, resWidth;
 late ScrollController _scrollController;
  final df = DateFormat('dd/MM/yyyy hh:mm a');
  int scrollcount = 5, rowcount = 2, numpr = 0;
  String titleCenter = "Loading Data...";
  List productList = [];

  @override
  void initState(){
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _loadProducts();
  }

  @override
   Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if(screenWidth <= 600){
      resWidth = screenWidth*0.85;
      rowcount = 2;
    }else{
      resWidth = screenWidth*0.75;
      rowcount = 3;
    }
    return Scaffold(
      appBar: AppBar(
      title: Row(
        children: [
          Center(child: Icon(Icons.home, size: resWidth*0.07)),
          Text(" KAKPAH NASI BERLAUK", 
              style: TextStyle(fontSize: resWidth*0.07)),
        ],
      ),
      backgroundColor: Colors.blue.shade900,
    ),
      body: productList.isEmpty
      ? Center(child: Text(titleCenter, style: const TextStyle()))
      : Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: resWidth/3,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 242, 242, 242),
                            Color.fromARGB(255, 252, 244, 245),
                          ],
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.blueGrey,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 1.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topRight,
                            child: SizedBox(
                              width: resWidth/2,
                              child: Image.asset('assets/images/kakpah.png',
                              fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(top: 35, left: 30),
                                child: Row(
                                  children: <Widget>[
                                    Text('Products Available:',
                                      style: TextStyle(fontSize: resWidth*0.07, fontWeight: FontWeight.bold, color: Colors.blueAccent.shade400)),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 0, left: 30),
                                child: Text(numpr.toString() + " products found",
                                  style: TextStyle(color: Colors.black, fontSize: resWidth*0.05)),
                                  ),
                            ]
                                ),
                        ]
                              ),
                     )) ],
                          ),
                        SizedBox(height: resWidth*0.05),
                        Expanded(
                        child: GridView.count(
                        crossAxisCount: rowcount,
                        controller: _scrollController,
                        children: List.generate(scrollcount, (index) {
                        return Padding(
                        padding: const EdgeInsets.all(1.0),
                      child: Card(
                      color: Colors.blue.shade700,
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 0,
                      child: InkWell(
                             onTap: () => {   _prUserDetails(index)
                             },
                      child: Column( children: [ 
                      Flexible(flex: 5,
                      child: CachedNetworkImage(
                      width: screenWidth, fit: BoxFit.cover,
                      imageUrl: MyConfig.server + "images/products/" + productList[index]['prid'].toString() + ".png",
                      imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      image: DecorationImage(
                      image: imageProvider, fit: BoxFit.cover),
                      )),
                      placeholder: (context, url) => const LinearProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                    ),
                    Flexible(flex: 5,
                    child: Padding(padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                            Center(
                              child: Text(truncateString(productList[index]['prname'].toString()),
                              style: TextStyle(fontSize: resWidth*0.042, fontWeight: FontWeight.bold,
                              color: Colors.black)),
                            ),
                            const SizedBox(height: 0.5,),
                            Text(truncateStringDesc(productList[index]['prdesc'].toString()),
                            style: TextStyle(fontSize: resWidth*0.035)),
                            Text("RM"+double.parse(productList[index]['prprice']).toStringAsFixed(2)+" - "+ productList[index]['prqty']+" bungkus in stock",
                            style: TextStyle(fontSize: resWidth*0.035)),
                            Text(df.format(DateTime.parse(productList[index]['prdate'])),
                            style: TextStyle(fontSize: resWidth*0.035)),
                                ]),
                                )),
                                ]),
                            )));
                        }),
                      ),
                    ),
          ]  ),
                ),
                 floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
                child: const Icon(Icons.horizontal_rule),
                label: "Change to Horizontal View", 
                labelStyle: const TextStyle(color: Colors.black),
                labelBackgroundColor: Colors.white,
                onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const MainPage()));        
                    }             
                  ),
                SpeedDialChild(
                child: const Icon(Icons.arrow_downward),
                label: "Scroll to the Bottom", 
                labelStyle: const TextStyle(color: Colors.black),
                labelBackgroundColor: Colors.white,
                onTap: scrollDown,
                  ),
                SpeedDialChild(
                child: const Icon(Icons.arrow_upward),
                label: "Scroll to the Top", 
                labelStyle: const TextStyle(color: Colors.black),
                labelBackgroundColor: Colors.white,
                onTap: scrollUp,
                  ),
          ],
    )
      );
  }

  String titleSub(String title) {
    if (title.length < 15) {
      return title.substring(0, 15) + "...";
    } else {
      return title;
    }
  }

  _loadProducts() {
    http.post(Uri.parse(MyConfig.server + "php/load_products.php"), 
    body: {
    }).then((response) {
      if(response.statusCode == 200 && response.body != "failed"){
        var extractdata = json.decode(response.body);
        setState(() {
          productList = extractdata["products"];
          numpr = productList.length;
          if (scrollcount >= productList.length) {
            scrollcount = productList.length;
          }
        });
      }else{
        setState((){
          titleCenter = "No Data";
        });
      }
    });
  }

  String truncateString(String str) {
      if(str.length > 20){
        str = str.substring(0,20);
        return str + "...";
      }else{
        return str;
      }
  }

  String truncateStringDesc(String str) {
      if(str.length > 25){
        str = str.substring(0,25);
        return str + "...";
      }else{
        return str;
      }
  }

  void _scrollListener() {
    if(_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange){
      setState(() {
        if(productList.length > scrollcount){
          scrollcount = scrollcount + 5;
        if(scrollcount > productList.length){
          scrollcount = productList.length;
        }
        }
      });
    }
  }

   _prUserDetails(int index) async {
    Product product = Product(
        prid: productList[index]['prid'],
        prname: productList[index]['prname'],
        prdesc: productList[index]['prdesc'],
        prprice: productList[index]['prprice'],
        prqty: productList[index]['prqty'],
        prdel: productList[index]['prdel'],
        prstate: productList[index]['prstate'],
        prloc: productList[index]['prloc'],
        prlat: productList[index]['prlat'],
        prlong: productList[index]['prlong'],
        prdate: productList[index]['prdate'],
        pridowner: productList[index]['pridowner'],
        user_email: productList[index]['user_email'],
        user_name: productList[index]['user_name'],
        user_phone: productList[index]['user_phone'],
        );
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => DetailsPage(product: product,)));
    _loadProducts();
  }

void scrollUp() {
    const double start = 0;
    _scrollController.animateTo(start, 
    duration: const Duration(seconds: 1), 
    curve: Curves.easeIn);
  }

  void scrollDown() {
    final double end = _scrollController.position.maxScrollExtent;
    _scrollController.animateTo(end, 
    duration: const Duration(seconds: 1), 
    curve: Curves.easeIn);
  }
}
