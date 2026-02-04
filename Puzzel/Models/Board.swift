import SwiftUI

struct Board {
    let size: Int
    // nil = empty, otherwise color of block
    private(set) var cells: [[Color?]]

    init(size: Int) {
        self.size = size
        self.cells = Array(repeating: Array(repeating: nil, count: size), count: size)
    }

    func canPlace(_ piece: Piece, atX x: Int, y: Int) -> Bool {
        for off in piece.blocks {
            let nx = x + off.x
            let ny = y + off.y
            if nx < 0 || ny < 0 || nx >= size || ny >= size { return false }
            if cells[ny][nx] != nil { return false }
        }
        return true
    }

    mutating func place(_ piece: Piece, atX x: Int, y: Int) {
        for off in piece.blocks {
            let nx = x + off.x
            let ny = y + off.y
            guard nx >= 0 && ny >= 0 && nx < size && ny < size else { continue }
            cells[ny][nx] = piece.color
        }
    }

    // Clears fully filled rows and columns. Returns number of lines cleared.
    mutating func clearFullLines() -> Int {
        var cleared = 0

        // rows
        for row in 0..<size {
            if cells[row].allSatisfy({ $0 != nil }) {
                for col in 0..<size { cells[row][col] = nil }
                cleared += 1
            }
        }

        // columns
        for col in 0..<size {
            var full = true
            for row in 0..<size where full {
                if cells[row][col] == nil { full = false }
            }
            if full {
                for row in 0..<size { cells[row][col] = nil }
                cleared += 1
            }
        }

        return cleared
    }

    func isEmpty(atX x: Int, y: Int) -> Bool {
        guard x >= 0 && y >= 0 && x < size && y < size else { return false }
        return cells[y][x] == nil
    }

    // Quick check whether a piece can be placed anywhere on the board
    func hasAvailablePlacement(for piece: Piece) -> Bool {
        for y in 0..<(size) {
            for x in 0..<(size) {
                var fits = true
                for off in piece.blocks {
                    let nx = x + off.x
                    let ny = y + off.y
                    if nx < 0 || ny < 0 || nx >= size || ny >= size { fits = false; break }
                    if cells[ny][nx] != nil { fits = false; break }
                }
                if fits { return true }
            }
        }
        return false
    }
}
