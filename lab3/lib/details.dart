import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lab3/config.dart';
import 'package:lab3/product.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class DetailsPage extends StatefulWidget {
  final Product product;

  const DetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late double screenHeight, screenWidth, resWidth;
  final df = DateFormat('dd/MM/yyyy hh:mm a');
  File? _image;
  var pathAsset = "assets/images/camera.png";
  bool editForm = false;
  bool isPressed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('PRODUCT DETAILS'),
        backgroundColor: Colors.blue.shade900,
        actions: [
          IconButton(onPressed: (){
               setState((){
                  isPressed= true;
                });                    
             }, icon: const Icon(FontAwesomeIcons.solidHeart, 
             color: Colors.red
          ))
        ],
      ),
      body: Stack(
        children: [
          SizedBox(
              width: resWidth,
              child: Stack(
                clipBehavior: Clip.none, fit: StackFit.expand,
                children: [
                  Column(
                  children: [
                    const SizedBox(height: 10),
                    SizedBox(
                          width: screenWidth,
                          child: Text(widget.product.prname.toString(),
                          style: TextStyle(fontSize: resWidth*0.07, color: Colors.blueAccent.shade100, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                    ),
                    SizedBox(height: screenHeight*0.165),
                        Expanded(
                          child: SizedBox(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent.shade100,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),)
                            ),  
                          child: SingleChildScrollView(
                            child: Column(                                            
                                            children: [
                                              SizedBox(height: screenHeight*0.15),
                                            Table(
                                              columnWidths: const{
                                                0: FractionColumnWidth(0.3),
                                                1: FractionColumnWidth(0.05),
                                                2: FractionColumnWidth(0.65)
                                              },
                                              defaultVerticalAlignment: TableCellVerticalAlignment.top,         
                                        children: [
                                          TableRow(
                                            children: [
                                               Text("Product ID",
                                               style: TextStyle(fontSize: resWidth*0.05, color: Colors.black, fontWeight: FontWeight.bold)),
                                               Text(":", style: TextStyle(fontSize: resWidth*0.05, color: Colors.black, fontWeight: FontWeight.bold)),
                                               Text(widget.product.prid.toString(),
                                               style: TextStyle(fontSize: resWidth*0.05, color: Colors.black),
                                              ),
                                            ]), 
                                            const TableRow(
                                            children: [
                                               SizedBox(height:10),SizedBox(height:10),SizedBox(height:10),
                                            ]),  
                                          TableRow(
                                            children: [
                                               Text("Description",
                                               style: TextStyle(fontSize: resWidth*0.05, color: Colors.black, fontWeight: FontWeight.bold)),
                                               Text(":", style: TextStyle(fontSize: resWidth*0.05, color: Colors.black, fontWeight: FontWeight.bold)),
                                               Text(widget.product.prdesc.toString(), textAlign: TextAlign.justify,
                                               style: TextStyle(fontSize: resWidth*0.05, color: Colors.black),
                                              ),
                                            ]), 
                                            const TableRow(
                                            children: [
                                               SizedBox(height:10),SizedBox(height:10),SizedBox(height:10),
                                            ]),  
                                            TableRow(
                                            children: [
                                            Text("Price",
                                              style: TextStyle(fontSize: resWidth*0.05, color: Colors.black, fontWeight: FontWeight.bold),
                                              ),
                                           Text(":", style: TextStyle(fontSize: resWidth*0.05, color: Colors.black, fontWeight: FontWeight.bold)),
                                           Text("RM" + double.parse(widget.product.prprice.toString(),).toStringAsFixed(2),
                                            style: TextStyle(fontSize: resWidth*0.05, color: Colors.black),
                                            ),
                                            ]), 
                                             const TableRow(
                                            children: [
                                               SizedBox(height:10),SizedBox(height:10),SizedBox(height:10),
                                            ]),  
                                          TableRow(
                                            children: [
                                            Text("Availability",
                                              style: TextStyle(fontSize: resWidth*0.05, color: Colors.black, fontWeight: FontWeight.bold),
                                              ),
                                           Text(":", style: TextStyle(fontSize: resWidth*0.05, color: Colors.black, fontWeight: FontWeight.bold)),
                                           Text(widget.product.prqty.toString() + " bungkus",
                                            style: TextStyle(fontSize: resWidth*0.05, color: Colors.black),
                                            ),
                                            ]),
                                             const TableRow(
                                            children: [
                                               SizedBox(height:10), SizedBox(height:10),SizedBox(height:10),
                                            ]),  
                                             TableRow(
                                            children: [
                                            Text("Delivery Charge/km",
                                              style: TextStyle(fontSize: resWidth*0.05, color: Colors.black, fontWeight: FontWeight.bold),
                                              ),
                                           Text(":", style: TextStyle(fontSize: resWidth*0.05, color: Colors.black, fontWeight: FontWeight.bold)),
                                           Text("RM" + double.parse(widget.product.prdel.toString(),).toStringAsFixed(2),
                                            style: TextStyle(fontSize: resWidth*0.05, color: Colors.black),
                                            ),
                                            ]), 
                                            const TableRow(
                                             children: [
                                               SizedBox(height:10), SizedBox(height:10),SizedBox(height:10),
                                            ]),
                                             TableRow(
                                            children: [
                                            Text("Location",
                                              style: TextStyle(fontSize: resWidth*0.05, color: Colors.black, fontWeight: FontWeight.bold),
                                              ),
                                           Text(":", style: TextStyle(fontSize: resWidth*0.05, color: Colors.black, fontWeight: FontWeight.bold)),
                                           Text(widget.product.prloc.toString() + " , " + widget.product.prstate.toString(),
                                            style: TextStyle(fontSize: resWidth*0.05, color: Colors.black),
                                            ),
                                            ]), 
                                            const TableRow(
                                             children: [
                                               SizedBox(height:10), SizedBox(height:10),SizedBox(height:10),
                                            ]),
                                             TableRow(
                                            children: [
                                            Text("Coordinate",
                                              style: TextStyle(fontSize: resWidth*0.05, color: Colors.black, fontWeight: FontWeight.bold),
                                              ),
                                           Text(":", style: TextStyle(fontSize: resWidth*0.05, color: Colors.black, fontWeight: FontWeight.bold)),
                                           Text(double.parse(widget.product.prlat.toString(),).toStringAsFixed(4) + " , " + double.parse(widget.product.prlong.toString(),).toStringAsFixed(4),
                                            style: TextStyle(fontSize: resWidth*0.05, color: Colors.black),
                                            ),
                                            ]), 
                                            const TableRow(
                                             children: [
                                               SizedBox(height:10), SizedBox(height:10),SizedBox(height:10),
                                            ]),
                                             TableRow(
                                            children: [
                                            Text("Phone Number",
                                              style: TextStyle(fontSize: resWidth*0.05, color: Colors.black, fontWeight: FontWeight.bold),
                                              ),
                                           Text(":", style: TextStyle(fontSize: resWidth*0.05, color: Colors.black, fontWeight: FontWeight.bold)),
                                           Text(widget.product.user_phone.toString(),
                                            style: TextStyle(fontSize: resWidth*0.05, color: Colors.black),
                                            ),
                                            ]), 
                                            const TableRow(
                                             children: [
                                               SizedBox(height:10), SizedBox(height:10),SizedBox(height:10),
                                            ]),
                                             TableRow(
                                            children: [
                                            Text("Date",
                                              style: TextStyle(fontSize: resWidth*0.05, color: Colors.black, fontWeight: FontWeight.bold),
                                              ),
                                           Text(":", style: TextStyle(fontSize: resWidth*0.05, color: Colors.black, fontWeight: FontWeight.bold)),
                                           Text(df.format(DateTime.parse(widget.product.prdate.toString())),
                                            style: TextStyle(fontSize: resWidth*0.05, color: Colors.black),
                                            ),
                                            ]), 
                                            const TableRow(
                                             children: [
                                               SizedBox(height:10), SizedBox(height:10),SizedBox(height:10),
                                            ]),
                                        ],
                            ),
                                  SizedBox(height: screenWidth*0.01),
                                  Column(
                                    children: [
                                      SizedBox(
                                          height: 80,
                                          width: 80,
                                          child: IconButton(
                                              onPressed: () => { _showMapDialogue()},
                                              icon: const Icon(Icons.map_outlined))),
                                    ],
                                  )
                                            ]),
                            ),
                            ),
                          ),
                        ),
                        ],
                ),
                Column(
                children: [
                SizedBox(height: screenHeight*0.09),
                SizedBox(
                  height: screenHeight / 3.5,
                  width: screenWidth*0.5,
                                  child: GestureDetector(
                                    onTap: null,
                                    child: Container(
                                       decoration: BoxDecoration(
                                       shape: BoxShape.circle,
                                       image: DecorationImage(
                                        image: _image == null
                                            ? NetworkImage(MyConfig.server + "images/products/" + widget.product.prid.toString() + ".png")
                                            : FileImage(_image!) as ImageProvider,
                                        fit: BoxFit.contain
                                      ),
                                      border: Border.all(
                                      color: Colors.blue.shade900,
                                      width: 8,
                                      ),
                                     ),
                                   ),
                                 ))]
                 )]),    
            )],
       ));
  }

  int generateIds() {
    var rng = Random();
    int randomInt;
    randomInt = rng.nextInt(100);
    return randomInt;
  }

  void _showMapDialogue() {
    Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
    Completer<GoogleMapController> _controller = Completer();
    CameraPosition prlocation = CameraPosition(
      target: LatLng(double.parse(widget.product.prlat.toString()),
          double.parse(widget.product.prlong.toString())),
      zoom: 15.4746,
    );

    int markerIdVal = generateIds();
    MarkerId markerId = MarkerId(markerIdVal.toString());
    final Marker marker = Marker(
        markerId: markerId,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: LatLng(
          double.parse(widget.product.prlat.toString()),
          double.parse(widget.product.prlong.toString()),
        ),
        infoWindow: InfoWindow(
          title: widget.product.prname.toString(),
        ));
    markers[markerId] = marker; 

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "Location",
            style: TextStyle(),
          ),
          content: SizedBox(
            height: screenHeight / 2,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: prlocation,
              myLocationEnabled: true,
              markers: Set<Marker>.of(markers.values),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Close",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}