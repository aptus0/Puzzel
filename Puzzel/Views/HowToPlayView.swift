import SwiftUI

struct HowToPlayView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("How To Play")
                    .font(.title2.weight(.bold))

                Group {
                    Card(title: "Drag & Drop", desc: "Place incoming pieces onto the grid. They snap into place.")
                    Card(title: "Line Clear", desc: "Fill a full row or column to clear it and earn +100.")
                    Card(title: "Combo", desc: "Clear multiple lines in a row to increase your combo multiplier.")
                    Card(title: "Game Over", desc: "Game ends when none of the 3 pieces fit on the board.")
                }
                Spacer()
            }
            .padding()
        }
        .background(Color.black)
    }
}

struct Card: View {
    let title: String
    let desc: String
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title).font(.headline).foregroundColor(.white)
            Text(desc).foregroundColor(.gray).font(.subheadline)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(12)
    }
}

struct HowToPlayView_Previews: PreviewProvider {
    static var previews: some View { HowToPlayView() }
}
