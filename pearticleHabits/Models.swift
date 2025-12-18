import Foundation
import SwiftUI

// 習慣項目
struct Habit: Identifiable, Codable {
  var id: UUID = UUID()
  var title: String
  var icon: String
  var colorType: ColorType

  var pearCount: Int = 0 // 習慣已累積貼紙數
  // var streakCount: Int = 0 // 連續打卡天數

  // 每天打卡計數
  var records: [String: Int] = [:] // 用 DateFormatter 轉存

  // 動態計算 streak
  var streakCount: Int {
    calculateStreak()
  }

  func calculateStreak() -> Int {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.timeZone = .current

    var streak = 0
    var currentDate = Date()

    while true {
      let key = formatter.string(from: currentDate)

      if let count = records[key], count != 0 {
        streak += 1
      } else {
        break
      }

      guard let previousDay = Calendar.current.date(byAdding: .day, value: -1, to: currentDate) else {
        break
      }
      currentDate = previousDay
    }

    return streak
  }
}

// 獎勵項目
struct Reward: Identifiable, Codable, Equatable {
  var id: UUID = UUID()
  var title: String
  var icon: String
  var colorType: ColorType
  var cost: Int // 需要多少貼紙兌換
  var redeemed: Bool = false // 是否已兌換
}

// 設定顏色物件
enum ColorType: String, Codable {
  case fern
  case forest
  case lime
  case mustard
  case peach
  case rice
  case sky
}

extension ColorType {
  var color: Color {
    switch self {
      case .fern:
        return Color("fern")
      case .forest:
        return Color("forest")
      case .lime:
        return Color("lime")
      case .mustard:
        return Color("mustard")
      case .peach:
        return Color("peach")
      case .rice:
        return Color("rice")
      case .sky:
        return Color("sky")
    }
  }
}
