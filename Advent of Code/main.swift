//
//  main.swift
//  No rights reserved.
//

import Foundation
import RegexHelper

func main() {
    let fileUrl = URL(fileURLWithPath: "./aoc-input")
    guard let inputString = try? String(contentsOf: fileUrl, encoding: .utf8) else { fatalError("Invalid input") }
    
    let lines = inputString.components(separatedBy: "\n")
        .filter { !$0.isEmpty }
    
    var fullyContainCount = 0
    var partiallyOverlapCount = 0
    lines.forEach { line in
        let elves = parseLine(line)
        let fullyContain = fullyContain(first: elves.first, second: elves.second)
        if fullyContain { fullyContainCount += 1 }
        let partiallyOverlap = partiallyOverlap(first: elves.first, second: elves.second)
        if partiallyOverlap { partiallyOverlapCount += 1 }
    }
    
    print(fullyContainCount)
    print(partiallyOverlapCount)
}

func parseLine(_ line: String) -> (first: (from: Int, to: Int),
                                   second: (from: Int, to: Int)) {
    let chunks = line.components(separatedBy: ",")
    let firstChunks = chunks[0].components(separatedBy: "-")
    let secondChunks = chunks[1].components(separatedBy: "-")
    
    return (first: (from: Int(firstChunks[0])!, to: Int(firstChunks[1])!),
            second: (from: Int(secondChunks[0])!, to: Int(secondChunks[1])!))
}

func fullyContain(first: (from: Int, to: Int),
                  second: (from: Int, to: Int)) -> Bool {
    if first.from <= second.from && first.to >= second.to { return true }
    if second.from <= first.from && second.to >= first.to { return true }
    return false
}

func partiallyOverlap(first: (from: Int, to: Int),
                      second: (from: Int, to: Int)) -> Bool {
    if first.from <= second.from && first.to >= second.to { return true }
    if second.from <= first.from && second.to >= first.to { return true }
    
    if first.from <= second.from && first.to >= second.from { return true }
    if second.from <= first.from && second.to >= first.from { return true }
    
    return false
}

main()
