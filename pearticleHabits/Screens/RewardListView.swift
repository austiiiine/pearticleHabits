import SwiftUI

struct RewardListView: View {
  @Environment(AppModel.self) var appModel
  @Binding var selectedTab: Int
  @State private var showingNewRewardSheet = false

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
                RewardRowView(reward: reward)
              }
            }
            .buttonStyle(.plain)
          }
        }
        .padding()
      }
      .navigationTitle("獎勵")
      .navigationBarTitleDisplayMode(.large)
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
