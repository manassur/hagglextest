import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DoMoreWidget extends StatefulWidget {
  DoMoreWidget({Key? key}) : super(key: key);

  @override
  _DoMoreWidgetState createState() => _DoMoreWidgetState();
}

class _DoMoreWidgetState extends State<DoMoreWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            InkWell(
              child: ListItems(
                title: "Send Money instantly",
                description: "Send crypto from another wallet",
                icon: "assets/006-send.png",
              ),
              onTap: () {},
            ),
            InkWell(
              child: ListItems(
                title: "Receive money from anyone",
                description: "Receive crypto from another wallet",
                icon: "assets/send_down.png",
              ),
              onTap: () {},
            ),
            InkWell(
              child: ListItems(
                title: "Virtual Card",
                description: "Make faster payments using HaggleX cards",
                icon: "assets/008-card.png",
              ),
              onTap: () {},
            ),
            InkWell(
              child: ListItems(
                title: "Global Remittance",
                description: "Send money to anyone, anywhere",
                icon: "assets/009-globe.png",
              ),
              onTap: () {},
            ),
          ],
        ));
  }
}

class ListItems extends StatefulWidget {
  ListItems({Key? key, this.title, this.description, this.icon})
      : super(key: key);
  final String? title;
  final String? description;
  final String? icon;

  @override
  _ListItemsState createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      height: 90,
      padding: EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7.0),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 8.0,
              spreadRadius: 5,
              offset: Offset(2, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 20),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(70.0),
                color: Color(0xff2E1963).withOpacity(0.1)),
            child: Center(
              child: Image.asset(
                widget.icon!,
                color: Color(0xff2E1963),
                height: 25,
                width: 25.0,
                alignment: Alignment.center,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.title!,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w600)),
              SizedBox(
                height: 5,
              ),
              Text(
                widget.description!,
                style: TextStyle(color: Colors.black, fontSize: 10),
              ),
            ],
          )
        ],
      ),
    );
  }
}
