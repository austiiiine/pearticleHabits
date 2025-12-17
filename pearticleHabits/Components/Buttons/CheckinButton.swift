import SwiftUI

struct CheckinButton: View {
  let label: String
  var backgroundColor: Color = .white

  var body: some View {
    
    HStack(alignment: .center, spacing: 8) {
      Text(label)
        .font(.body)
        .fontWeight(.bold)
        .foregroundStyle(.forest)
    }
    .frame(maxWidth: .infinity, alignment: .center)
    .padding(12)
    .background(backgroundColor)
    .clipShape(Capsule())
    .overlay(
      RoundedRectangle(cornerRadius: 99)
        .inset(by: 0.5)
        .stroke(Color.forest.opacity(0.35), lineWidth: 1)
    )
  }
}
