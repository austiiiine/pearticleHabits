import SwiftUI
import ConfettiSwiftUI

struct RewardDetailView: View {
  @Environment(AppModel.self) var appModel
  @Environment(\.dismiss) var dismiss
  @Binding var selectedTab: Int

  let reward: Reward

  // 管理 alerts
  @State private var showRedeemAlert = false
  @State private var showEditSheet = false
  @State private var showDeleteAlert = false
  @State private var showErrorAlert = false

  // 梨子數不足的錯誤訊息
  @State private var errorMessage: String = ""

  // 編輯用(展示 hold 要編輯的獎勵的容器)
  @State private var editingReward: Reward

  // 用來 trigger Confetti
  @State private var trigger: Int = 0

  // Init（把 reward 帶進 editingReward）
  init(selectedTab: Binding<Int>, reward: Reward) {
    self._selectedTab = selectedTab
    self.reward = reward
    self._editingReward = State(initialValue: reward)
  }


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
            showRedeemAlert = true
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

      // Toolbar
      .toolbar {

        // 右上角選單
        ToolbarItem(placement: .navigationBarTrailing) {
          Menu {
            // 編輯獎勵
            Button {
              editingReward = reward   // 每次打開前重新同步
              showEditSheet = true
            } label: {
              Label("編輯獎勵", systemImage: "pencil")
            }

            // 刪除獎勵
            Button(role: .destructive) {
              showDeleteAlert = true
            } label: {
              Label("刪除獎勵", systemImage: "trash")
            }

          } label: {
            Image(systemName: "ellipsis")
              .font(.system(size: 18, weight: .semibold))
              .foregroundStyle(.forest)
          }
        }
      }

      // 編輯 sheet
      .sheet(isPresented: $showEditSheet) {
        EditRewardView(isPresented: $showEditSheet, reward: editingReward)
          .presentationDetents([.large])
          .presentationCornerRadius(24)
      }

      // 兌換確認 alert
      .alert("是否確認兌換獎勵？", isPresented: $showRedeemAlert) {
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
        Text("此操作無法復原，兌換的梨子無法退回喔！")
      }

      // 錯誤訊息 alert
      .alert("無法兌換獎勵", isPresented: $showErrorAlert) {
        Button("好") {}
      } message: {
        Text(errorMessage)
      }

      // 刪除確認 alert
      .alert("確定要刪除這個獎勵嗎？", isPresented: $showDeleteAlert) {
        Button("取消", role: .cancel) { }
        Button("刪除", role: .destructive) {
          if let index = appModel.rewards.firstIndex(where: { $0.id == reward.id }) {
            appModel.rewards.remove(at: index)
            dismiss()
          }
        }
      } message: {
        Text("此操作無法復原。")
      }

    }
    .confettiCannon(        // Confetti 效果
      trigger: $trigger,
      confettis: [.text("🍐")],
      confettiSize: 20,
      rainHeight: 600.0
    )

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
