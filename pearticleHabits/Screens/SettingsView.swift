import SwiftUI

struct SettingsView: View {
  @Environment(AppModel.self) var store
  
  var body: some View {
    Form {
      Section("資料重置") {
        Button(role: .destructive) {
          store.resetData()
        } label: {
          Label("重置所有資料", systemImage: "arrow.counterclockwise.circle")
        }
      }
    }
    .navigationTitle("設定")
  }
}
