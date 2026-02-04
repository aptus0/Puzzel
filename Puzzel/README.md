# Puzzel — SwiftUI Puzzle Game (MVP)

This workspace contains an early SwiftUI scaffold for the 10x10 puzzle game described in the spec.

What I added:
- SwiftUI entry (`PuzzelApp.swift`) that uses existing `AppDelegate` for compatibility
- Models: `Piece`, `Board`, `GameState` (placement, scoring, combo)
- Views: `SplashView`, `HomeView`, `GameView`, `HowToPlayView`, `ResultsView`

Next steps I can continue with (if you say "başla"):
- Implement drag-and-drop placement and placement preview highlight
- Snap animations, line-clear particle effects, haptics
- Finalize piece rotation variants and a fuller pentomino set
- Wire Results screen and persistence fully

Run in Xcode: open the existing Xcode project and add these files to the app target if needed.
