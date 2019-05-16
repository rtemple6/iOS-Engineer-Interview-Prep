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
