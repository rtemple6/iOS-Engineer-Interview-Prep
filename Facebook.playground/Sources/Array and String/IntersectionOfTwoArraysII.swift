import Foundation

//Given two arrays, write a function to compute their intersection.
//Example 1:
//Input: nums1 = [1,2,2,1], nums2 = [2,2]
//Output: [2,2]
//Example 2:
//Input: nums1 = [4,9,5], nums2 = [9,4,9,8,4]
//Output: [4,9]
//Note:
//Each element in the result should appear as many times as it shows in both arrays.
//The result can be in any order.

public class IntersectionOfTwoArraysII {
    public func testCase() {
        //Runtime O(n + m)
        //Space Complexity O(n)
        let intersectionOfTwoArrays = IntersectionOfTwoArraysII()
        print(intersectionOfTwoArrays.intersect([4,9,5], [9,4,9,8,4]))
    }
    
    private func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var hashMap = [Int: Int]()
        var result = [Int]()
        
        //Generate Hash of all occurences
        for num in nums1 {
            let prev = hashMap[num] ?? 0
            hashMap[num] = prev + 1
        }
        
        for num in nums2 {
            let value = hashMap[num] ?? 0
            //If value is in previous array, decrement and add result
            if value > 0 {
                hashMap[num] = value - 1
                result.append(num)
            }
        }
        
        return result
    }
}

