import UIKit

//MARK: Array and String

//==============================================================================
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
//==============================================================================

//==============================================================================
//Given an array nums, write a function to move all 0's to the end of it while maintaining the relative order of the non-zero elements.
class MoveZeroes {
    func moveZeroes(_ nums: inout [Int]) {
        let count = nums.count
        nums = nums.filter { $0 != 0 }
        while nums.count < count {
            nums.append(0)
        }
    }
}
let moveZeroes = MoveZeroes()
var moveZeroesInput = [0, 1, 0, 3, 12]
moveZeroes.moveZeroes(&moveZeroesInput)
moveZeroesInput
//==============================================================================

//==============================================================================
//Given an array nums of n integers, are there elements a, b, c in nums such that a + b + c = 0? Find all unique triplets in the array which gives the sum of zero.
class ThreeSum {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var ret = [[Int]]()
        if nums.count <= 2 {
            return ret
        }
        
        let nums = nums.sorted{ $0 < $1 }
        for i in 0 ..< nums.count {
            //let say nums[i] is the first element, the result requires unique triplets
            //which means if there are a few elements are the same value, we can start calculate sum from the last one
            //so we can terminate this time iteration and start from i+1, until we find the last continuous same i
            if i > 0 && nums[i] == nums[i-1] {
                continue
            }
            
            let target = -nums[i]
            var front = i + 1
            var end = nums.count - 1
            
            while(front < end){
                let sum = nums[front] + nums[end]
                if sum > target{
                    end -= 1
                }else if sum < target{
                    front += 1
                }else{
                    let result = [nums[i], nums[front], nums[end]]
                    ret.append(result)
                    
                    //do the same thing here move forward and ignore all the front with same value
                    while(front < end && nums[front] == result[1]){
                        front += 1
                    }
                    
                    //ignore all the end with same value until we get a new end value
                    while(front < end && nums[end] == result[2]){
                        end -= 1
                    }
                }
            }
        }
        return ret
    }
}
let threeSome = ThreeSum()
threeSome.threeSum([1,2,3,4,5,-1,2,3,-4,-5,-1,0,0,-1])
