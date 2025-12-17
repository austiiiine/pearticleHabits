import SwiftUI

struct HabitListView: View {
  @Environment(AppModel.self) var appModel
  
  @State private var showingNewHabitSheet = false

  var body: some View {
    NavigationStack {
      ZStack {
        Color(.rice)
          .ignoresSafeArea()

        ScrollView {
          VStack(spacing: 16) {
            //            ForEach(appModel.habits) { habit in
            //              HabitRowView(habit: habit)
            //            }
            ForEach(appModel.habits) { habit in
              NavigationLink {
                HabitDetailView(habit: habit)
              } label: {
                HabitRowView(habit: habit)
              }
            }
            .buttonStyle(.plain)
          }
        }
        .padding()
      }
      .navigationTitle("習慣")
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
  HabitListView()
    .environment(AppModel())
}
