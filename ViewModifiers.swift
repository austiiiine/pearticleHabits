import SwiftUI

// 卡片樣式
struct CardStyle: ViewModifier {
  var cornerRadius: CGFloat = 20

  func body(content: Content) -> some View {
    content
      .background(Color.white)
      .cornerRadius(cornerRadius)
      .overlay(
        RoundedRectangle(cornerRadius: cornerRadius)
          .inset(by: 0.5)
          .stroke(Color.forest.opacity(0.35), lineWidth: 1)
      )
  }
}

extension View {
  func cardStyle(cornerRadius: CGFloat = 20) -> some View {
    modifier(CardStyle(cornerRadius: cornerRadius))
  }
}
