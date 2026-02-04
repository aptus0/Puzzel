import SwiftUI

struct ResultsView: View {
    let score: Int
    let best: Int
    let maxCombo: Int

    var body: some View {
        VStack(spacing: 20) {
            Text("Game Over").font(.largeTitle).foregroundColor(.white)
            Text("Score: \(score)").foregroundColor(.white)
            Text("Best: \(best)").foregroundColor(.gray)
            Text("Max Combo: \(maxCombo)").foregroundColor(.yellow)

            HStack(spacing: 20) {
                Button("Retry") {}
                Button("Home") {}
                Button("Share") {}
            }
        }
        .padding()
        .background(Color.black)
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View { ResultsView(score: 1234, best: 2000, maxCombo: 3) }
}
