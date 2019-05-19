import Foundation

//Given a string containing digits from 2-9 inclusive, return all possible letter combinations that the number could represent.
//
//A mapping of digit to letters (just like on the telephone buttons) is given below. Note that 1 does not map to any letters.
//
//Example:
//Input: "23"
//Output: ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"].
public class LetterCombinationsOfAPhoneNumber {
    public func testCase() {
        let letterCombos = LetterCombinationsOfAPhoneNumber()
        print(letterCombos.letterCombinations("22345").count)
    }
    
    private func letterCombinations(_ digits: String) -> [String] {
        //Convert to array
        if digits == "" {
            return []
        }
        let input = Array(digits)
        var combinations = [String]()
        recursiveLetterCombos(input, index: 0, current: "", result: &combinations)
        return combinations
    }
    
    private func recursiveLetterCombos(_ digits: [Character], index: Int, current: String, result: inout [String]) {
        if index == digits.count {
            result.append(current)
            return
        }
        
        if let num = Int(String(digits[index])) {
            let letters = lettersFor(int: num)
            for letter in letters {
                recursiveLetterCombos(digits, index: index + 1, current: current + letter, result: &result)
            }
        }
    }
    
    private func lettersFor(int: Int) -> [String] {
        switch int {
        case 2: return ["a", "b", "c"]
        case 3: return ["d", "e", "f"]
        case 4: return ["g", "h", "i"]
        case 5: return ["j", "k", "l"]
        case 6: return ["m", "n", "o"]
        case 7: return ["p", "q", "r", "s"]
        case 8: return ["t", "u", "v"]
        case 9: return ["w", "x", "y", "z"]
        default: return []
        }
    }
}
