import Observation
import SwiftUI

@Observable
class AppModel {
  var habits: [Habit] = []
  var rewards: [Reward] = []

  // 總累積梨子數
  var totalPearCount: Int {
    habits.reduce(0) { $0 + $1.pearCount }
  }
  // reduce(0) -> 起始值 = 0
  // { $0 + $1.pearCount } 等同於
  // { (result: Int, habit: Habit) -> Int in
  //      return result + habit.pearCount
  // }

  init() {
    // 假資料
    habits = [
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

    rewards = [
      Reward(
        title: "吃提拉米蘇",
        icon: "birthday.cake.fill",
        colorType: .mustard,
        cost: 7
      ),
      Reward(
        title: "買手機殼",
        icon: "iphone.gen3",
        colorType: .sky,
        cost: 30
      )
    ]
  }
}
