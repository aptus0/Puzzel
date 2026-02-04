import SwiftUI

struct CellOffset: Hashable {
    let x: Int
    let y: Int
}

struct Piece: Identifiable, Hashable {
    let id = UUID()
    let blocks: [CellOffset]
    let color: Color

    var size: Int { blocks.count }

    // A simple set of example shapes for 2-,4-,5-block pieces
    static func randomSet() -> [Piece] {
        return [randomPiece(ofSize: 2), randomPiece(ofSize: 4), randomPiece(ofSize: 5)]
    }

    static func randomPiece(ofSize n: Int) -> Piece {
        switch n {
        case 2:
            return Piece(blocks: [CellOffset(x: 0,y:0), CellOffset(x:1,y:0)], color: .pink)
        case 4:
            // simple T or I
            if Bool.random() {
                return Piece(blocks: [CellOffset(x:0,y:0),CellOffset(x:1,y:0),CellOffset(x:2,y:0),CellOffset(x:1,y:1)], color: .blue)
            } else {
                return Piece(blocks: [CellOffset(x:0,y:0),CellOffset(x:1,y:0),CellOffset(x:2,y:0),CellOffset(x:3,y:0)], color: .green)
            }
        case 5:
            // one representative pentomino-ish shape
            return Piece(blocks: [CellOffset(x:0,y:0),CellOffset(x:1,y:0),CellOffset(x:2,y:0),CellOffset(x:0,y:1),CellOffset(x:1,y:1)], color: .purple)
        default:
            return Piece(blocks: [CellOffset(x:0,y:0)], color: .gray)
        }
    }
}
