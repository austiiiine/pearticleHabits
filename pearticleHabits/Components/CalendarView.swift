import SwiftUI

struct CalendarView: View {
  let habit: Habit

  // 現在顯示的月份（初始是今天）
  @State private var displayedMonth = Date()

  // 幫助轉換日期
  let calendar = Calendar.current
  let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
  }()

  var body: some View {
    VStack(spacing: 16) {
      // 顯示月份與左右切換按鈕
      HStack {
        Button(action: {
          displayedMonth = calendar.date(byAdding: .month, value: -1, to: displayedMonth) ?? displayedMonth
        }) {
          Image(systemName: "chevron.left")
            .font(.headline)
            .foregroundStyle(.forest)
        }

        Text(monthYearString(from: displayedMonth))
          .font(.headline)
          .foregroundStyle(.forest)
          .frame(maxWidth: .infinity)

        Button(action: {
          displayedMonth = calendar.date(byAdding: .month, value: 1, to: displayedMonth) ?? displayedMonth
        }) {
          Image(systemName: "chevron.right")
            .font(.headline)
            .foregroundStyle(.forest)
        }
      }
      .padding()
      .cardStyle()

      // 日曆格子（每月 1~31 號）
      let days = generateDays(for: displayedMonth)

      LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 12) {
        ForEach(days, id: \.self) { date in
          let dateKey = dateFormatter.string(from: date)
          let count = habit.records[dateKey] ?? 0

          ZStack {
            Circle()
              .fill(count > 0 ? .forest : Color.gray.opacity(0.15))
              .frame(width: 36, height: 36)

            if count > 0 {
              Text("\(count)")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.rice)
            }
          }
        }
      }
      .padding()
      .cardStyle()
    }
  }

  // 轉換成月份字串
  func monthYearString(from date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM yyyy"
    return formatter.string(from: date)
  }

  // 回傳這個月的所有天數（1~31）
  func generateDays(for month: Date) -> [Date] {
    guard let range = calendar.range(of: .day, in: .month, for: month),
          let firstDay = calendar.date(from: calendar.dateComponents([.year, .month], from: month)) else {
      return []
    }

    return range.compactMap { day in
      calendar.date(byAdding: .day, value: day - 1, to: firstDay)
    }
  }
}

#Preview {
  let sampleRecords: [String: Int] = [
    "2025-12-01": 1,
    "2025-12-03": 2,
    "2025-12-05": 1,
    "2025-12-10": 3,
    "2025-12-15": 1,
    "2025-12-17": 2,
    "2025-12-18": 1
  ]

  let fakeHabit = Habit(
    title: "早起",
    icon: "sunrise.fill",
    colorType: .mustard,
    pearCount: 10,
    streakCount: 5,
    records: sampleRecords
  )

  return CalendarView(habit: fakeHabit)
}
