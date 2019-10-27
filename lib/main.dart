import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Banner, BannerLocation;
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:universal_html/prefer_universal/html.dart' as html;
import 'package:personal_web/widget/banner.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark));

    return MaterialApp(
      title: '少年阿涛',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.white,
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            elevation: 0,
          )),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
                child: ClipRect(
                  child: Banner(
                      message: "程序员",
                      location: BannerLocation.topEnd,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[_buildAvatarInfo(), _buildAppList()],
                      )),
                ))));
  }

  _buildAvatarInfo() {
    double size = 128;
    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 36),
            child: CircleAvatar(
              radius: size / 2,
              backgroundImage:
                  Image.asset("images/avatar.jpg", width: size, height: size)
                      .image,
            )),
        Padding(
            padding: EdgeInsets.only(top: 18, bottom: 48),
            child: Text("少年阿涛", style: TextStyle(fontSize: 24)))
      ],
    );
  }

  _buildAppList() {
    List<App> apps = [];
    apps.add(App(
        path: "images/ic_github.png",
        name: "Github",
        subTitle: "关注我的开源项目",
        link: "https://github.com/taoszu"));

    apps.add(App(
        path: "images/ic_juejin.png",
        name: "掘金社区",
        subTitle: "浏览我的最新博客",
        link: "https://juejin.im/user/590943745c497d0058547b57/posts"));

    List<Widget> widgets = [];
    apps.forEach((app) {
      widgets.add(Container(
        height: 88,
        child: Center(
            child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: Image.asset(app.path, width: 28, height: 28).image,
          ),
          title: Text(app.name),
          subtitle: Text(app.subTitle),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            _launchUrl(app.link);
          },
        )),
      ));
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: widgets,
    );
  }

  _launchUrl(String url) async {
    if (kIsWeb) {
      html.window.open(url, "");
    } else {
      if (await canLaunch(url)) {
        await launch(url);
      }
    }
  }
}

class App {
  App(
      {@required this.path,
      @required this.name,
      @required this.subTitle,
      @required this.link});

  final String path;
  final String name;
  final String subTitle;
  final String link;
}
