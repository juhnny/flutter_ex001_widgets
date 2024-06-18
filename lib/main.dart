import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// MyApp에서 정의된 앱을 실행하라고 Flutter에 지시
// MyApp의 코드는 전체 앱을 설정합니다. 앱 전체 상태를 생성하고, 앱의 이름을 지정하고, 시각적 테마를 정의하고 '홈' 위젯(앱의 시작점)을 설정합니다.
void main() {
  runApp(const MyApp());
}

// 위젯은 모든 Flutter 앱을 빌드하는 데 사용되는 요소. 앱 자체도 위젯이다.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange)
        ),
      home: MyHomePage(),
    ));
  }
}

// MyAppState 클래스는 앱의 상태를 정의
// Flutter에는 앱 상태를 관리하는 강력한 방법이 여러 가지 있습니다. 설명하기 가장 쉬운 것 중 하나는 이 앱에서 사용하는 접근 방식인 ChangeNotifier입니다.
// 상태 클래스는 ChangeNotifier를 확장합니다. 즉, 자체 변경사항에 관해 다른 항목에 알릴 수 있습니다.
// 상태가 만들어지고 ChangeNotifierProvider를 사용하여 전체 앱에 제공됩니다(위의 MyApp 코드 참고). 이렇게 하면 앱의 위젯이 상태를 알 수 있습니다.
class MyAppState extends ChangeNotifier {
  var currentPair = WordPair.random();

  // 임의의 새 WordPair를 currentPair에 재할당
  void getNext() {
    currentPair = WordPair.random();
    notifyListeners(); // MyAppState를 보고 있는 사람에게 알림을 보내는 ChangeNotifier의 메서드
  }
}

class MyHomePage extends StatelessWidget {
  Widget build(BuildContext context) { // 모든 위젯은 위젯이 항상 최신 상태로 유지되도록 위젯의 상황이 변경될 때마다 자동으로 호출되는 build() 메서드를 정의합니다.
    var appState = context.watch<MyAppState>(); // MyHomePage는 watch 메서드를 사용하여 앱의 현재 상태에 관한 변경사항을 추적합니다.

    return Scaffold( // 모든 build 메서드는 위젯 또는 중첩된 위젯 트리(좀 더 일반적임)를 반환해야 합니다.
      body: Column(
        children: [
          Text('A random AWESOME idea:'),
          Text(appState.currentPair.asPascalCase), // asLowerCase, asSnakeCase

          ElevatedButton (
              onPressed: () {
                appState.getNext();
                // print('button pressed');
              },
              child: Text('Next')
          ), // 일반적으로 후행 쉼표를 사용하는 것이 좋습니다. 멤버를 더 추가하는 작업이 쉬워지고 Dart의 자동 형식 지정 도구에서 줄바꿈을 추가하도록 힌트 역할을 합니다.
        ],
      )
    );
  }
}

