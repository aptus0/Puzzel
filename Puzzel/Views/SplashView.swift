import SwiftUI

struct SplashView: View {
    @State private var animate = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    Spacer()
                    Text("Puzzel")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundStyle(LinearGradient(colors: [.purple, .pink], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .scaleEffect(animate ? 1.03 : 0.96)
                        .shadow(color: .purple.opacity(0.6), radius: 12, x: 0, y: 6)
                    Spacer()
                    NavigationLink(destination: HomeView()) {
                        Text("Continue")
                            .padding(.horizontal, 24)
                            .padding(.vertical, 10)
                            .background(Color.white.opacity(0.08))
                            .cornerRadius(12)
                    }
                    Spacer().frame(height: 40)
                }
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) { animate.toggle() }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View { SplashView() }
}
