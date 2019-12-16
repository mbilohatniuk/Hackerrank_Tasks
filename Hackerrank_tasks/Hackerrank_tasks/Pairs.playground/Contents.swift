import Foundation

func pairs(k: Int, arr: [Int]) -> Int {
    var counter = 0
    
    let filterDublicate = Set(arr)
    let newValue = Array(filterDublicate)
 
    for index1 in 0...newValue.count - 1 {
        for index2 in index1...newValue.count - 1 {
            counter += compare(newValue[index1], newValue[index2], k)
        }
    }
    
    return counter
}

func compare(_ num1: Int, _ num2: Int, _ k: Int) -> Int {
    
    var counter = 0
    
    if num1 - num2 == k {
        counter += 1
    }
    
    if num2 - num1 == k {
        counter += 1
    }
    
    return counter
}
var a = pairs(k: 2, arr: [1,2,3,4])

