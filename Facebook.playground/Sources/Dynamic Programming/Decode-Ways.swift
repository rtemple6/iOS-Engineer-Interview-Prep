import Foundation

//A message containing letters from A-Z is being encoded to numbers using the following mapping:
//
//'A' -> 1
//'B' -> 2
//...
//'Z' -> 26
//Given a non-empty string containing only digits, determine the total number of ways to decode it.
//
//Example 1:
//
//Input: "12"
//Output: 2
//Explanation: It could be decoded as "AB" (1 2) or "L" (12).
//Example 2:
//
//Input: "226"
//Output: 3
//Explanation: It could be decoded as "BZ" (2 26), "VF" (22 6), or "BBF" (2 2 6).

//Very straight foward solution, calculate from index 0
//when index == count then we reach the end, return 1
//when index < count - 1 and this is not the last index, then
//if next index value is 1 or(next index is 2 and next next is less than 7 if exists) then we add previous one together which could be already calculated and stored in mem
//


public class DecodeWays: Base {
    public override func test() {
        numDecodings("<#T##s: String##String#>")
    }
    private func numDecodings(_ s: String) -> Int {
        if s.count == 0 { return 0 }
        else {
            var mem = [Int](repeating: -1, count: s.count + 1)
            return self.numsDecodings(0, s, &mem)
        }
    }
    
    //This solution also works without this mem array but will be Time Limit Exceeded
    private func numsDecodings(_ i: Int, _ s: String, _ mem : inout [Int]) -> Int{
        if mem[i] > -1 { return mem[i] }
        if i >= s.count { return 1 }
        
        let s2 = String(Array(s)[i])
        
        if s2 == "0" { return 0 }
        var ret = numsDecodings(i+1, s, &mem)
        
        if (i < s.count - 1) && (s2 == "1" || (s2 == "2" && String(Array(s)[i+1]) < "7" )){
            ret += numsDecodings(i+2, s, &mem)
        }
        
        mem[i] = ret
        return ret
    }
}
