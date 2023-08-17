//#-hidden-code
import PlaygroundSupport
import SwiftUI

// A charada que leva à combinação correta

struct DoorView: View {
    var isLocked: Bool
    var isCorrectCombination: Bool

    var body: some View {
        VStack {
            if isCorrectCombination {
                Text("Porta Aberta!")
                    .font(.title)
                    .foregroundColor(.green)
            } else if isLocked {
                Text("Porta Trancada")
                    .font(.title)
                    .foregroundColor(.red)
            } else {
                Text("Combinação Incorreta!")
                    .font(.title)
                    .foregroundColor(.orange)
            }
            Image(systemName: isLocked ? "lock.fill" : "lock.open.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(isLocked ? .red : .green)
        }
    }
}

func unlockDoor(combination: (Int) -> Int) -> (isLocked: Bool, isCorrectCombination: Bool) {
    func correctCombination(_ value: Int) -> Int {
        return value + 2 * value - 9
    }
    if combination(21) == correctCombination(21), 
        combination(13) == correctCombination(13) {
        return (false, true)
    } else {
        return (true, false)
    }
}
//#-end-hidden-code
/*:
# A Caverna
Cuidado ao entrar na caverna! A porta está trancada, e a única pista para abrir está na sua fachada:

"Ao somar um número ao seu dobro e subtrair 9, temos seu código."

Escreva a função `tryCombination` abaixo para resolver a charada e inserir a combinação correta para abrir a porta.
*/

//#-editable-code
func tryCombination(value: Int) -> Int {
    // Insira a combinação correta resolvendo a charada
    return 0
}
//#-end-editable-code
let result = unlockDoor(combination: tryCombination)
//#-hidden-code
let liveView = DoorView(isLocked: result.isLocked, isCorrectCombination: result.isCorrectCombination)
PlaygroundPage.current.setLiveView(liveView)

if result.isCorrectCombination {
    PlaygroundPage.current.assessmentStatus = .pass(message: "Parabéns! Você abriu a porta e pode entrar na caverna!")
}
//#-end-hidden-code
