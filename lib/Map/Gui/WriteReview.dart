import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:parking_guide/Map/Json/Comment.dart';
import 'package:parking_guide/Map/RelativeSizes2.dart';

class Review extends StatefulWidget {
  final int ?garageId;
  const Review({Key? key,this.garageId}) : super(key: key);

  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  String? text;
  RequestJson ?commentData;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Row(
                children: [SizedBox(width: 300,),
                  TextButton(onPressed: () {
                    commentData?.addComment(1 , 'text');
                    FocusScope.of(context).requestFocus(FocusNode());
                    Navigator.pop(context);
                  }, child: Text('POST')),
                ],
              ),
              RatingBar.builder(
                updateOnDrag: false,
                initialRating: 1,
                itemSize: 20.0,
                minRating: 1,
                tapOnlyMode: false,
                ignoreGestures: false,
                unratedColor: Colors.grey.shade400,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.orange,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 30, left: 20),
                width: SizeConfig.width * 0.90,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: Colors.teal,
                    width: 1.0,
                  ),
                ),
                child: TextField(maxLines: null,
                  onChanged: (value) {
                    text = value;
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Describe your experiences (optional)',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
