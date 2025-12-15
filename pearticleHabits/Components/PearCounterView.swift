import SwiftUI

// 用來切換計數器的不同 variant
enum PearCounterMode {
  case general(showButton: Bool)
  case habitStreak(pearCount: Int, streakCount: Int)
}
// generalButtonFalse - 對應mode：.general(showButton: false)
// generalButtonTrue - 對應mode：.general(showButton: true)
// HabitStreakTrue - 對應mode：.habitStreak(pearCount:, streakCount:)


struct PearCounterView: View {
  @Environment(AppModel.self) var appModel
  @Binding var selectedTab: Int   // 用來切換到「獎勵」tab

  let mode: PearCounterMode

  var body: some View {
    Group {
      switch mode {
      case .general(let showButton):
        generalView(showButton: showButton)

      case .habitStreak(let pearCount, let streakCount):
        habitStreakView(
          pearCount: pearCount,
          streakCount: streakCount
        )
      }
    }
    .padding(.horizontal, 28)
    .padding(.vertical, 28)
    .frame(maxWidth: .infinity, alignment: .leading)
    .cardStyle()
  }

  // general(showButton: Bool)
  private func generalView(showButton: Bool) -> some View {
    VStack(alignment: .leading, spacing: 12) {

      Text("可兌換梨子數")
        .font(.body)
        .fontWeight(.semibold)
        .foregroundStyle(.forest.opacity(0.7))

      HStack(alignment: .center) {
        countBlock(count: appModel.totalPearCount, icon: "🍐")

        if showButton {
          Spacer()

          Button {
            selectedTab = 2
          } label: {
            ExchangeButton(label: "前往兌換獎勵")
          }
          .buttonStyle(.plain)
        }
      }
    }
  }

  // habitStreak(pearCount, streakCount)
  private func habitStreakView(
    pearCount: Int,
    streakCount: Int
  ) -> some View {

    HStack {

      VStack(alignment: .leading, spacing: 12) {
        Text("累積梨子數")
          .font(.body)
          .fontWeight(.semibold)
          .foregroundStyle(.forest.opacity(0.7))

        countBlock(count: pearCount, icon: "🍐")
      }
      .frame(maxWidth: .infinity, alignment: .leading)

      Divider()
        .frame(height: 78)
        .padding(.horizontal, 20)

      VStack(alignment: .leading, spacing: 12) {
        Text("連續打卡天數")
          .font(.body)
          .fontWeight(.semibold)
          .foregroundStyle(.forest.opacity(0.7))

        countBlock(count: streakCount, icon: "🔥")
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
  }

  // 數字顯示元件
  private func countBlock(
    count: Int,
    icon: String
  ) -> some View {
    HStack(spacing: 8) {
      Text(icon)
        .font(.system(size: 32))

      Text("\(count)")
        .font(.system(size: 28, weight: .bold))
        .foregroundStyle(.forest)
    }
  }
}

#Preview {
  @Previewable @State var selectedTab: Int = 0

  let habit = Habit(
    title: "畫畫",
    icon: "paintpalette.fill",
    colorType: .mustard,
    pearCount: 19,
    streakCount: 12
  )

  let appModel = AppModel()

  VStack(spacing: 24) {

    // 1️⃣ generalButtonFalse
    PearCounterView(
      selectedTab: $selectedTab,
      mode: .general(showButton: false)
    )

    // 2️⃣ generalButtonTrue
    PearCounterView(
      selectedTab: $selectedTab,
      mode: .general(showButton: true)
    )

    // 3️⃣ HabitStreakTrue
    PearCounterView(
      selectedTab: $selectedTab,
      mode: .habitStreak(
        pearCount: habit.pearCount,
        streakCount: habit.streakCount
      )
    )

  }
  .padding()
  .background(Color(.rice))
  .environment(appModel)
}
