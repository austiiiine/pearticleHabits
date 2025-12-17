import SwiftUI

struct EditHabitView: View {
  @Environment(AppModel.self) var appModel
  let icons = AppModel.icons

  @Binding var isPresented: Bool
  let originalHabit: Habit  // 新增：傳入要編輯的原始 habit

  // @State 用來暫存修改中的資料
  @State private var title: String
  @State private var icon: String
  @State private var colorType: ColorType

  @State private var showCancelAlert = false

  var isFormValid: Bool {
    !title.trimmingCharacters(in: .whitespaces).isEmpty && !icon.isEmpty
  }

  // 將傳入的原始 habit 初始化為 @State 值
  init(isPresented: Binding<Bool>, habit: Habit) {
    self._isPresented = isPresented
    self.originalHabit = habit
    self._title = State(initialValue: habit.title)
    self._icon = State(initialValue: habit.icon)
    self._colorType = State(initialValue: habit.colorType)
  }

  var body: some View {
    NavigationStack {
      ZStack {
        Color(.rice)
          .ignoresSafeArea()

        ScrollView {
          VStack(spacing: 24) {
            // 名稱
            VStack(alignment: .leading) {
              Text("編輯名稱")
                .font(.title3)
                .bold()
                .foregroundStyle(.forest)
              TextField("輸入名稱", text: $title)
                .frame(height: 28)
                .padding(10)
                .background(.white)
                .cornerRadius(99)
                .cardStyle()
            }

            // Icon 選擇
            VStack(alignment: .leading) {
              Text("選擇圖示")
                .font(.title3)
                .bold()
                .foregroundStyle(.forest)
              ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5)) {
                  ForEach(icons, id: \.self) { currentIcon in
                    Image(systemName: currentIcon)
                      .font(.system(size: 24))
                      .foregroundStyle(.forest.opacity(0.9))
                      .frame(width: 40, height: 40)
                      .padding(6)
                      .background(.forest.opacity(currentIcon == icon ? 0.2 : 0))
                      .cornerRadius(99)
                      .onTapGesture {
                        icon = currentIcon
                      }
                  }
                }
              }
              .frame(height: 180)
              .scrollIndicators(.visible)
              .padding()
              .cardStyle()
            }

            // 顏色選擇
            VStack(alignment: .leading) {
              Text("選擇顏色")
                .font(.title3)
                .bold()
                .foregroundStyle(.forest)
              LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 6)) {
                ForEach([ColorType.forest, .mustard, .lime, .sky, .peach, .fern], id: \.self) { color in
                  Circle()
                    .fill(color.color)
                    .frame(width: 40, height: 40)
                    .overlay(
                      Circle()
                        .inset(by: -2.5)
                        .stroke(.forest.opacity(color == colorType ? 0.2 : 0), lineWidth: 6)
                    )
                    .onTapGesture {
                      colorType = color
                    }
                }
              }
              .padding()
              .cardStyle()
            }
          }
          .padding()
          .padding(.top, -50)
          .frame(maxWidth: .infinity, alignment: .top)
        }
      }

      // 工具列
      .toolbar {
        // 取消編輯
        ToolbarItem(placement: .cancellationAction) {
          Button {
            showCancelAlert = true
          } label: {
            Image(systemName: "xmark")
          }
          .tint(.forest)
        }

        // 標題
        ToolbarItem(placement: .principal) {
          Text("編輯習慣")
            .font(.headline)
            .foregroundStyle(.forest)
        }

        // 儲存修改
        ToolbarItem(placement: .confirmationAction) {
          Button {
            saveChanges()
            isPresented = false
          } label: {
            Image(systemName: "checkmark")
          }
          .tint(.forest)
          .disabled(!isFormValid)
        }
      }

      // 取消警告
      .alert("確定要取消編輯？", isPresented: $showCancelAlert) {
        Button("取消", role: .cancel) { }
        Button("確定", role: .destructive) {
          isPresented = false
        }
      }
    }
  }

  // 儲存修改內容
  func saveChanges() {
    if let index = appModel.habits.firstIndex(where: { $0.id == originalHabit.id }) {
      appModel.habits[index].title = title
      appModel.habits[index].icon = icon
      appModel.habits[index].colorType = colorType
    }
  }
}

#Preview {
  EditHabitView(
    isPresented: .constant(true),
    habit: Habit(
      title: "早起運動",
      icon: "figure.walk",
      colorType: .forest
    )
  )
  .environment(AppModel())
}
