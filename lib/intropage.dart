import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cameratwo.dart';

class Travelplanner extends StatefulWidget {


  Travelplanner({Key? key}) : super(key: key);

  @override
  State<Travelplanner> createState() => _TravelplannerState();
}

class _TravelplannerState extends State<Travelplanner> {
  double fem=0.7;
  double ffem= 0.7;
  @override
  Widget build(BuildContext context) {
    return  Container(
      // attractiondetailspagecQ3 (10:3372)
      padding:  EdgeInsets.fromLTRB(21*fem, 77.29*fem, 16*fem, 39*fem),
      width:  double.infinity,
      decoration:  BoxDecoration (
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
            margin:  EdgeInsets.fromLTRB(4.5*fem, 0*fem, 0*fem, 462*fem),
            width:  22.96*fem,
            height:  18.71*fem,
            child:
            Image(image: AssetImage('assets/images/kozi3.jpg'),),
          ),
          Text(
            // nordiccottageSnP (10:3374)
            'Automated QR SHOP',
            style:  GoogleFonts.andika(

              fontSize:  42*ffem,


              color:  Color(0xffffffff),
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
                color:  Color(0xccffffff),
              ),
            ),
          ),
          Container(
            // autogroup52kd7X9 (LzhV48jtttg2uB8sm252KD)
            margin:  EdgeInsets.fromLTRB(3.33*fem, 0*fem, 7*fem, 36*fem),
            width:  double.infinity,
            child:
            Row(
              crossAxisAlignment:  CrossAxisAlignment.center,
              children:  [
                Container(
                  // group128bhD (10:3376)
                  margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 5.67*fem, 1*fem),
                  width:  23.33*fem,
                  height:  12.67*fem,
                  child:
                  Image(image: AssetImage('lib/images/df.jpg'),),
                ),
                Container(
                  // group129TjR (10:3377)
                  margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 5.67*fem, 1*fem),
                  width:  13.33*fem,
                  height:  12.67*fem,
                  child:
                  Image(image: AssetImage('lib/images/df.jpg'),),
                ),
                Container(
                  // group130M47 (10:3378)
                  margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 5.67*fem, 1*fem),
                  width:  13.33*fem,
                  height:  12.67*fem,
                  child:
                  Image(image: AssetImage('lib/images/df.jpg'),),
                ),
                Container(
                  // group131qEB (10:3379)
                  margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 5.67*fem, 1*fem),
                  width:  13.33*fem,
                  height:  12.67*fem,
                  child:
                  Image(image: AssetImage('lib/images/df.jpg'),),
                ),
                Container(
                  // group1326A7 (10:3380)
                  margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 11.33*fem, 1*fem),
                  width:  13.33*fem,
                  height:  12.67*fem,
                  child:
                  Image(image: AssetImage('lib/images/df.jpg'),),
                ),
                Container(
                  // Afm (10:3381)
                  margin:  EdgeInsets.fromLTRB(0*fem, 1*fem, 1*fem, 0*fem),
                  child:
                  Text(
                    '4.79',
                    style:  GoogleFonts.poppins(

                      fontSize:  14*ffem,
                      fontWeight:  FontWeight.w400,
                      height:  1.6449999128*ffem/fem,
                      color:  Color(0xffffffff),
                    ),
                  ),
                ),
                Container(
                  // reviews3jZ (10:3383)
                  margin:  EdgeInsets.fromLTRB(0*fem, 1*fem, 58*fem, 0*fem),
                  child:
                  Text(
                    '(78 reviews)',
                    style:  GoogleFonts.poppins(

                      fontSize:  14*ffem,
                      fontWeight:  FontWeight.w400,
                      height:  1.6449999128*ffem/fem,
                      color:  Color(0xccffffff),
                    ),
                  ),
                ),

              ],
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
                color:  Color(0xffffffff),
                borderRadius:  BorderRadius.circular(41*fem),
              ),
              child:
              Center(
                child:
                GestureDetector(
                  child: Text(
                    'Click HERE',
                    style:  GoogleFonts.poppins(

                      fontSize:  16*ffem,
                      fontWeight:  FontWeight.w500,
                      height:  1.6449999809*ffem/fem,
                      color:  Color(0xff000000),
                    ),
                  ),
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => QRScannerPaget()));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
