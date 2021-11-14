import 'package:flutter/material.dart';

const TextStyle menuFontStyle = TextStyle(color: Colors.white, fontSize: 20);
final Color backGroundColor = Color(0xFF343442);

class MenuDashBoard extends StatefulWidget {
  const MenuDashBoard({Key? key}) : super(key: key);

  @override
  State<MenuDashBoard> createState() => _MenuDashBoardState();
}

class _MenuDashBoardState extends State<MenuDashBoard>
    with SingleTickerProviderStateMixin {
  late double ekranYuksekligi;
  late double ekranGenisligi;
  bool menuAcikmi = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _scaleMenuAnimation;

  late Animation<Offset> _menuOffsetAnimation;
  Duration _duration = const Duration(microseconds: 500);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _duration);
    _scaleAnimation =
        Tween<double>(begin: 1, end: 0.6).animate(_animationController);
    _menuOffsetAnimation = Tween<Offset>(
      begin: Offset(-1, 0),
      end: Offset(0, 0),
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
    _scaleMenuAnimation =
        Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ekranGenisligi = MediaQuery.of(context).size.width;
    ekranYuksekligi = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backGroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            menuOlustur(context),
            dashBoardOlurs(context),
          ],
        ),
      ),
    );
  }

  Widget menuOlustur(BuildContext context) {
    return SlideTransition(
      position: _menuOffsetAnimation,
      child: ScaleTransition(
        scale: _scaleMenuAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Dashboard",
                  style: menuFontStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Mesajlar",
                  style: menuFontStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Utility Bills",
                  style: menuFontStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Fund Transfer",
                  style: menuFontStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dashBoardOlurs(BuildContext context) {
    return AnimatedPositioned(
      // top: menuAcikmi ? 0.1 * ekranYuksekligi : 0,
      // bottom: menuAcikmi ? 0.1 * ekranGenisligi : 0,
      top: 0,
      bottom: 0,
      left: menuAcikmi ? 0.4 * ekranGenisligi : 0,
      right: menuAcikmi ? -0.4 * ekranGenisligi : 0,
      duration: _duration,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: backGroundColor,
          child: Container(
            padding: const EdgeInsets.only(right: 16, left: 16, top: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (menuAcikmi) {
                            _animationController.reverse();
                          } else {
                            _animationController.forward();
                          }
                          menuAcikmi = menuAcikmi ? false : true;
                        });
                      },
                      child: Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "My Card",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 250,
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        color: Colors.red,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      Container(
                        color: Colors.blue,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      Container(
                        color: Colors.teal,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      Container(
                        color: Colors.yellow,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return  ListTile(
                          leading: const Icon(Icons.person),
                          title: Text("Öğrenci ${index+1}"),
                          trailing: Icon(Icons.add),
                
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(height: 4,color: Colors.red,),
                      itemCount: 50),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
