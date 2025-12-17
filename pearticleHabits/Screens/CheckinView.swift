import SwiftUI

struct CheckinView: View {
  @Environment(AppModel.self) var store
  @Binding var selectedTab: Int

  @State private var showingNewHabitSheet = false

  var body: some View {
    NavigationStack {
      ZStack {
        Color(.rice)
          .ignoresSafeArea()

        ScrollView {
          PearCounterView(
            selectedTab: $selectedTab,
            mode: .general(showButton: true)
          )
          .padding(.bottom, 20)

          CheckinListCard(
            habits: store.habits
          )
        }
        .padding()

      }
      .navigationTitle("打卡")
      .navigationBarTitleDisplayMode(.large)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            showingNewHabitSheet = true
          } label: {
            Image(systemName: "plus")
          }
          .tint(.forest)
        }
      }
      .sheet(isPresented: $showingNewHabitSheet) {
        NewHabitView(isPresented: $showingNewHabitSheet)
          .presentationDetents([.large])
          .presentationCornerRadius(24)
      }
    }
  }
}

#Preview {
  @Previewable @State var selectedTab = 0

  CheckinView(selectedTab: $selectedTab)
    .environment(AppModel())
}
