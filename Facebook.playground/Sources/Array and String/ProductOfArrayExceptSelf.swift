import Foundation

//Given an array nums of n integers where n > 1,  return an array output such that output[i] is equal to the product of all the elements of nums except nums[i].
//Input:  [1,2,3,4]
//Output: [24,12,8,6]
public class ProductOfArrayExceptSelf {
    
    public func testCase() {
        let poaes = ProductOfArrayExceptSelf()
        print(poaes.productExceptSelf([1, 2, 3, 4]))
    }
    
    private func productExceptSelf(_ nums: [Int]) -> [Int] {
        var accumulator = 1
        var result = Array(repeating: 1, count: nums.count)
        
        for (idx, n) in nums.enumerated() {
            result[idx] = accumulator
            accumulator *= n
        }
        
        accumulator = 1
        for i in stride(from: nums.count - 1, to: -1, by: -1){
            result[i] *= accumulator
            accumulator *= nums[i]
        }
        return result
    }
}
