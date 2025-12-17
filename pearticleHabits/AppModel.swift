import Observation
import SwiftUI

@Observable
class AppModel {
  var habits: [Habit] = []
  var rewards: [Reward] = []
  var redeemablePearCount: Int = 0 // 可兌換梨子數

  private let habitsKey = "habitsKey"
  private let rewardsKey = "rewardsKey"
  private let redeemableKey = "redeemablePearKey"

  static let icons: [String] = [
    "paintpalette.fill",
    "pills.fill",
    "dumbbell.fill",
    "drop.fill",
    "book.fill",
    "birthday.cake.fill",
    "smartphone",
    "gift.fill",
    "headphones.over.ear",
    "figure.walk",
    "figure.run",
    "figure.cooldown",
    "leaf.fill",
    "star.fill",
    "moon.fill",
    "flame.fill"
  ]

  init() {
    if UserDefaults.standard.data(forKey: habitsKey) == nil {
      initializeFakeData()
      saveData()
    }
    loadData()
  }

  /// 把假資料寫入狀態中
  func initializeFakeData() {
    habits = [
      Habit(title: "畫畫", icon: "paintpalette.fill", colorType: .mustard, pearCount: 19, streakCount: 12),
      Habit(title: "吃保健品", icon: "pills.fill", colorType: .peach, pearCount: 7, streakCount: 5),
      Habit(title: "健身", icon: "dumbbell.fill", colorType: .fern, pearCount: 42, streakCount: 35),
      Habit(title: "喝水 1000 cc", icon: "drop.fill", colorType: .sky, pearCount: 28, streakCount: 21),
      Habit(title: "閱讀 20 分鐘", icon: "book.fill", colorType: .lime, pearCount: 15, streakCount: 10)
    ]
    rewards = [
      Reward(title: "吃提拉米蘇", icon: "birthday.cake.fill", colorType: .mustard, cost: 7),
      Reward(title: "買手機殼", icon: "smartphone", colorType: .sky, cost: 30)
    ]
    redeemablePearCount = habits.reduce(0) { $0 + $1.pearCount }
  }

  /// 清除所有資料並重新初始化
  func resetData() {
    // 移除儲存資料
    UserDefaults.standard.removeObject(forKey: habitsKey)
    UserDefaults.standard.removeObject(forKey: rewardsKey)
    UserDefaults.standard.removeObject(forKey: redeemableKey)

    // 清空目前狀態
    habits = []
    rewards = []
    redeemablePearCount = 0

    // 重設假資料
    initializeFakeData()
    saveData()
  }

  // MARK: - 儲存與載入（用 UserDefaults）
  func saveData() {
    let encoder = JSONEncoder()
    if let habitData = try? encoder.encode(habits) {
      UserDefaults.standard.set(habitData, forKey: habitsKey)
    }
    if let rewardData = try? encoder.encode(rewards) {
      UserDefaults.standard.set(rewardData, forKey: rewardsKey)
    }
    UserDefaults.standard.set(redeemablePearCount, forKey: redeemableKey)
  }

  func loadData() {
    let decoder = JSONDecoder()

    if let habitData = UserDefaults.standard.data(forKey: habitsKey),
       let decodedHabits = try? decoder.decode([Habit].self, from: habitData) {
      habits = decodedHabits
    }

    if let rewardData = UserDefaults.standard.data(forKey: rewardsKey),
       let decodedRewards = try? decoder.decode([Reward].self, from: rewardData) {
      rewards = decodedRewards
    }

    redeemablePearCount = UserDefaults.standard.integer(forKey: redeemableKey)
  }

  // 總累積梨子數
  var totalPearCount: Int {
    habits.reduce(0) { $0 + $1.pearCount }
  }
  // reduce(0) -> 起始值 = 0
  // { $0 + $1.pearCount } 等同於
  // { (result: Int, habit: Habit) -> Int in
  //      return result + habit.pearCount
  // }

//  init() {
//    // 假資料
//    habits = [
//      Habit(
//        title: "畫畫",
//        icon: "paintpalette.fill",
//        colorType: .mustard,
//        pearCount: 19,
//        streakCount: 12
//      ),
//      Habit(
//        title: "吃保健品",
//        icon: "pills.fill",
//        colorType: .peach,
//        pearCount: 7,
//        streakCount: 5
//      ),
//      Habit(
//        title: "健身",
//        icon: "dumbbell.fill",
//        colorType: .fern,
//        pearCount: 42,
//        streakCount: 35
//      ),
//      Habit(
//        title: "喝水 1000 cc",
//        icon: "drop.fill",
//        colorType: .sky,
//        pearCount: 28,
//        streakCount: 21
//      ),
//      Habit(
//        title: "閱讀 20 分鐘",
//        icon: "book.fill",
//        colorType: .lime,
//        pearCount: 15,
//        streakCount: 10
//      )
//    ]
//
//    rewards = [
//      Reward(
//        title: "吃提拉米蘇",
//        icon: "birthday.cake.fill",
//        colorType: .mustard,
//        cost: 7
//      ),
//      Reward(
//        title: "買手機殼",
//        icon: "iphone.gen3",
//        colorType: .sky,
//        cost: 30
//      )
//    ]
//  }

  // String 到 date轉換器
  let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"  // 像這樣的 key：2025-12-15
    formatter.locale = Locale(identifier: "en_US_POSIX")  // 避免地區格式混亂
    return formatter
  }()

  // 新增打卡次數
  func addRecord(for habit: Habit) {
    let today = dateFormatter.string(from: Date())
    if let index = habits.firstIndex(where: { $0.id == habit.id }) {
      habits[index].records[today, default: 0] += 1
      habits[index].pearCount += 1          // 成就
      redeemablePearCount += 1               // 可兌換
    }

    saveData()
  }

  // 減少打卡次數
  func subtractRecord(for habit: Habit) {
    let today = dateFormatter.string(from: Date())

    guard let index = habits.firstIndex(where: { $0.id == habit.id }) else { return }

    // 取得目前今日次數，沒有的話當作 0
    let currentCount = habits[index].records[today] ?? 0

    // 若當日紀錄為 0 或尚未記錄，就不進行減少
    guard currentCount > 0 else { return }

    // 同步減少打卡數
    habits[index].records[today] = currentCount - 1

    // pearCount 也同步減少，但不能小於 0
    if habits[index].pearCount > 0 {
      habits[index].pearCount -= 1
    }

    // 總 redeemablePearCount 也要同步減少，但不能小於 0
    if redeemablePearCount > 0 {
      redeemablePearCount -= 1
    }

    saveData()
  }

  // 兌換獎勵
  // 回傳 Bool 表示是否兌換成功
  @discardableResult
  // 回傳 nil 表示成功，否則是錯誤訊息
  func redeemReward(_ reward: Reward) -> String? {
    guard let index = rewards.firstIndex(where: { $0.id == reward.id }) else { return "找不到獎勵" }
    guard !rewards[index].redeemed else { return "此獎勵已兌換" }
    guard redeemablePearCount >= reward.cost else { return "梨子數不足，無法兌換" }

    redeemablePearCount -= reward.cost
    rewards[index].redeemed = true
    saveData()
    return nil
  }

}

