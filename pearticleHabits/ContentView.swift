import SwiftUI

struct ContentView: View {
  @State private var appModel = AppModel()
  @State private var selectedTab: Int = 0

  // 自訂 title 顏色
  init() {
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

      HabitListView()
        .tabItem { Label("習慣", systemImage: "list.bullet") }
        .tag(1)

      RewardListView(selectedTab: $selectedTab)
        .tabItem { Label("獎勵", systemImage: "gift") }
        .tag(2)

      SettingsView()
        .tabItem { Label("設定", systemImage: "gearshape") }
        .tag(3)
    }
    .environment(appModel)
  }
}

#Preview {
    ContentView()
}
