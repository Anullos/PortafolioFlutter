import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portafolio_flutter/src/presentation/proyects/movies/config/app_text_styles.dart';
import 'package:portafolio_flutter/src/presentation/proyects/movies/movies_view.dart';
import 'package:portafolio_flutter/src/presentation/proyects/movies/widgets/dot_tab_indicator.dart';

class MovieMainPage extends StatefulWidget {
  const MovieMainPage({Key? key}) : super(key: key);

  @override
  _MovieMainPageState createState() => _MovieMainPageState();
}

class _MovieMainPageState extends State<MovieMainPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.black,
          labelStyle: AppTextStyles.labelStyle,
          unselectedLabelStyle: AppTextStyles.unselectedLabelStyle,
          indicatorColor: Colors.blue,
          indicator: const DotIndicator(),
          tabs: [
            Tab(text: 'Movie'),
            Tab(text: 'Series'),
            Tab(text: 'TV Shows'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MoviesView(),
          SizedBox.expand(),
          SizedBox.expand(),
        ],
      ),
    );
  }
}
