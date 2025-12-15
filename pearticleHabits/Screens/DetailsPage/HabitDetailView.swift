import SwiftUI

struct HabitDetailView: View {
  @Environment(AppModel.self) var appModel

  let habit: Habit

  var body: some View {
    VStack {
      Text(habit.title)
    }
  }
}
