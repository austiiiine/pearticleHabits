import SwiftUI

struct CheckinListCard: View {


  let habits: [Habit]

  var body: some View {
    VStack(spacing: 0) {
      ForEach(habits.indices, id: \.self) { index in
        CheckinRowView(habit: habits[index])

        if index != habits.indices.last {
          Divider()
        }
      }
    }
    .padding(.vertical, 4)
    .padding(.horizontal, 24)
    .cardStyle()
  }
}

#Preview{
  let habits = [
    Habit(
      title: "畫畫",
      icon: "paintpalette.fill",
      colorType: .mustard,
      pearCount: 19,
      streakCount: 12
    ),
    Habit(
      title: "吃保健品",
      icon: "pills.fill",
      colorType: .peach,
      pearCount: 7,
      streakCount: 5
    ),
    Habit(
      title: "健身",
      icon: "dumbbell.fill",
      colorType: .fern,
      pearCount: 42,
      streakCount: 35
    ),
    Habit(
      title: "喝水 1000 cc",
      icon: "drop.fill",
      colorType: .sky,
      pearCount: 28,
      streakCount: 21
    ),
    Habit(
      title: "閱讀 20 分鐘",
      icon: "book.fill",
      colorType: .lime,
      pearCount: 15,
      streakCount: 10
    )
  ]
  CheckinListCard(habits: habits)
}
