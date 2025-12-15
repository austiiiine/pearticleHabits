import SwiftUI

struct CheckinView: View {
  @Environment(AppModel.self) var store
  
  var body: some View {
    Text("打卡")
      .font(.title)
  }
}
