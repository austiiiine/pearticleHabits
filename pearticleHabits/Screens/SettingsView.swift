import SwiftUI

struct SettingsView: View {
  @Environment(AppModel.self) var store
  
  var body: some View {
    Text("設定")
      .font(.title)
  }
}
