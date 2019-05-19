import Foundation

//Given a collection of numbers that might contain duplicates, return all possible unique permutations.
//
//Example:
//
//Input: [1,1,2]
//Output:
//[
//[1,1,2],
//[1,2,1],
//[2,1,1]
//]
public class PermutationsII: Base {
    public override func test() {
        permuteUnique([1, 1, 2])
    }
    private func permuteUnique(_ nums: [Int]) -> [[Int]] {
        let nums = nums.sorted()
        var result: [[Int]] = []
        var candidates: [Int] = []
        backtracking(&result, &candidates, nums, nums.count)
        return result
    }
    
    private func backtracking(_ result: inout [[Int]], _ candidates: inout [Int], _ nums:[Int], _ length: Int) {
        if candidates.count == length {
            result.append(candidates)
            return
        }
        
        for i in 0..<nums.count {
            if i > 0 && nums[i - 1] == nums[i] {
                continue
            }
            var numsCopy = nums
            numsCopy.remove(at: i)
            candidates.append(nums[i])
            backtracking(&result, &candidates, numsCopy, length)
            candidates.removeLast()
        }
    }
}
