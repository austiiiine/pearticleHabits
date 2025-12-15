import SwiftUI

struct CheckinRowView: View {
  let habit: Habit

  var body: some View {

    HStack(alignment: .center) {
      // 左側 icon + 文字
      HStack(alignment: .center, spacing: 20) {
        VStack(alignment: .center) {
          Image(systemName: habit.icon)
            .font(.system(size: 28, weight: .semibold))
            .foregroundStyle(habit.colorType.color)
        }
        .frame(width: 28)
        Text(habit.title)
          .foregroundStyle(Color(.forest))
          .font(.title3)
          .fontWeight(.semibold)
      }

      Spacer()

      // 左側數字 + 按鈕
      HStack(alignment: .center, spacing: 16) {
        VStack(alignment: .trailing) {
          Text(String(habit.pearCount))
            .font(.title3)
            .fontWeight(.bold)
            .foregroundStyle(.forest)
          Text("今日完成次數")
            .font(.callout)
            .foregroundStyle(.forest)
        }
        // 打卡按鈕
        Button {
          // 打卡 function
        } label: {
          Image(systemName: "plus")
            .font(.system(size: 18, weight: .bold))
            .foregroundStyle(.white)
            .frame(width: 36, height: 36)
            .background(.forest)
            .clipShape(Circle())
        }
      }

    }
    .padding(.vertical, 24)




  }
}

#Preview {
  CheckinRowView(habit: Habit(
    title: "畫畫",
    icon: "paintpalette.fill",
    colorType: .mustard,
    pearCount: 19,
    streakCount: 12
  ))
}
