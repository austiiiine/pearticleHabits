import SwiftUI

struct RedeemButton: View {
  let label: String

  var body: some View {
    HStack(spacing: 4) {
      Image(systemName: "app.gift")
        .font(.system(size: 20))
        .foregroundStyle(.forest)

      Text(label)
        .font(.callout)
        .fontWeight(.semibold)
        .foregroundStyle(.forest)
    }
    .padding(.horizontal, 16)
    .padding(.vertical, 10)
    .background(
      Color.forest.opacity(0.15)
    )
    .clipShape(Capsule())
  }
}

#Preview {
  RedeemButton(label: "兌換")
    .padding()
}
