import 'package:camera/shop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cameratwo.dart';

class Travelplanner extends StatefulWidget {


  const Travelplanner({Key? key}) : super(key: key);

  @override
  State<Travelplanner> createState() => _TravelplannerState();
}

class _TravelplannerState extends State<Travelplanner> {
  double fem=0.7;
  double ffem= 0.7;
  @override
  Widget build(BuildContext context) {
    return  ListView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics()
      ),
      children: [
        Container(
          // attractiondetailspagecQ3 (10:3372)
          padding:  EdgeInsets.fromLTRB(21*fem, 77.29*fem, 16*fem, 39*fem),
          width:  double.infinity,
          decoration:  const BoxDecoration (
            color:  Color(0xffffffff),
            image:  DecorationImage (
              fit:  BoxFit.cover,
              image:  AssetImage('lib/images/df.jpg'),
            ),
          ),
          child:
          Column(
            crossAxisAlignment:  CrossAxisAlignment.start,
            children:  [
              Container(
                // autogroupfzgxPp7 (LzhUptcxmvrVZXqVyWFZgX)
                margin:  EdgeInsets.fromLTRB(4.5*fem, 0*fem, 0*fem, 200*fem),
                width:  152.96*fem,

                child:
                Image(image: AssetImage('lib/images/logo.jpg'),),
              ),
              Text(
                // nordiccottageSnP (10:3374)
                'Automated QR SHOP',
                style:  GoogleFonts.andika(

                  fontSize:  42*ffem,


                  color:  const Color(0xffffffff),
                ),
              ),
              Container(
                // bluelagoondrivefromreykjavkthe (10:3375)

                child:
                Text(
                  'Shop smarter with our innovative shop management app! With our app, you can easily create unique QR codes for each of your products, allowing customers to quickly scan and add items to their cart using their smartphones. Say goodbye to the hassle of managing paper inventory and hello to a more streamlined shopping experience for you and your customers. Download our app today and start taking your shop management to the next level!',
                  style:  GoogleFonts.poppins(

                    fontSize:  20*ffem,
                    fontWeight:  FontWeight.w400,
                    height:  1.6449999809*ffem/fem,
                    color:  const Color(0xccffffff),
                  ),
                ),
              ),

              Container(
                // autogroup54v7ZbR (LzhVdXwuguNmpjCCxD54v7)
                margin:  EdgeInsets.fromLTRB(3*fem, 0*fem, 7*fem, 0*fem),
                width:  double.infinity,
                height:  54*fem,
                child:
                Container(
                  // autogroupmhnsskX (LzhVvGy1j92z5iCHWaMHns)
                  width:  168*fem,
                  height:  double.infinity,
                  decoration:  BoxDecoration (
                    color:  const Color(0xffffffff),
                    borderRadius:  BorderRadius.circular(41*fem),
                  ),
                  child:
                  Center(
                    child:
                    GestureDetector(
                      child: Text(
                        'GET STARTED',
                        style:  GoogleFonts.poppins(

                          fontSize:  16*ffem,
                          fontWeight:  FontWeight.w500,
                          height:  1.6449999809*ffem/fem,
                          color:  const Color(0xff000000),
                        ),
                      ),
                     // onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => MyAppp()));
                     onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => QRScannerPaget()));
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}



class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Center(
            child: Column(

              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Image.asset(
                      'lib/images/df.jpg',height: 250,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Smart Scan Shop',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.deepPurple[700]),
                ),
                const SizedBox(height: 12),
                Text(
                  'Shop smarter with our innovative shop management app! With our app, you can easily create unique QR codes for each of your products, allowing customers to quickly scan and add items to their cart using their smartphones. Say goodbye to the hassle of managing paper inventory and hello to a more streamlined shopping experience for you and your customers. Download our app today and start taking your shop management to the next level!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),


                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RHomePage()));
                    Navigator.push(context, MaterialPageRoute(builder: (context) => QRScannerPaget()));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple[700] ,               padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text(
                    "Start here",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

