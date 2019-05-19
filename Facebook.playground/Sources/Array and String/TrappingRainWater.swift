import Foundation

//Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it is able to trap after raining.
public class TrappingRainWater {
    public func testCase() {
        let trapping = TrappingRainWater()
        print(trapping.trap([0,1,0,2,1,0,1,3,2,1,2,1]))
    }
    
    private func trap(_ height: [Int]) -> Int {
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
                } else {
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

