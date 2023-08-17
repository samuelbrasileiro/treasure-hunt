//#-hidden-code
import PlaygroundSupport
import SwiftUI

enum Shape: String, CaseIterable {
    case none, triangle, circle, polygon, square, pentagon, star, line
    
    var imageName: String {
        switch self {
        case .triangle:
            return "triangle.fill"
        case .circle:
            return "circle.fill"
        case .square:
            return "square.fill"
        case .pentagon:
            return "pentagon.fill"
        case .none:
            return "multiply"
        case .star:
            return "star.fill"
        case .line:
            return "line.diagonal"
        case .polygon:
            return "questionmark"
        }
    }
}

enum Color: String, CaseIterable {
    case none, purple, black, red, blue, orange, green, yellow

    var color: SwiftUI.Color {
        switch self {
        case .red:
            return .red
        case .blue:
            return .blue
        case .green:
            return .green
        case .yellow:
            return .yellow
        case .none:
            return .white
        case .purple:
            return .purple
        case .black:
            return .black
        case .orange:
            return .orange
        }
    }
}

let charadas = [
    "O vértice do amor, paixão ardente a queimar, que figura sou eu, que a cor do fogo faz dançar?",
    "União infinita, céu a explorar, na dança do tempo, que cor eu sou a pairar?",
    "Sólido e terreno, no campo sou abrigo, sempre firme e seguro, que cor a natureza sigo?",
    "Forma bruxal enigmática, sol radiante a brilhar, múltiplos caminhos, que figura posso emoldurar?"
]

struct PuzzlePiece: View {
    var shape: Shape
    var color: Color
    
    var body: some View {
        Image(systemName: shape.imageName)
            .foregroundColor(color.color)
    }
}

struct PuzzleView: View {
    var riddles: [(Shape, Color)]
    
    public var results: [Bool] {
        checkSolution(riddles)
    }

    var body: some View {
        VStack {
            ForEach(0..<riddles.count) { index in
                HStack {
                    PuzzlePiece(shape: riddles[index].0, color: riddles[index].1)
                    Text(results[index] ? "Correto" : "Incorreto")
                        .foregroundColor(results[index] ? .green : .red)
                }
            }
        }
    }

    private func correctSolution() -> [(Shape, Color)] {
        return [(.triangle, .red), (.circle, .blue), (.square, .green), (.pentagon, .yellow)]
    }

    private func checkSolution(_ solution: [(Shape, Color)]) -> [Bool] {
        return solution.enumerated().map { $0.element == correctSolution()[$0.offset] }
    }
}

//#-end-hidden-code
/*:
# As Chaves
Dentro da caverna, você encontrou várias chaves em formas geométricas coloridas e espaços para serem colocadas.

As charadas abaixo vão guiar você na associação correta entre as formas e as cores. Resolva cada charada para encontrar a combinação certa e liberar o caminho.

1. "O vértice do amor, paixão ardente a queimar, que figura sou eu, que a cor do fogo faz dançar?"
2. "Forma bruxal enigmática, sol radiante a brilhar, múltiplos caminhos, que figura posso emoldurar?"
3. "Sólido e terreno, no campo sou abrigo, sempre firme e seguro, que cor a natureza sigo?"
4. "União infinita, céu a explorar, na dança do tempo, que cor eu sou a pairar?"
*/
//#-editable-code
func getSolvedRiddles() -> [(shape: Shape, color: Color)] {
    // Insira as associações corretas entre as formas e cores
    return [
        (.none, .none), // Charada 1
        (.none, .none), // Charada 2
        (.none, .none), // Charada 3
        (.none, .none)  // Charada 4
    ]
}
//#-end-editable-code
let liveView = PuzzleView(riddles: getSolvedRiddles())
//#-hidden-code
PlaygroundPage.current.setLiveView(liveView)

if liveView.results.allSatisfy({ $0 }) {
    PlaygroundPage.current.assessmentStatus = .pass(message: "Parabéns! Você resolveu as charadas e liberou o caminho!")
} else {
    PlaygroundPage.current.assessmentStatus = .fail(hints: ["As charadas apontam para uma forma e uma cor específicas. Pense na descrição e no significado."], solution: nil)
}
//#-end-hidden-code
