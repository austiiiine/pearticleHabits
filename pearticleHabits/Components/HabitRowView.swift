import SwiftUI

struct HabitRowView: View {
  @Environment(AppModel.self) var appModel

  let habit: Habit

  var body: some View {
    HStack(alignment: .center) {
      HStack(alignment: .center, spacing: 20) {
        VStack(alignment: .center) {
          Image(systemName: habit.icon)
          //          .resizable()
          //          .frame(width: 28, height: 28)
            .font(.system(size: 28, weight: .semibold))
            .foregroundStyle(habit.colorType.color)
        }
        .frame(width: 28)
        Text(habit.title)
          .foregroundStyle(Color("forest"))
          .font(.title3)
          .fontWeight(.semibold)
      }
      Spacer()
      HStack(alignment: .center, spacing: 16) {
        VStack(alignment: .trailing, spacing: 0) {
          Text(String(habit.pearCount))
            .font(.title3)
            .fontWeight(.bold)
            .foregroundStyle(.forest)
          Text("已累積")
            .font(.callout)
            .foregroundStyle(.forest)
        }
        Image(systemName: "chevron.right")
          .font(.system(size: 16, weight: .semibold))
          .foregroundStyle(.forest)
//        NavigationLink {
//          HabitDetailView(habit: habit)
//        } label: {
//          Image(systemName: "chevron.right")
//            .font(.system(size: 16, weight: .semibold))
//            .foregroundStyle(.forest)
//        }
//        .buttonStyle(.plain)
      }

    }
    .padding(.horizontal, 20)
    .padding(.vertical, 20)
    .frame(maxWidth: .infinity, alignment: .center)
    .cardStyle()
  }
}

#Preview {
  HabitRowView(habit:
    Habit(
      title: "畫畫",
      icon: "paintpalette.fill",
      colorType: .mustard,
      pearCount: 19,
      streakCount: 12
    )
  )
  .environment(AppModel())
}
