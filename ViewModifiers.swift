import SwiftUI

// 卡片樣式
struct CardStyle: ViewModifier {
  var cornerRadius: CGFloat = 20
  var backgroundColor: Color = .white

  func body(content: Content) -> some View {
    content
      .background(backgroundColor)
      .cornerRadius(cornerRadius)
      .overlay(
        RoundedRectangle(cornerRadius: cornerRadius)
          .inset(by: 0.5)
          .stroke(Color.forest.opacity(0.35), lineWidth: 1)
      )
  }
}

extension View {
  func cardStyle(
    cornerRadius: CGFloat = 20,
    background: Color = .white
  ) -> some View {
    modifier(
      CardStyle(
        cornerRadius: cornerRadius,
        backgroundColor: background
      )
    )
  }
}
