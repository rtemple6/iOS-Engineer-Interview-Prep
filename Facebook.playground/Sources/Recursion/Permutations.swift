import Foundation
//Given a collection of distinct integers, return all possible permutations.
//
//Example:
//
//Input: [1,2,3]
//Output:
//[
//[1,2,3],
//[1,3,2],
//[2,1,3],
//[2,3,1],
//[3,1,2],
//[3,2,1]
//]
public class Permutations: Base {
    public override func test() {
        print(permute([4,5,6]))
    }
    private func permute(_ nums: [Int]) -> [[Int]] {
        if nums.count == 0 {
            return []
        }
        
        var result = [[Int]]()
        var candidate = [Int]()
        
        backtracking(&result, &candidate, nums)
        
        return result
    }
    
    private func backtracking(_ result: inout [[Int]], _ candidate: inout [Int], _ nums: [Int]) {
        if candidate.count == nums.count {
            result.append(candidate)
            return
        }
        
        for num in nums {
            if candidate.contains(num) {
                continue
            }
            
            candidate.append(num)
            backtracking(&result, &candidate, nums)
            candidate.removeLast()
        }
    }
}
