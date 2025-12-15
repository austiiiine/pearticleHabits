import SwiftUI

struct ContentView: View {
  @State private var appModel = AppModel()

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
    TabView {
      TrackerView()
        .tabItem { Label("打卡", systemImage: "checkmark.circle") }

      HabitListView()
        .tabItem { Label("習慣", systemImage: "list.bullet") }

      RewardListView()
        .tabItem { Label("獎勵", systemImage: "gift") }

      SettingsView()
        .tabItem { Label("設定", systemImage: "gearshape") }
    }
    .environment(appModel)
  }
}

#Preview {
    ContentView()
}
