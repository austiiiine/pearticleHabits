import SwiftUI

struct HabitListView: View {
  @Environment(AppModel.self) var appModel

  var body: some View {
    NavigationStack {
      ZStack {
        Color(.rice)
          .ignoresSafeArea()

        //        HStack() {
        //          Text("習慣")
        //            .font(.title)
        //            .foregroundStyle(Color(.forest))
        //          Spacer()
        //          Image("plus")
        //            .font(.system(size: 16, weight: .semibold))
        //        }

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
            print("Add habit tapped")
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
  HabitListView()
    .environment(AppModel())
}
