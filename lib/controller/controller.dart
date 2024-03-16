import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Controller with ChangeNotifier {
  List<String> images = [
    "https://www.bing.com/th?id=OADD2.10239315184108_1ZDLD2KO4ZF4CGCQO&pid=21.2&c=16&roil=0&roit=0.0348&roir=1&roib=0.9652&w=268&h=140&dynsize=1&qlt=90",
    "https://th.bing.com/th?id=ORMS.ef6f8a3f20ceb0f7ae0c3dbdae80733f&pid=Wdp&w=300&h=156&qlt=90&c=1&rs=1&dpr=1.25&p=0",
    "https://th.bing.com/th?id=ORMS.66a62229764c320a8d627ccd7ee51580&pid=Wdp&w=300&h=156&qlt=90&c=1&rs=1&dpr=1.25&p=0",
    "https://www.bing.com/th?id=OADD2.7353105520034_1GDKVNOZ9R5V03SCO6&pid=21.2&c=3&w=300&h=157&dynsize=1&qlt=90",
    "https://th.bing.com/th?id=ORMS.a46413c245d19fcd6bb25ccb04fefef4&pid=Wdp&w=300&h=156&qlt=90&c=1&rs=1&dpr=1.25&p=0",
    "https://th.bing.com/th?id=ORMS.611948f792884fb135461bc36d41557d&pid=Wdp&w=300&h=156&qlt=90&c=1&rs=1&dpr=1.25&p=0"
  ];
  int selectedIndex = 0;
  PageController pageController = PageController();
  open(int index) {
    selectedIndex = index;

    notifyListeners();
  }

  Future<XFile?> pickImageOrVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickMedia();
    return pickedFile;
  }
}
