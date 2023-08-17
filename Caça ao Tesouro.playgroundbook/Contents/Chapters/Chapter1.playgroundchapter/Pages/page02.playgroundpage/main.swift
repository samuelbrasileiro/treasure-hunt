//#-hidden-code
import PlaygroundSupport
import SwiftUI

class Attempt: NSObject, NSCoding {
    var x: Int
    var y: Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(x, forKey: "x")
        coder.encode(y, forKey: "y")
    }
    
    required convenience init?(coder: NSCoder) {
        let x = coder.decodeInteger(forKey: "x")
        let y = coder.decodeInteger(forKey: "y")
        self.init(x: x, y: y)
    }
}

func checkPosition(x: Int, y: Int) {

}

class TreasureHuntState {
    var attempts: [Attempt] = []
    
    func save() {
        guard let attemptsData = try? NSKeyedArchiver.archivedData(withRootObject: attempts, requiringSecureCoding: false) else { return }
        PlaygroundKeyValueStore.current["attempts"] = .data(attemptsData)
    }
    
    func load() {
        if let keyValue = PlaygroundKeyValueStore.current["attempts"],
           case .data(let attemptsData) = keyValue {
            attempts = (try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(attemptsData)) as? [Attempt] ?? []
        }
    }
}

let state = TreasureHuntState()
state.load()


// Definindo a localização do tesouro

func distanceFromTreasure(x: Int, y: Int) -> Int {
    let treasureX = 23
    let treasureY = 5
    return abs(x - treasureX) + abs(y - treasureY)
}

func colorForLocation(x: Int, y: Int) -> Color {
    let distance = distanceFromTreasure(x: x, y: y)
    
    if distance == 0 {
        return .green
    } else if distance <= 3 {
        return .red
    } else if distance <= 7 {
        return .orange
    } else if distance <= 12 {
        return .yellow
    } else {
        return .cyan
    }
}

struct TreasureMapView: View {
    var attempts: [Attempt]

    var body: some View {
        VStack(spacing: 1) {
            ForEach(0..<30) { row in
                HStack(spacing: 1) {
                    ForEach(0..<30) { col in
                        let color: Color = self.attempts.contains { attempt in 
                        return attempt.x == col && attempt.y == row }
                            ? colorForLocation(x: col, y: row)
                            : .white
                        Rectangle()
                            .fill(color)
                    }
                }
            }
        }
    }
}


//#-end-hidden-code
/*:
Vocês encontraram um mapa enigmático que pode levar a um tesouro escondido.

O mapa contém coordenadas que devem ser decifradas para revelar a localização do tesouro. Insira diferentes coordenadas para encontrar o tesouro. 

Ao checarem uma posição, receberão dicas, em formatos de cores, como "quente", "muito quente", "morno" e "muito frio" para ajudá-lo a se aproximar do tesouro.

O mapa possui um tamanho de 30x30. Boa sorte!
 */

//#-editable-code

let x = 15
let y = 15

//#-end-editable-code
checkPosition(x: x, y: y)
//#-hidden-code

state.attempts.append(.init(x: x, y: y))
state.save()

let colorHint = colorForLocation(x: x, y: y)
if colorHint == .green {
    PlaygroundPage.current.assessmentStatus = .pass(message: "Parabéns! Você encontrou a localização do tesouro!")
} 
let liveView = TreasureMapView(attempts: state.attempts)
PlaygroundPage.current.setLiveView(liveView)

//#-end-hidden-code
