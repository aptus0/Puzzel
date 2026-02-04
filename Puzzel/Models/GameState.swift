import SwiftUI

final class GameState: ObservableObject {
    @Published private(set) var board: Board
    @Published var activePieces: [Piece]
    @Published var score: Int = 0
    @Published var comboLevel: Int = 0
    @Published var comboMultiplier: Double = 1.0

    private var lastPlaceDate: Date?

    init(gridSize: Int = 10) {
        self.board = Board(size: gridSize)
        self.activePieces = Piece.randomSet()
        self.loadBestScore()
    }

    // Place piece at a board coordinate (top-left origin). Returns whether placed.
    func place(piece: Piece, atX x: Int, y: Int) -> Bool {
        guard board.canPlace(piece, atX: x, y: y) else { return false }

        board.place(piece, atX: x, y: y)

        // base score
        let base = piece.size * 10
        var add = Double(base)

        // clear lines
        let cleared = board.clearFullLines()
        if cleared > 0 {
            let linescore = Double(cleared * 100)
            comboLevel += 1
            comboMultiplier = comboFor(level: comboLevel)
            add += linescore * comboMultiplier
        } else {
            comboLevel = 0
            comboMultiplier = 1.0
        }

        // simple speed bonus
        if let last = lastPlaceDate {
            let dt = Date().timeIntervalSince(last)
            if dt < 2.0 { add += min(50, (2.0 - dt) * 25) }
        }
        lastPlaceDate = Date()

        score += Int(add)

        // refill pieces
        refillPieces(replacing: piece)

        return true
    }

    private func refillPieces(replacing piece: Piece) {
        if let idx = activePieces.firstIndex(of: piece) {
            activePieces[idx] = Piece.randomPiece(ofSize: piece.size)
        }
    }

    private func comboFor(level: Int) -> Double {
        switch level {
        case 0: return 1.0
        case 1: return 1.2
        case 2: return 1.5
        default: return 2.0
        }
    }

    // Quick game-over check
    func isGameOver() -> Bool {
        for p in activePieces {
            if board.hasAvailablePlacement(for: p) { return false }
        }
        return true
    }

    // Best score persistence
    @Published var bestScore: Int = 0
    private func loadBestScore() {
        bestScore = UserDefaults.standard.integer(forKey: "bestScore")
    }
    func saveBestIfNeeded() {
        if score > bestScore {
            bestScore = score
            UserDefaults.standard.set(bestScore, forKey: "bestScore")
        }
    }
}
