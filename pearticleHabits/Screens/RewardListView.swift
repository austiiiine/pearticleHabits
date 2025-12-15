import SwiftUI

struct RewardListView: View {
  @Environment(AppModel.self) var appModel
  @Binding var selectedTab: Int

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
            //            ForEach(appModel.rewards) { reward in
            //              RewardRowView(reward: reward)
            //            }
            ForEach(appModel.rewards) { reward in
              NavigationLink {
                RewardDetailView(reward: reward)
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
            print("Add reward tapped")
          } label: {
            Image(systemName: "plus")
          }
          .tint(.forest)
        }
      }
    }
  }
}

#Preview {
  @Previewable @State var selectedTab = 0

  RewardListView(selectedTab: $selectedTab)
    .environment(AppModel())
}
