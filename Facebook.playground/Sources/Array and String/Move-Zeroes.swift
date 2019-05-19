import Foundation

class MoveZeroes {
    //Given an array nums, write a function to move all 0's to the end of it while maintaining the relative order of the non-zero elements.
    func testCase() {
        let moveZeroes = MoveZeroes()
        var moveZeroesInput = [0, 1, 0, 3, 12]
        moveZeroes.moveZeroes(&moveZeroesInput)
    }
    
    func moveZeroes(_ nums: inout [Int]) {
        let count = nums.count
        nums = nums.filter { $0 != 0 }
        while nums.count < count {
            nums.append(0)
        }
    }
}
