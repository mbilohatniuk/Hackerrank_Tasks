import Foundation


extension String {
    mutating func swapAt(_ index1: Int, _ index2: Int) {
        var characters = Array(self)
        characters.swapAt(index1, index2)
        self = String(characters)
    }
}

func biggerIsGreater(w: String) -> String {
    
    guard w.count >= 1, w.count <= 100 else { return "no answer"}

    var localString = w
    var i = w.count - 1

    while i > 0 {
        let index1 = localString.index(localString.startIndex, offsetBy: i)
        let index2 = localString.index(localString.startIndex, offsetBy: i - 1)
        
        if localString[index1] > localString[index2] {
            localString.swapAt(i, i - 1)
            return localString
        }
        
        i -= 1
    }
    return "no answer"
}
biggerIsGreater(w: "ACB")
