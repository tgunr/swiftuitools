import Cocoa
var source = """
struct MedicationDetail: View {
var medication: FetchedResults<Medicine>.Element
var body: some View {
        VStack() {
            TopView(medication: medication)
            FrequencyView(medication: medication)
            RemainingView(medication: medication)
            RefillView(medication: medication)
            NavigationView {
                VStack {
                    HStack {
                        NavigationLink("Frequency Detail",
                                       destination: FrequencyView(medication: medication))
                        Spacer()
                    }
                    HStack {
                        NavigationLink("Dosage Detail",
                                       destination: DosageDetailView(medication: medication))
                        Spacer()
                    }
                    HStack {
                        NavigationLink("Notification Detail",
                                       destination: NotifyDetailView(medication: medication))
                        Spacer()
                    }
                }
                .navigationViewStyle(.automatic)
            }
        }
    }
}
"""

extension String {
    
    func numberOfLines() -> Int {
        return self.numberOfOccurrencesOf(string: "\n") + 1
    }

    func numberOfOccurrencesOf(string: String) -> Int {
        return self.components(separatedBy:string).count - 1
    }
}


let lineNum = 3
let numLines = source.numberOfLines()
var lines = source.components(separatedBy: CharacterSet.newlines)
let currentLine = lines[lineNum]

func findBalanced(lines: ArraySlice<String>) -> Int {
    var b: Int = 0
    var c: Int = 0
    for line in lines {
        if line.contains("{") { b += 1 }
        if line.contains("}") { b -= 1 }
        print("line: \(line)\nb: \(b) c: \(c + 5)")
        if b == 0 { return c }
        c += 1
    }
    return 0
}

func commentLine(line: Int) {
    let new = "// " + lines[line]
    lines[line] = new
    print("line: \(lines[line])")
}

print(source)

if currentLine.contains("{") {
    let rangeLines = lines.suffix(from: lineNum)
    let found = findBalanced(lines: rangeLines)
    if found != 0 {
        commentLine(line: lineNum)
        commentLine(line: found)
    }
}

source = lines.joined(separator: "\n")
print(source)








