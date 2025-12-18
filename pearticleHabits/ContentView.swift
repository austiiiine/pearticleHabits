import SwiftUI

struct ContentView: View {
  @State private var appModel = AppModel()
  @State private var selectedTab: Int = 0

  // 自訂 title 顏色
  init() {
    // 上方 Nav
    let appearance = UINavigationBarAppearance()
    appearance.configureWithTransparentBackground()
    // 大標題（Large Title）顏色
    appearance.largeTitleTextAttributes = [
      .foregroundColor: UIColor(named: "forest")!
    ]
    // 一般標題（inline）顏色
    appearance.titleTextAttributes = [
      .foregroundColor: UIColor(named: "forest")!
    ]
    
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance

  }

  var body: some View {
    TabView(selection: $selectedTab) {
      CheckinView(selectedTab: $selectedTab)
        .tabItem { Label("打卡", systemImage: "checkmark.circle") }
        .tag(0)

      HabitListView(selectedTab: $selectedTab)
        .tabItem { Label("習慣", systemImage: "list.clipboard.fill") }
        .tag(1)

      RewardListView(selectedTab: $selectedTab)
        .tabItem { Label("獎勵", systemImage: "gift.fill") }
        .tag(2)

      SettingsView()
        .tabItem { Label("設定", systemImage: "gearshape") }
        .tag(3)
    }
//    TabView(selection: $selectedTab) {
//      CheckinView(selectedTab: $selectedTab)
//        .tabItem {
//          VStack {
//            Image("checkin")
//              .renderingMode(.template)
//            Text("打卡")
//          }
//        }
//        .tag(0)
//
//      HabitListView(selectedTab: $selectedTab)
//        .tabItem {
//          VStack {
//            Image("habits")
//              .renderingMode(.template)
//            Text("習慣")
//          }
//        }
//        .tag(1)
//
//      RewardListView(selectedTab: $selectedTab)
//        .tabItem {
//          VStack {
//            Image("rewards")
//              .renderingMode(.template)
//            Text("獎勵")
//          }
//        }
//        .tag(2)
//
//      SettingsView()
//        .tabItem {
//          VStack {
//            Image("settings")
//              .renderingMode(.template)
//            Text("設定")
//          }
//        }
//        .tag(3)
//    }
    .environment(appModel)
  }
}

#Preview {
    ContentView()
}
