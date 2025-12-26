import SwiftUI

struct RewardRowView: View {
  @Environment(AppModel.self) var appModel
  @State private var showAlert = false

  // 錯誤訊息 alert
  @State private var showErrorAlert = false
  @State private var errorMessage: String = ""

  let reward: Reward
  
  // 用來接收&傳遞 confetti 的 trigger
  @Binding var trigger: Int

  var body: some View {
    HStack(alignment: .center) {
      HStack(alignment: .center, spacing: 16) {
        // icon
        VStack(alignment: .center) {
          Image(systemName: reward.icon)
            .font(.system(size: 28, weight: .semibold))
            .foregroundStyle(reward.colorType.color)
        }
        .frame(width: 28)

        VStack(alignment: .leading, spacing: 4) {
          Text(reward.title)
            .foregroundStyle(Color("forest"))
            .font(.title3)
            .fontWeight(.semibold)
          // 梨子價
          HStack(alignment: .center, spacing: 2) {
            Text("🍐")
              .font(.system(size: 16))
            Text(String(reward.cost))
              .font(.callout)
              .foregroundStyle(.forest)
          }
        }
      }
      Spacer(minLength: 12)
      HStack(alignment: .center, spacing: 12) {
        Button {
          showAlert = true
          // appModel.redeemReward(reward)
        } label: {
          RedeemButton(label: reward.redeemed ? "已兌換" : "兌換")
            .opacity(reward.redeemed ? 0.6 : 1.0)
        }
        .buttonStyle(.plain)
        .disabled(reward.redeemed)
        Image(systemName: "chevron.right")
          .font(.system(size: 16, weight: .semibold))
          .foregroundStyle(.forest)
      }
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 20)
    .frame(maxWidth: .infinity, alignment: .center)
    .cardStyle(background: .rice)

    // 兌換確認 alert
    .alert("是否確認兌換獎勵？", isPresented: $showAlert) {
      Button("取消", role: .cancel) {}
      Button("確認兌換") {
        if let error = appModel.redeemReward(reward) {
          errorMessage = error
          showErrorAlert = true
        } else {
          trigger += 1   // 觸發 confetti
        }
      }
    } message: {
      Text("此動作無法回復，兌換的梨子無法退回喔！")
    }

    // 錯誤訊息 alert
    .alert("無法兌換獎勵", isPresented: $showErrorAlert) {
      Button("好") {}
    } message: {
      Text(errorMessage)
    }

  }
}
