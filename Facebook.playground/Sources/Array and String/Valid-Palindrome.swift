import Foundation

class ValidPalindrome {
    ///Given a non-empty string s, you may delete at most one character. Judge whether you can make it a palindrome.
    func testCase() {
        let valid = ValidPalindrome()
        print(valid.validPalindrome("aabaaaaaad"))
    }
    
    private func validPalindrome(_ s: String) -> Bool {
        let letterArray = Array(s)
        let sliceArray = letterArray[0...]
        return valid(sliceArray)
    }
    
    private func valid(_ s: ArraySlice<Character>) -> Bool {
        var i = s.startIndex
        var j = s.endIndex - 1
        while i < j {
            let startLetter = s[i]
            let endLetter = s[j]
            if startLetter != endLetter {
                let s1 = s[i+1...j], s2 = s[i...j-1]
                return valid(s1) || valid(s2)
            }
            i += 1
            j -= 1
        }
        return true
    }
}
