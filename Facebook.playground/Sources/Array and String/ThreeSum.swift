import Foundation

//Given an array nums of n integers, are there elements a, b, c in nums such that a + b + c = 0?
//Find all unique triplets in the array which gives the sum of zero.
//Example:
//
//Given array nums = [-1, 0, 1, 2, -1, -4],
//
//A solution set is:
//[
//  [-1, 0, 1],
//  [-1, -1, 2]
//]
public class ThreeSum {
    
    public func testCase() {
        //Runtime
        //Quadtratic
        let threeSome = ThreeSum()
        let result = threeSome.threeSum([1,2,3,4,5,-1,2,3,-4,-5,-1,0,0,-1])
        print(result)
    }
    
    private func threeSum(_ nums: [Int]) -> [[Int]] {
        var ret = [[Int]]()
        //Err checking
        if nums.count <= 2 {
            return ret
        }
        //Sort the array
        let nums = nums.sorted{ $0 < $1 }
        
        //Iterate through each element
        for i in 0 ..< nums.count {
            
            //Skip checking the same element each iteration
            //Example 0, 1, 1, 1, 2,
            //The array will only check values 0, 1, 2
            if i > 0 && nums[i] == nums[i-1] {
                //Continue basically runs the loops again
                continue
            }
            
            //Get the compliment of target
            let target = -nums[i]
            
            //Pointers to front and end of array
            var front = i + 1
            var end = nums.count - 1
            
            //Search the remaining elements in array
            while(front < end){
                //Calculate other 2 numbers addition value
                let sum = nums[front] + nums[end]
                
                if sum > target {
                    //Move end ptr left
                    end -= 1
                } else if sum < target {
                    //Move front ptr right
                    front += 1
                } else {
                    //Add result to return array/array
                    let result = [nums[i], nums[front], nums[end]]
                    ret.append(result)
                    
                    //Move forward ignoring duplicates
                    while(front < end && nums[front] == result[1]){
                        front += 1
                    }
                    
                    //Move backwards ignoring duplicates
                    while(front < end && nums[end] == result[2]){
                        end -= 1
                    }
                }
            }
        }
        return ret
    }
}
