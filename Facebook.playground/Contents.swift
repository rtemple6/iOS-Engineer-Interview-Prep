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
//Runtime
//Quadtratic
let threeSome = ThreeSum()
threeSome.threeSum([1,2,3,4,5,-1,2,3,-4,-5,-1,0,0,-1])
//==============================================================================

//==============================================================================
//Given two arrays, write a function to compute their intersection.
class IntersectionOfTwoArraysII {
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var hashMap = [Int: Int]()
        var result = [Int]()
        
        //Generate Hash of all occurences
        for num in nums1 {
            let prev = hashMap[num] ?? 0
            hashMap[num] = prev + 1
        }
        
        for num in nums2 {
            let value = hashMap[num] ?? 0
            if value > 0 {
                hashMap[num] = value - 1
                result.append(num)
            }
        }
        
        return result
    }
}
//Runtime
//O(n + m)
//Space
//O(n)
let intersectionOfTwoArrays = IntersectionOfTwoArraysII()
intersectionOfTwoArrays.intersect([4,9,5], [9,4,9,8,4])
//==============================================================================

//==============================================================================
//Given two binary strings, return their sum (also a binary string).
//The input strings are both non-empty and contains only characters 1 or 0.
class AddBinary {
    func addBinary(_ a: String, _ b: String) -> String {
        
        //Track the carry
        var carry = 0
        
        //Stores Sum of Two binary strings
        var totalSum = [String]()
        
        //Convert Strings to Arrays of Characters
        var aArray = Array(a)
        var bArray = Array(b)
        
        //Make both arrays even lengths
        while aArray.count != bArray.count {
            if aArray.count > bArray.count {
                bArray.insert(Character(String(0)), at: 0)
            } else {
                aArray.insert(Character(String(0)), at: 0)
            }
        }
        
        //Start at end of array and step backwards
        var index = aArray.count - 1
        while index >= 0 {
            
            //Compute the sum
            let first = Int(String(aArray[index])) ?? 0
            let second = Int(String(bArray[index])) ?? 0
            let sum = first + second + carry
            
            index -= 1
            
            //Sum can be up 0,1,2,3
            switch sum {
            case 0, 1:
                totalSum.append("\(sum)")
                carry = 0
                break
            case 2:
                totalSum.append("0")
                carry = 1
                break
            case 3:
                totalSum.append("1")
                carry = 1
            default:
                break
            }
        }
        
        //Append a final Carry
        if carry != 0 {
            totalSum.append(String(carry))
        }
        
        //Return total sum reversed as a String
        return totalSum.reversed().joined()
    }
}
let addBinary = AddBinary()
addBinary.addBinary("11", "1")
//==============================================================================

//==============================================================================
//Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it is able to trap after raining.
class TrappingRainWater {
    func trap(_ height: [Int]) -> Int {
        guard height.count > 0 else {
            return 0
        }
        
        var leftPtr = 0, leftMax = height[0]
        var rightPtr = height.count - 1, rightMax = height[height.count-1]
        var water = 0
        while leftPtr < rightPtr{
            while leftMax <= rightMax && leftPtr < rightPtr{
                if height[leftPtr] <= leftMax{
                    water += leftMax - height[leftPtr]
                    leftPtr += 1
                }else{
                    leftMax = height[leftPtr]
                }
            }
            
            while rightMax <= leftMax && leftPtr < rightPtr{
                if height[rightPtr] <= rightMax{
                    water += rightMax - height[rightPtr]
                    rightPtr -= 1
                }else{
                    rightMax = height[rightPtr]
                }
            }
        }
        return water
    }
}
let trapping = TrappingRainWater()
trapping.trap([0,1,0,2,1,0,1,3,2,1,2,1])
//==============================================================================

//==============================================================================
//Given an array nums of n integers where n > 1,  return an array output such that output[i] is equal to the product of all the elements of nums except nums[i].
//Input:  [1,2,3,4]
//Output: [24,12,8,6]
class ProductOfArrayExceptSelf {
    func productExceptSelf(_ nums: [Int]) -> [Int] {
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
let poaes = ProductOfArrayExceptSelf()
poaes.productExceptSelf([1, 2, 3, 4])
//==============================================================================

//==============================================================================
//Convert a non-negative integer to its english words representation. Given input is guaranteed to be less than 2^31 - 1.
class IntegerToWords {
    private let map = [
        /* 1~19 */
        1: "One", 2: "Two", 3: "Three", 4: "Four", 5: "Five",
        6: "Six", 7: "Seven", 8: "Eight", 9: "Nine", 10: "Ten",
        11: "Eleven", 12: "Twelve", 13: "Thirteen", 14: "Fourteen", 15: "Fifteen",
        16: "Sixteen", 17: "Seventeen", 18: "Eighteen", 19: "Nineteen",
        
        /* 20, 30, 40, ..., 90 */
        20: "Twenty", 30: "Thirty", 40: "Forty", 50: "Fifty",
        60: "Sixty", 70: "Seventy", 80: "Eighty", 90: "Ninety"
    ]
    
    func numberToWords(_ num: Int) -> String {
        let lowest   = (num / 1) % 1000
        let thousand = (num / 1000) % 1000
        let million  = (num / 1000_000) % 1000
        let billion  = (num / 1000_000_000) % 1000
        
        var result = [String]()
        if let billion = convertToWord(billion) {
            result.append("\(billion) Billion")
        }
        if let million = convertToWord(million) {
            result.append("\(million) Million")
        }
        if let thousand = convertToWord(thousand) {
            result.append("\(thousand) Thousand")
        }
        if let lowest = convertToWord(lowest) {
            result.append(lowest)
        }
        
        if result.count == 0 {
            return "Zero"
        } else {
            return result.joined(separator: " ")
        }
    }
    
    private func convertToWord(_ num: Int) -> String? {
        let hundred = num / 100
        let ten = num % 100
        var arr = [String]() {
            didSet {
                //Print Intermediate results
                // print("Arr", arr)
            }
        }
        if hundred > 0 {
            arr += [map[hundred]!, "Hundred"]
        }
        if ten > 0 {
            if ten < 20 {
                arr.append(map[ten]!)
            } else {
                arr.append(map[ten-ten%10]!)
                if let one = map[ten%10] {
                    arr.append(one)
                }
            }
        }
        guard arr.count > 0 else { return nil }
        return arr.joined(separator: " ")
    }
}
let intToWords = IntegerToWords()
intToWords.numberToWords(1234567892)
