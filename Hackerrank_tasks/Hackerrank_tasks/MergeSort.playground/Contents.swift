import Foundation
import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

//зробив як зміг
class ParallelMargeSort {
    
    public func parallelSort( _ array: [Int], _ cores: Int) -> [Int] {
        
        guard array.count > 1 else { return array }
        guard cores >= 1 && cores <= 32 else { return array }
        guard array.count < 500000000 else { return array }
        
        if cores == 1 {
            return mergeSort(array)
        }
        
        let middleIndex =  array.count / 2
        
        let queue = DispatchQueue.global(qos: .default)
        let group = DispatchGroup()
        
        var leftSide = [Int]()
        var rightSide = [Int]()
        
        group.enter()
        queue.async {
            leftSide = self.mergeSort(Array(array[0..<middleIndex]))
            group.leave()
        }
        
        group.enter()
        queue.async {
            rightSide = self.mergeSort(Array(array[middleIndex..<array.count]))
            group.leave()
        }
        group.wait()
        return merge(leftArray: leftSide, rightArray: rightSide)
    }
    
    private func mergeSort(_ array: [Int]) -> [Int] {
        
        guard array.count > 1 else { return array }
        let middleIndex =  array.count / 2
        
        let leftSide = mergeSort(Array(array[0..<middleIndex]))
        let rightSide = mergeSort(Array(array[middleIndex..<array.count]))
        
        return merge(leftArray: leftSide, rightArray: rightSide)
    }
    
    private func merge(leftArray: [Int], rightArray: [Int]) -> [Int] {
        
        var mergedArray: [Int] = []
        var leftArray = leftArray
        var rightArray = rightArray
        
        while leftArray.count > 0 && rightArray.count > 0 {
            
            if leftArray.first! < rightArray.first! {
                mergedArray.append(leftArray.removeFirst())
            } else {
                mergedArray.append(rightArray.removeFirst())
            }
        }
        
        return mergedArray + leftArray + rightArray
    }
}



let object = ParallelMargeSort()
var mult = [Int]()
var single = [Int]()
var array = [Int]()

for _ in 0...200 {
    array.append(Int.random(in: 1...100))
}

let queue = DispatchQueue(label: "qwe", qos: .userInteractive, attributes: .concurrent)


queue.async {
    let firstDate = Date()
    single = object.parallelSort(array, 1)
    print("first",Date().timeIntervalSince(firstDate))
    print("single", single)
}

queue.async {
    let secondDate = Date()
    mult = object.parallelSort(array, 2)
    print("second", Date().timeIntervalSince(secondDate))
    print("mult", mult)
}




