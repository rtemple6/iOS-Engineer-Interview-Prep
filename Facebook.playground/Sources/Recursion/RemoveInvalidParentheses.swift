import Foundation

//Remove the minimum number of invalid parentheses in order to make the input string valid. Return all possible results.
//
//Note: The input string may contain letters other than the parentheses ( and ).
//
//Example 1:
//
//Input: "()())()"
//Output: ["()()()", "(())()"]
//Example 2:
//
//Input: "(a)())()"
//Output: ["(a)()()", "(a())()"]
//Example 3:
//
//Input: ")("
//Output: [""]

//Explanation
//Since we just need to find "minimum" number of invalid parentheses, we do BFS for the string (use string length to represent the level here). When the level becomes smaller than length of our previous results, we can stop.
//
//To prevent a large amount of duplicate searching, we need to skip those we have visited to prevent them from going deeper.

public class RemoveInvalidParentheses: Base {
    
    public func testCase() {
        print(removeInvalidParentheses("(a)())()"))
    }
    private func removeInvalidParentheses(_ s: String) -> [String] {
        var result = Set<String>()
        var queue = [s], visited = Set<String>()
        while queue.count > 0 {
            let curr = queue.removeFirst()
            if let first = result.first, first.count > curr.count {
                break
            }
            
            if isValid(curr) {
                result.insert(curr)
            } else {
                let toRemove = charToRemove(curr)
                for i in curr.indices where curr[i] == toRemove {
                    //Construct new array of all elements except one to remove
                    let next = String(curr[curr.startIndex..<i] + curr[curr.index(after: i)...])
                    if !visited.contains(next) {
                        queue.append(next)
                        visited.insert(next)
                    }
                }
            }
        }
        
        return Array(result)
    }
    
    //Checks if current string is valid
    private func isValid(_ s: String) -> Bool {
        var l = 0
        for char in s {
            if char == "(" {
                l += 1
            } else if char == ")" {
                l -= 1
            }
            if l < 0 {
                return false
            }
        }
        return l == 0
    }
    
    //Helper function to determine which character to remove
    private func charToRemove(_ s: String) -> Character {
        var l = 0, r = 0
        for char in s {
            if char == "(" {
                l += 1
            } else if char == ")" {
                r += 1
            }
        }
        return l > r ? "(" : ")"
    }
}
