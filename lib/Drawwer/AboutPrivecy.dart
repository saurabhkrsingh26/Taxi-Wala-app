import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:taxiwala/Constant/fontstyle.dart';

class AboutPrivecy extends StatefulWidget {
  const AboutPrivecy({super.key});

  @override
  State<AboutPrivecy> createState() => _AboutPrivecyState();
}

class _AboutPrivecyState extends State<AboutPrivecy> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height*0.1),
        child: AppBar(
          centerTitle: true,
          title: Text('Privecy policies',style: robotoBlackProfile),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: HtmlWidget(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
          ),
        ),
      ),
    );
  }
}
