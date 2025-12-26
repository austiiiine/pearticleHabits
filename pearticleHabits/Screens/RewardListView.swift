import SwiftUI
import ConfettiSwiftUI

struct RewardListView: View {
  @Environment(AppModel.self) var appModel
  @Binding var selectedTab: Int
  @State private var showingNewRewardSheet = false

  // 用來 trigger Confetti
  @State private var trigger: Int = 0

  var body: some View {
    NavigationStack {
      ZStack {
        Color(.white)
          .ignoresSafeArea()

        ScrollView {
          PearCounterView(
            selectedTab: $selectedTab,
            mode: .general(showButton: false)
          )
          .padding(.bottom, 20)

          VStack(spacing: 16) {
            ForEach(appModel.rewards) { reward in
              NavigationLink {
                RewardDetailView(
                  selectedTab: $selectedTab,
                  reward: reward
                )
                .toolbar(.hidden, for: .tabBar)
              } label: {
                RewardRowView(reward: reward, trigger: $trigger)
              }
            }
            .buttonStyle(.plain)
          }
        }
        .contentMargins(.horizontal, 16)
      }
      .navigationTitle("獎勵")
      .navigationBarTitleDisplayMode(.large)
      .confettiCannon(        // Confetti 效果
        trigger: $trigger,
        confettis: [.text("🍐")],
        confettiSize: 20,
        rainHeight: 600.0
      )
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            showingNewRewardSheet = true
          } label: {
            Image(systemName: "plus")
          }
          .tint(.forest)
        }
      }
      .sheet(isPresented: $showingNewRewardSheet) {
        NewRewardView(isPresented: $showingNewRewardSheet)
          .presentationDetents([.large])
          .presentationCornerRadius(24)
      }
    }
  }
}

#Preview {
  @Previewable @State var selectedTab = 0

  RewardListView(selectedTab: $selectedTab)
    .environment(AppModel())
}
