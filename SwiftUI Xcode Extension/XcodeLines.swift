//
//  XcodeLines.swift
//  SwiftUI Xcode Extension
//
//  Created by Dave Carlton on 8/9/21.
//

import Foundation
import XcodeKit
import AppKit
import OSLog

let supportUTIs = [
    "com.apple.dt.playground",
    "public.swift-source",
    "com.apple.dt.playgroundpage"]

class XcodeLines: NSObject, XCSourceEditorCommand {
        
    var newLines: [String] = []
    var invocation: XCSourceEditorCommandInvocation?
    var lines: NSMutableArray = []
    var selections: NSMutableArray = []
    var log: Logger = Logger()

    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) {
        completionHandler(nil)
        return
    }

    func performSetup(invocation: XCSourceEditorCommandInvocation) throws {
        self.invocation = invocation
        self.log = Logger()
        log.log("performSetup")
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
        
        let uti = invocation.buffer.contentUTI
                
        guard supportUTIs.contains(uti) else {
            throw "UTI Error"
        }
        
        if invocation.buffer.usesTabsForIndentation {
            Indent.char = "\t"
        } else {
            Indent.char = String(repeating: " ", count: invocation.buffer.indentationWidth)
        }
        
        let parser = SwiftParser(string: invocation.buffer.completeBuffer)
        newLines = try parser.format().components(separatedBy: "\n")
        lines = invocation.buffer.lines
        selections = invocation.buffer.selections
    }
    
    func findBalanced(lines: ArraySlice<String>) -> Int {
        var b: Int = 0
        var c: Int = 0
        for line in lines {
            if line.contains("{") { b += 1 }
            if line.contains("}") { b -= 1 }
            if b == 0 {
                print("line: \(line)\nb: \(b) c: \(c + 5)")
                return c
            }
            c += 1
        }
        return 0
    }
    
    func updateLine(index: Int) {
        guard index < newLines.count, index < lines.count else {
            return
        }
        if let line = lines[index] as? String {
            let newLine = newLines[index] + "\n"
            if newLine != line {
                lines[index] = newLine
            }
        }
    }
    
    func toggleComment(index: Int) {
        var newLine:String
        
        guard index < newLines.count, index < lines.count else {
            return
        }
        
        if let line = lines[index] as? String {
            if line.hasPrefix("//") {
                let r = line.range(of: "//")
                newLine = String(line.suffix(from: r!.upperBound))
            } else {
                newLine = "//" + newLines[index] + "\n"
            }
            if newLine != line {
                lines[index] = newLine
            }
        }
        print("line: \(newLines[index])")
    }
    
    func removeLine(index: Int) {
        guard index < newLines.count, index < lines.count else {
            return
        }
        
        lines.removeObject(at: index)
//        print("line: \(newLines[index])")
    }
    
    func hasOpenBrace(index: Int) -> Int {
        var found = 0
        let currentLine = newLines[index]
        if currentLine.contains("{") {
            let rangeLines = newLines.suffix(from: index)
            found = findBalanced(lines: rangeLines)
        }
        return found
    }

}
