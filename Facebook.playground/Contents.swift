import UIKit

//Given a non-empty string s, you may delete at most one character. Judge whether you can make it a palindrome.
class ValidPalindrome {
    func validPalindrome(_ s: String) -> Bool {
        let s = Array(s)[0...]
        return valid(s, false)
    }
    
    private func valid(_ s: ArraySlice<Character>, _ strict: Bool) -> Bool {
        var i = s.startIndex, j = s.endIndex - 1
        while i < j {
            if s[i] != s[j] {
                if strict {
                    return false
                }
                let s1 = s[i+1...j], s2 = s[i...j-1]
                return valid(s1, true) || valid(s2, true)
            }
            i += 1
            j -= 1
        }
        return true
    }
}

let valid = ValidPalindrome()
valid.validPalindrome("aabaaaaaad")
