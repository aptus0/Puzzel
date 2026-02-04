import SwiftUI

struct GameView: View {
    @EnvironmentObject var gs: GameState

    let gridSize = 10

    @State private var draggingPiece: Piece? = nil
    @State private var dragOffset: CGSize = .zero
    @State private var dragGridPos: (x: Int, y: Int)? = nil
    @State private var showSnap: Bool = false

    var body: some View {
        VStack(spacing: 12) {
            // AdMob Banner
            AdMobBannerView()
                .frame(height: 50)
                .padding(.bottom, 4)
            // Top bar
            HStack {
                Text("Score: \(gs.score)")
                    .foregroundColor(.white)
                Spacer()
                Text("Combo x\(String(format: "%.1f", gs.comboMultiplier))")
                    .foregroundColor(.yellow)
                Button(action: {}) { Image(systemName: "pause.fill").foregroundColor(.white) }
            }
            .padding()

            // Grid
            GeometryReader { geo in
                let cellSize = min(geo.size.width, geo.size.height) / CGFloat(gridSize)
                ZStack {
                    VStack(spacing: 1) {
                            ForEach(0..<gridSize, id: \.self) { row in
                            HStack(spacing: 1) {
                                    ForEach(0..<gridSize, id: \.self) { col in
                                    let color = gs.board.cells[row][col]
                                    Rectangle()
                                        .foregroundColor(color ?? Color(.systemGray6).opacity(0.08))
                                        .frame(width: cellSize, height: cellSize)
                                        .cornerRadius(4)
                                        .overlay(
                                            Group {
                                                if let dragging = draggingPiece, let dragPos = dragGridPos {
                                                    // Highlight possible placement
                                                    if dragging.blocks.contains(where: { dragPos.x + $0.x == col && dragPos.y + $0.y == row }) {
                                                        Rectangle()
                                                            .fill(gs.board.canPlace(dragging, atX: dragPos.x, y: dragPos.y) ? dragging.color.opacity(0.5) : Color.red.opacity(0.3))
                                                            .frame(width: cellSize, height: cellSize)
                                                            .cornerRadius(4)
                                                    }
                                                }
                                            }
                                        )
                                }
                            }
                        }
                    }
                    // Snap animation
                    if showSnap, let dragging = draggingPiece, let dragPos = dragGridPos {
                            ForEach(dragging.blocks, id: \.self) { off in
                            let nx = dragPos.x + off.x
                            let ny = dragPos.y + off.y
                            Rectangle()
                                .fill(dragging.color)
                                .frame(width: cellSize, height: cellSize)
                                .cornerRadius(4)
                                .position(x: CGFloat(nx) * cellSize + cellSize/2, y: CGFloat(ny) * cellSize + cellSize/2)
                                .shadow(color: dragging.color.opacity(0.7), radius: 10)
                                .transition(.scale)
                        }
                    }
                }
            }
            .padding(.horizontal)

            // Bottom pieces
            HStack(spacing: 16) {
                ForEach(gs.activePieces) { p in
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(p.color)
                                .frame(width: 80, height: 80)
                                .overlay(Text("\(p.size)").foregroundColor(.white))
                        }
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    draggingPiece = p
                                    dragOffset = value.translation
                                    // Calculate grid position from drag location
                                    let gridOrigin = CGPoint(x: 0, y: 0)
                                    let dragLoc = value.location
                                    // For demo: snap to grid center
                                    let gridX = Int((dragLoc.x + dragOffset.width) / 32)
                                    let gridY = Int((dragLoc.y + dragOffset.height) / 32)
                                    dragGridPos = (x: gridX, y: gridY)
                                }
                                .onEnded { value in
                                    if let dragging = draggingPiece, let dragPos = dragGridPos {
                                        if gs.board.canPlace(dragging, atX: dragPos.x, y: dragPos.y) {
                                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                                showSnap = true
                                            }
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                                gs.place(piece: dragging, atX: dragPos.x, y: dragPos.y)
                                                showSnap = false
                                            }
                                        }
                                    }
                                    draggingPiece = nil
                                    dragOffset = .zero
                                    dragGridPos = nil
                                }
                        )
                    }
                }
            }
            .padding()
        }
        .background(Color.black)
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: gs.score) { _ in if gs.isGameOver() { gs.saveBestIfNeeded() } }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View { GameView().environmentObject(GameState()) }
}
