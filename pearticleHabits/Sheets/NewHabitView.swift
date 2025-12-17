import SwiftUI

struct NewHabitView: View {
  @Environment(AppModel.self) var appModel
  let icons = AppModel.icons

  @Binding var isPresented: Bool
  @State private var title = ""
  @State private var icon = ""
  @State private var colorType: ColorType

  @State private var showCancelAlert = false

  var isFormValid: Bool {
    !title.trimmingCharacters(in: .whitespaces).isEmpty && !icon.isEmpty
  }

  init(isPresented: Binding<Bool>, colorType: ColorType = .forest) {
    self._isPresented = isPresented
    self._colorType = State(initialValue: colorType)
  }

  var body: some View {
    NavigationStack {
      ZStack {
        Color(.rice)
          .ignoresSafeArea()

        ScrollView {
          VStack(spacing: 24) {
            // 輸入名稱
            VStack(alignment: .leading) {
              Text("輸入名稱")
                .font(.title3)
                .bold()
                .foregroundStyle(.forest)
              TextField("輸入名稱", text: $title)
                .frame(height: 28)
                .padding(10)
                .background(.white)
                .cornerRadius(99)
                .cardStyle()
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

            // 選擇顏色
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
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button {
            showCancelAlert = true
          } label: {
            Image(systemName: "xmark")
          }
          .tint(.forest)
        }

        ToolbarItem(placement: .principal) {
          Text("新增習慣")
            .font(.headline)
            .foregroundStyle(.forest)
        }

        ToolbarItem(placement: .confirmationAction) {
          Button {
            saveHabit()
            isPresented = false
          } label: {
            Image(systemName: "checkmark")
          }
          .tint(.forest)
          .disabled(!isFormValid)
        }
      }
      .alert("確定要取消新增獎勵？", isPresented: $showCancelAlert) {
        Button("取消", role: .cancel) { }
        Button("確定", role: .destructive) {
          isPresented = false
        }
      }
    }
  }

  func saveHabit() {
    let newHabit = Habit(
      id: UUID(),
      title: title,
      icon: icon,
      colorType: colorType
    )
    appModel.habits.append(newHabit)
  }
}

#Preview {
  NewHabitView(isPresented: .constant(true), colorType: .forest)
    .environment(AppModel())
}
