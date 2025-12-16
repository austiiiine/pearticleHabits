import SwiftUI

struct RewardDetailView: View {
  @Environment(AppModel.self) var appModel
  @Binding var selectedTab: Int

  let reward: Reward

  var body: some View {
    ZStack {
      Color(.white)
        .ignoresSafeArea()

      VStack(alignment: .center) {
        VStack(alignment: .leading, spacing: 16) {
          // 標題
          HStack(alignment: .center) {
            Text(reward.title)
              .font(.title)
              .fontWeight(.bold)
              .foregroundStyle(.forest)
            Spacer()
            Image(systemName: reward.icon)
              .font(.system(size: 36))
              .foregroundStyle(reward.colorType.color)
          }
          .frame(maxWidth: .infinity, alignment: .center)

          // 計數器
          PearCounterView(
            selectedTab: $selectedTab,
            mode: .general(showButton: false)
          )

          // 兌換按鈕
          Button {
            appModel.redeemReward(reward)
          } label: {
            HStack(alignment: .center, spacing: 8) {
              Image(systemName: "app.gift")
                .font(.system(size: 20))
                .foregroundStyle(.forest)

              Text("用 \(reward.cost) 個梨子兌換獎勵")
                .font(.body)
                .fontWeight(.bold)
                .foregroundStyle(.forest)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(12)
            .background(.lime)
            .clipShape(Capsule())
            .overlay(
              RoundedRectangle(cornerRadius: 99)
                .inset(by: 0.5)
                .stroke(Color.forest.opacity(0.35), lineWidth: 1)
            )
            .opacity(reward.redeemed ? 0.6 : 1.0)
          }
          .buttonStyle(.plain)
          .disabled(reward.redeemed)

          Spacer()

        }
      }
      .padding()
    }
  }
}

#Preview {
  @Previewable @State var selectedTab: Int = 2   // 給一個假 tab 狀態

  let reward = Reward(
    title: "吃提拉米蘇",
    icon: "birthday.cake.fill",
    colorType: .mustard,
    cost: 7
  )

  RewardDetailView(
    selectedTab: $selectedTab,
    reward: reward
  )
  .environment(AppModel())
}
