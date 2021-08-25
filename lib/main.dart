import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_math/flutter_math.dart';
import 'package:provider/provider.dart';
import 'package:wecc/controllwe/provider.dart';
import 'package:wecc/view/widget/botoumNav.dart';
import 'package:woocommerce/woocommerce.dart';
import 'key.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(home: Splash());
        } else {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: BottonNav(),
            builder: EasyLoading.init(),
          );
        }
      },
    );
  }
}

String baseUrl = 'https://toyzeetoys.com/';
String consumerKey = "ck_981649ec00c094997c8c3a3ef7572f1eca5b9132";
String consumerSecret = "cs_3866e2581fd47da5106e266a40afd0f05aad6b6a";

WooCommerce wooCommerce = WooCommerce(
  baseUrl: baseUrl,
  consumerKey: consumerKey,
  consumerSecret: consumerSecret,
  isDebug: true,
);

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<WooProduct> products = [];
  List<WooProduct> featuredProducts = [];
  getProducts() async {
    products = await wooCommerce.getProducts();
    var catog = await wooCommerce.getProductCategories();
    print("this is all $catog");
    setState(() {});
    print(products.toString());
  }

  @override
  void initState() {
    GetDa.getData();
    super.initState();
    // You would want to use a feature builder instead.
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  'My Awesome Shop',
                  style: Theme.of(context)
                      .textTheme
                      .headline
                      .apply(color: Colors.blueGrey),
                ),
              ),
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (itemWidth / itemHeight),
                mainAxisSpacing: 2,
                crossAxisSpacing: 1,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final product = products[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      InkWell(
                        onTap: () async {
                          final myCart = await woocommerce.addToMyCart(
                              quantity: '2', itemId: '35862');
                          WooOrderPayload orderPayload =
                              WooOrderPayload(customerId: 23, setPaid: true);
                          var order =
                              await woocommerce.createOrder(orderPayload);
                        },
                        child: Container(
                          height: 30,
                          width: 200,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  product.images[0].src,
                                ),
                                fit: BoxFit.cover),
                            color: Colors.pinkAccent,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          //child: Image.network(product.images[0].src, fit: BoxFit.cover,),
                        ),
                      ),
                      Html(data: product.shortDescription, customRender: {
                        "tex": (_, __, ___, element) => Math.tex(
                              element.text,
                              onErrorFallback: (FlutterMathException e) {
                                //return your error widget here e.g.
                                return Text(e.message);
                              },
                            ),
                      }),
                      //Text(product.shortDescription.toString()?? 'Loading...',),
                      //Text('\$'+product.price?? '', style: Theme.of(context).textTheme.subtitle,)
                    ],
                  );
                },
                childCount: products.length,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget htmlWidget = Html(
      data:
          r"""<tex>i\hbar\frac{\partial}{\partial t}\Psi(\vec x,t) = -\frac{\hbar}{2m}\nabla^2\Psi(\vec x,t)+ V(\vec x)\Psi(\vec x,t)</tex>""",
      customRender: {
        "tex": (_, __, ___, element) => Math.tex(
              element.text,
              onErrorFallback: (FlutterMathException e) {
                //return your error widget here e.g.
                return Text(e.message);
              },
            ),
      });
}

class Init {
  Init._();
  static final instance = Init._();
  Future initialize() async {
    await Future.delayed(Duration(seconds: 3));
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff7f7f7),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('assets/m1.jpeg'),
      )),
    );
  }
}
