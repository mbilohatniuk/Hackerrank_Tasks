//    13/20 test cases "Terminated due to timeout :(

import Foundation

func andProduct(a: Int, b: Int) -> Int {
    guard 0 <= a, a < b, b <= 4294967296 else { return 0 }
    
    var array: [Int] = []
    var counter = 0
    
    while counter <= b - a {
        array.append(a + counter)
        counter += 1
    }
    var result = array[0]
    
    for index in 1...array.count - 1 {
        result = result & array[index]
    }
    return result
}

andProduct(a: 12, b: 15)
