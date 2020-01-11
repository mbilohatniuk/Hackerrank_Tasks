//
//  main.swift
//  MergeSort
//
//  Created by Maksym Bilohatniuk on 1/9/20.
//  Copyright © 2020 Maksym Bilohatniuk. All rights reserved.
//

import Foundation


class ParallelMargeSort {
    
    public func parallelSort( _ array: [Int], _ cores: Int) -> [Int] {
        
        guard array.count > 1 else { return array }
        guard cores >= 1 && cores <= 32 else { return array }
        guard array.count < 500000000 else { return array }
        
        if cores == 1 {
            return mergeSort(array)
        }
        
        let middleIndex = array.count / 2
        
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
        
        return merge(leftArray: mergeSort(Array(array[0..<array.count / 2])), rightArray: mergeSort(Array(array[array.count / 2..<array.count])))
    }
    
    
    private func merge(leftArray: [Int], rightArray: [Int]) -> [Int] {
        
        var leftIndex = 0
        var rightIndex = 0

        var orderedArray: [Int] = []
        
        while leftIndex < leftArray.count && rightIndex < rightArray.count {

          if leftArray[leftIndex] < rightArray[rightIndex] {
            orderedArray.append(leftArray[leftIndex])
            leftIndex += 1
          } else if leftArray[leftIndex] > rightArray[rightIndex] {
            orderedArray.append(rightArray[rightIndex])
            rightIndex += 1
          } else {
            orderedArray.append(leftArray[leftIndex])
            leftIndex += 1
            orderedArray.append(rightArray[rightIndex])
            rightIndex += 1
          }
        }

        while leftIndex < leftArray.count {
          orderedArray.append(leftArray[leftIndex])
          leftIndex += 1
        }

        while rightIndex < rightArray.count {
          orderedArray.append(rightArray[rightIndex])
          rightIndex += 1
        }
        
        return orderedArray
    }
}




let object = ParallelMargeSort()
var mult = [Int]()
var single = [Int]()
var array = [Int]()

for _ in 0...1000000 {
    array.append(Int.random(in: 1...500))
}

let queue = DispatchQueue(label: "qwe", qos: .userInteractive, attributes: .concurrent)
queue.sync {
    let firstDate = Date()
    single = object.parallelSort(array, 1)
    print("1thread",Date().timeIntervalSince(firstDate))
    //print("single", single)
}



queue.sync {
    let secondDate = Date()
    mult = object.parallelSort(array, 2)
    print("multi", Date().timeIntervalSince(secondDate))
    //print("mult", mult)
}
