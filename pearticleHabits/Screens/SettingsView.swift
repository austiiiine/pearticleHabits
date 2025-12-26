import SwiftUI

struct SettingsView: View {
  @Environment(AppModel.self) var store

  var body: some View {
    NavigationStack {
      ZStack {
        Color.rice.ignoresSafeArea() // 背景顏色

        Form {
          Section {
            Button() {
              store.resetData()
            } label: {
              Label("恢復 Demo 資料", systemImage: "arrow.counterclockwise.circle")
            }

            Button(role: .destructive) {
              store.clearAllData()
            } label: {
              Label("清除所有資料", systemImage: "trash")
            }
          }
        }
        .scrollContentBackground(.hidden) // 隱藏原本 Form 的背景
      }
      .navigationTitle("設定")
    }
  }
}
