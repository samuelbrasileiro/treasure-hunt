//#-hidden-code
import PlaygroundSupport
import SwiftUI

enum Direction {
    case forward
    case left
    case right
}

struct BridgeTile {
    var description: String
    var correctDirection: Direction
}

struct BridgeView: View {
    var currentTile: Int
    var bridgeTiles: [BridgeTile]
    var whereDidFail: Int
    
    var body: some View {
        VStack {

            
            Text(getStatusText())
                .font(.headline)
                .padding()
            HStack {
                ForEach(0..<bridgeTiles.count) { index in
                    
                    Rectangle()
                        .fill(getColor(of: index))
                        .frame(width: 10, height: 30)
                }
            }
        }
    }
    func getColor(of index: Int) -> Color {
        let color: Color
        if index == whereDidFail {
            color = Color.red
        } else if currentTile <= index {
            color = Color.gray
        } else {
            color = Color.green
        }
        return color
    }

    func getStatusText() -> String{
        let text: String
        if whereDidFail > -1 {
            text = "Você Caiu..."
        } else if currentTile < bridgeTiles.count{
            text = bridgeTiles[currentTile].description
        } else {
            text = "Você achou o tesouro! Parabéns!"
        }
        return text
    } 
}

let bridgeTiles = [
    BridgeTile(description: "Uma brisa suave toca seu rosto, o caminho parece seguro.", correctDirection: .forward),
    BridgeTile(description: "Você sente um cheiro estranho vindo da esquerda. Melhor ir em frente.", correctDirection: .forward),
    BridgeTile(description: "O som de águas agitadas ecoa à direita. Siga para a esquerda.", correctDirection: .left),
    BridgeTile(description: "A luz fraca de uma lanterna é visível à frente. Continue em frente.", correctDirection: .forward),
    BridgeTile(description: "Uma voz distante chama da esquerda. É o caminho a seguir.", correctDirection: .left),
    BridgeTile(description: "O caminho à direita parece perigoso, com sombras se movendo. Vá para a esquerda.", correctDirection: .left),
    BridgeTile(description: "Você ouve um canto suave vindo de frente. É o caminho certo.", correctDirection: .forward),
    BridgeTile(description: "A ponte treme suavemente sob seus pés. O caminho à direita parece estável.", correctDirection: .right),
    BridgeTile(description: "O cintilar das estrelas aponta para a direita. Siga por esse caminho.", correctDirection: .right),
    BridgeTile(description: "Você chegou ao fim da ponte, o tesouro brilha à sua frente.", correctDirection: .forward)
]

var currentTile = 0
var whereDidFail = -1

func move(direction: Direction) {
    if direction == bridgeTiles[currentTile].correctDirection && whereDidFail == -1 {
        currentTile += 1
    } else {
        // Caiu da ponte
        whereDidFail = currentTile
        PlaygroundPage.current.assessmentStatus = .fail(hints: ["Você caiu da ponte! Tente novamente com outra ordem de movimentos."], solution: nil)
    }

    if currentTile == bridgeTiles.count {
        PlaygroundPage.current.assessmentStatus = .pass(message: "Parabéns! Você cruzou a ponte imaginária!")
    }
}
//#-end-hidden-code
/*:
# Ponte Imaginária
Você chegou à ponte imaginária. Cada passo deve ser tomado com cuidado, conforme as descrições poéticas dos blocos da ponte.

Utilize a função `move` para determinar a direção correta em cada passo da ponte. Escolha entre `.forward`, `.left`, ou `.right`.

O Primeiro passo é seguindo em frente, adicione os outros!

*/
//#-editable-code

move(direction: .forward)

//#-end-editable-code
//#-hidden-code

let liveView = BridgeView(currentTile: currentTile, bridgeTiles: bridgeTiles, whereDidFail: whereDidFail)
PlaygroundPage.current.setLiveView(liveView)
//#-end-hidden-code