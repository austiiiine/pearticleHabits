import SwiftUI

struct EditRewardView: View {
  @Environment(AppModel.self) var appModel
  let icons = AppModel.icons

  @Binding var isPresented: Bool
  let originalReward: Reward


  @State private var title: String
  @State private var cost: Int
  @State private var icon: String
  @State private var colorType: ColorType

  @State private var showCancelAlert = false

  // 表單驗證條件
  var isFormValid: Bool {
    !title.trimmingCharacters(in: .whitespaces).isEmpty && !icon.isEmpty
  }

  // Init：將原始 reward 值載入到 @State 變數
  init(isPresented: Binding<Bool>, reward: Reward) {
    self._isPresented = isPresented
    self.originalReward = reward
    self._title = State(initialValue: reward.title)
    self._cost = State(initialValue: reward.cost)
    self._icon = State(initialValue: reward.icon)
    self._colorType = State(initialValue: reward.colorType)
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

            // 梨子數量
            HStack {
              Text("設定兌換梨子數")
                .font(.title3)
                .bold()
                .foregroundStyle(.forest)
              Spacer()
              Picker("兌換所需梨子數", selection: $cost) {
                ForEach(1..<301) { number in
                  Text("\(number)").tag(number)
                }
              }
              .pickerStyle(.wheel)
              .frame(width: 120, height: 100)
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
          Text("編輯獎勵")
            .font(.headline)
            .foregroundStyle(.forest)
        }

        // 儲存編輯
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
      .alert("確定要取消編輯？", isPresented: $showCancelAlert) {
        Button("取消", role: .cancel) { }
        Button("確定", role: .destructive) {
          isPresented = false
        }
      }
    }
  }

  func saveChanges() {
    if let index = appModel.rewards.firstIndex(where: { $0.id == originalReward.id }) {
      appModel.rewards[index].title = title
      appModel.rewards[index].icon = icon
      appModel.rewards[index].colorType = colorType
      appModel.rewards[index].cost = cost
    }
  }
}

#Preview {
  EditRewardView(
    isPresented: .constant(true),
    reward: Reward(
      title: "吃蛋糕",
      icon: "birthday.cake.fill",
      colorType: .mustard,
      cost: 7
    )
  )
  .environment(AppModel())
}
