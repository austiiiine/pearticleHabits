import SwiftUI

struct HabitDetailView: View {
  @Environment(AppModel.self) var appModel
  @Environment(\.dismiss) var dismiss
  @Binding var selectedTab: Int

  let habit: Habit

  // 管理 alerts
  @State private var showRedeemAlert = false
  @State private var showEditSheet = false
  @State private var showDeleteAlert = false
  @State private var showErrorAlert = false

  // 錯誤訊息
  @State private var errorMessage: String = ""

  // 編輯用(展示 hold 要編輯的習慣的容器)
  @State private var editingHabit: Habit

  // 顯示今日次數用
  @State private var todayCount: Int = 0

  // Init（把 habit 帶進 editingHabit）
  init(selectedTab: Binding<Int>, habit: Habit) {
    self._selectedTab = selectedTab
    self.habit = habit
    self._editingHabit = State(initialValue: habit)
  }


  var body: some View {
    ZStack {
      Color(.rice)
        .ignoresSafeArea()

      ScrollView {
        VStack(alignment: .center) {
          VStack(alignment: .leading, spacing: 16) {
            // 標題
            HStack(alignment: .center) {
              Text(habit.title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.forest)
              Spacer()
              Image(systemName: habit.icon)
                .font(.system(size: 36))
                .foregroundStyle(habit.colorType.color)
            }
            .frame(maxWidth: .infinity, alignment: .center)

            VStack(spacing: 20) {

              // 本日打卡區
              VStack(alignment: .leading, spacing: 12) {

                // 子標題
                Text("本日打卡")
                  .font(.title2)
                  .bold()
                  .foregroundStyle(.forest)

                // 打卡區塊
                VStack(alignment: .leading, spacing: 16) {

                  // 打卡數字
                  HStack {
                    Text("本日打卡次數")
                      .font(.system(size: 18, weight: .semibold))
                      .foregroundStyle(.forest)
                    Spacer()
                    Text("\(todayCount)") // 之後改成今日次數
                      .font(.system(size: 18, weight: .bold))
                      .foregroundStyle(.forest)
                  }
                  .padding(.horizontal, 4)

                  // 打卡按鈕
                  HStack {

                    // 取消次數
                    Button {
                      appModel.subtractRecord(for: habit)
                      updateTodayCount() // 更新顯示次數
                    } label: {
                      CheckinButton(
                        label: "取消次數",
                        backgroundColor: .white
                      )
                    }

                    // 增加次數
                    Button {
                      appModel.addRecord(for: habit)
                      updateTodayCount() // 更新顯示次數
                    } label: {
                      CheckinButton(
                        label: "打卡",
                        backgroundColor: .lime
                      )
                    }

                  }
                }
                .padding(20)
                .cardStyle()
              }
              .frame(alignment: .topLeading)

              // 計數區
              VStack(alignment: .leading, spacing: 12) {
                // 子標題
                Text("累積情形")
                  .font(.title2)
                  .bold()
                  .foregroundStyle(.forest)

                // 計數器
                PearCounterView(
                  selectedTab: $selectedTab,
                  mode: .habitStreak(
                    pearCount: habit.pearCount,
                    streakCount: habit.streakCount
                  )
                )
              }

              // calendar view
              VStack(alignment: .leading, spacing: 12) {
                // 子標題
                Text("打卡總覽")
                  .font(.title2)
                  .bold()
                  .foregroundStyle(.forest)
                // calendar
                CalendarView(habit: habit)
              }

            }
            .padding(.top, 20)


            Spacer()

          }
        }
        .padding()
        .onAppear {
          updateTodayCount()
        }
      }


      // Toolbar
      .toolbar {

        // 右上角選單
        ToolbarItem(placement: .navigationBarTrailing) {
          Menu {
            // 編輯習慣
            Button {
              editingHabit = habit   // 每次打開前重新同步
              showEditSheet = true
            } label: {
              Label("編輯習慣", systemImage: "pencil")
            }

            // 刪除習慣
            Button(role: .destructive) {
              showDeleteAlert = true
            } label: {
              Label("刪除習慣", systemImage: "trash")
            }

          } label: {
            Image(systemName: "ellipsis")
              .font(.system(size: 18, weight: .semibold))
              .foregroundStyle(.forest)
          }
        }
      }

      // 編輯 sheet
      .sheet(isPresented: $showEditSheet) {
        EditHabitView(isPresented: $showEditSheet, habit: editingHabit)
          .environment(appModel)
          .presentationDetents([.large])
          .presentationCornerRadius(24)
      }


      // 錯誤訊息 alert
      .alert("無法兌換習慣", isPresented: $showErrorAlert) {
        Button("好") {}
      } message: {
        Text(errorMessage)
      }

      // 刪除確認 alert
      .alert("確定要刪除這個習慣嗎？", isPresented: $showDeleteAlert) {
        Button("取消", role: .cancel) { }
        Button("刪除", role: .destructive) {
          if let index = appModel.habits.firstIndex(where: { $0.id == habit.id }) {
            appModel.habits.remove(at: index)
            dismiss()
          }
        }
      } message: {
        Text("此操作無法復原。")
      }

    }

  }

  // 更新畫面
  func updateTodayCount() {
    let today = appModel.dateFormatter.string(from: Date())
    if let habitIndex = appModel.habits.firstIndex(where: { $0.id == habit.id }) {
      todayCount = appModel.habits[habitIndex].records[today, default: 0]
    }
  }

}


#Preview {
  @Previewable @State var selectedTab: Int = 0

  let habit = Habit(
    title: "喝水 1000 cc",
    icon: "drop.fill",
    colorType: .sky,
    pearCount: 28
  )

  HabitDetailView(selectedTab: $selectedTab, habit: habit)
  .environment(AppModel())
}
