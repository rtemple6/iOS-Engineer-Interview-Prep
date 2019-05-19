import Foundation

public class SubsetsIterative: Base {
    public override func test() {
        print(subsets([1,2,3]))
    }
    private func subsets(_ nums: [Int]) -> [[Int]] {
        var answer: [[Int]] = []
        answer.append([])
        for num in nums {
            for var array in answer {
                array.append(num)
                answer.append(array)
            }
        }
        return answer
    }
}

public class SubsetsRecursive: Base {
    public override func test() {
        print(subsets([1,2,3]))
    }
    private var nums: [Int] = []
    
    private func subsets(_ nums: [Int]) -> [[Int]] {
        
        self.nums = nums
        
        var answer: [[Int]] = []
        self.nums.sort()
        var curr: [Int] = []
        dfs(&answer, &curr, 0)
        print(answer)
        return answer
    }
    
    private func dfs(_ answer: inout [[Int]], _ curr: inout [Int], _ start: Int) {
        print(curr, start)
        answer.append(curr)
        for i in start..<nums.count {
            //print("start =", i)
            curr.append(nums[i])
            dfs(&answer, &curr, i+1)
            curr.removeLast()
            //print("with last removed:", curr)
        }
    }
}
