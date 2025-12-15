import SwiftUI

struct RewardDetailView: View {
  @Environment(AppModel.self) var appModel

  let reward: Reward

  var body: some View {
    VStack {
      Text(reward.title)
    }
  }
}
