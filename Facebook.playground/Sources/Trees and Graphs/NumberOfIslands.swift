import Foundation

//Given a 2d grid map of '1's (land) and '0's (water), count the number of islands. An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.
// 
//Example 1:
//
//Input:
//11110
//11010
//11000
//00000
//
//Output: 1
//Example 2:
//
//Input:
//11000
//11000
//00100
//00011
//
//Output: 3

public class NumberOfIslands {
    public func testCase(){
        
        let numIslands = NumberOfIslands()
        print(numIslands.numIslands([["1"],["1"]]))
    }
    private func numIslands(_ grid: [[Character]]) -> Int {
        var islands = 0
        var grid = grid
        for i in 0..<grid.count {
            for j in 0..<grid[i].count {
                if (grid[i][j] == "1"){
                    islands += dfs(&grid, i, j)
                }
            }
        }
        return islands
    }
    
    @discardableResult
    private func dfs(_ grid: inout [[Character]], _ i: Int, _ j: Int)->Int {
        //Check if we are in bounds of matrix or if we are '0'
        if (i < 0 || i >= grid.count || j < 0 || j >= grid[i].count || grid[i][j] == "0") {
            return 0
        }
        
        //'Sink' the island so we dont visit it again
        grid[i][j] = "0"
        
        //traverse right, left, bottom, top
        dfs(&grid, i + 1, j)
        dfs(&grid, i - 1, j)
        dfs(&grid, i, j + 1)
        dfs(&grid, i, j - 1)
        return 1
    }
}

