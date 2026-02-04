import SwiftUI

struct HomeView: View {
    @StateObject private var gs = GameState()

    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Text("Puzzel")
                .font(.largeTitle.weight(.bold))
                .foregroundStyle(LinearGradient(colors: [.pink, .purple], startPoint: .leading, endPoint: .trailing))

            Text("Best: \(gs.bestScore)")
                .foregroundColor(.gray)

            NavigationLink(destination: GameView().environmentObject(gs)) {
                Text("Play")
                    .font(.title2.weight(.semibold))
                    .padding(.horizontal, 40)
                    .padding(.vertical, 12)
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
            }

            NavigationLink("How To Play", destination: HowToPlayView())
                .foregroundColor(.white.opacity(0.8))

            Spacer()
            HStack {
                Spacer()
                NavigationLink("Settings", destination: EmptyView())
                Spacer()
            }
            Spacer().frame(height: 20)
        }
        .padding()
        .background(Color.black)
        .navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View { HomeView() }
}
