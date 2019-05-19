import UIKit


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
//==============================================================================

//==============================================================================
//Set operations 
var colors: Set<UIColor> = [.red, .blue, .purple]
var colors1: Set<UIColor> = [.red, .black, .purple]

//colors.contains(.red)
//colors.remove(.red)
//colors.insert(.green)

//Order not guranteed
for color in colors1 {
    print(color)
}

//Returns all color in colors1 that also in colors
colors.intersection(colors1)
//Removes all color in colors that colors1 contains
colors.subtract(colors1)
//==============================================================================

//==============================================================================
//Given a binary tree, determine if it is a valid binary search tree (BST).
//
//Assume a BST is defined as follows:
//
//The left subtree of a node contains only nodes with keys less than the node's key.
//The right subtree of a node contains only nodes with keys greater than the node's key.
//Both the left and right subtrees must also be binary search trees.
//
//
//Example 1:
//
//  2
// / \
//1   3
//
//Input: [2,1,3]
//Output: true

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
      self.val = val
      self.left = nil
      self.right = nil
    }
}
class ValidateBinarySearchTree {
    func isValidBST(_ root: TreeNode?) -> Bool {
        guard let root = root else {
            return true
        }
        
        //Store each value of tree
        var buffer:[Int] = []
        visitBSTNode(root, &buffer)
        
        //Only one means true
        if buffer.count == 1 {
            return true
        }
        
        //Ignore root
        for i in 1 ..< buffer.count {
            //If the current value is <= previous value
            if buffer[i] <= buffer[i-1] {
                return false
            }
        }
        
        return true
    }
    
    //InOrder traversal good for binary search trees
    private func visitBSTNode(_ node: TreeNode, _ buffer: inout [Int]) {
        if let left = node.left {
            visitBSTNode(left, &buffer)
        }
        
        buffer.append(node.val)
        
        if let right = node.right {
            visitBSTNode(right, &buffer)
        }
    }
}
//let validateBinary = ValidateBinarySearchTree()
//let root = TreeNode(2)
//let left = TreeNode(1)
//let right = TreeNode(3)
//root.left = left
//root.right = right
//validateBinary.isValidBST(root)
//==============================================================================

//==============================================================================
//Given a binary tree, flatten it to a linked list in-place.
//
//For example, given the following tree:
//
//     1
//    / \
//   2   5
//  / \   \
// 3   4   6
//The flattened tree should look like:
//
//1
// \
//  2
//  \
//   3
//   \
//    4
//     \
//      5
//       \
//        6
class FlattenBinaryTree {
    private var cur: TreeNode?
    
    func flatten(_ root: TreeNode?) {
        recursiveInOrder(root)
    }
    
    private func recursiveInOrder(_ root: TreeNode?) {
        if let node = root {
            let left = node.left
            let right = node.right
            node.left = nil
            node.right = nil
            if cur != nil {
                cur!.right = node
            }
            cur = node
            recursiveInOrder(left)
            recursiveInOrder(right)
        }
    }
}
let flattenBinary = FlattenBinaryTree()
let root = TreeNode(1)
let left = TreeNode(2)
let right = TreeNode(5)
root.left = left
root.right = right

left.left = TreeNode(3)
left.right = TreeNode(4)
right.right = TreeNode(6)
flattenBinary.flatten(root)
//==============================================================================

//==============================================================================
//Given a binary tree, imagine yourself standing on the right side of it, return the values of the nodes you can see ordered from top to bottom.
//
//Example:
//
//Input: [1,2,3,null,5,null,4]
//Output: [1, 3, 4]

class BinaryTreeRightSideView {
    // dfs(node, res, depth)
    // alwasy visit right node first
    // if depth == res.count, add node.val
    func rightSideView(_ root: TreeNode?) -> [Int] {
        var res = [Int]()
        dfs(root, &res, 0)
        return res
    }
    
    func dfs(_ node: TreeNode?, _ res: inout [Int], _ depth: Int) {
        guard let node = node else {
            return
        }
        
        if depth == res.count {
            res.append(node.val)
        }
        
        dfs(node.right, &res, depth + 1)
        dfs(node.left, &res, depth + 1)
    }
}
//==============================================================================

//==============================================================================
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

class NumberOfIslands {
    func numIslands(_ grid: [[Character]]) -> Int {
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

let numIslands = NumberOfIslands()
numIslands.numIslands([["1"],["1"]])
//==============================================================================

//==============================================================================
//Given a binary tree, return all root-to-leaf paths.
//
//Note: A leaf is a node with no children.
//
//Example:
//
//Input:
//
//    1
//  /   \
// 2     3
// \
//  5
//
//Output: ["1->2->5", "1->3"]

//Explanation: All root-to-leaf paths are: 1->2->5, 1->3

class BinaryTreePaths {
    func binaryTreePaths(_ root: TreeNode?) -> [String] {
        var nodes = [TreeNode]()
        var results = [String]()
        dfs(root, &nodes, &results)
        return results
    }
    
    private func dfs(_ root: TreeNode?, _ arr: inout [TreeNode], _ results: inout [String]) {
        guard let root = root else { return }
        arr.append(root)
        dfs(root.left, &arr, &results)
        dfs(root.right, &arr, &results)
        var tmpString = ""
        for (idx, node) in arr.enumerated() {
            if idx != arr.count - 1 {
                tmpString += "\(node.val)->"
            } else {
                tmpString += "\(node.val)"
            }
        }
        for x in results {
            if x.contains(tmpString) {
                arr.removeLast()
                return
            }
        }
        results.append(tmpString)
        arr.removeLast()
    }
}
//==============================================================================

//==============================================================================
//Given a binary tree, you need to compute the length of the diameter of the tree. The diameter of a binary tree is the length of the longest path between any two nodes in a tree. This path may or may not pass through the root.
//
//Example:
//Given a binary tree
//
//     1
//    / \
//   2   3
//  / \
// 4   5
//Return 3, which is the length of the path [4,2,1,3] or [5,2,1,3].
class DiameterOfBinaryTree {
    func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
        if let r = root {
            let lDiam = longestPath(r.left, currentLength: 0)
            let rDiam = longestPath(r.right, currentLength: 0)
            return max((lDiam + rDiam), diameterOfBinaryTree(r.left), diameterOfBinaryTree(r.right))
        } else {
            return 0
        }
    }
    
    private func longestPath (_ root: TreeNode?, currentLength: Int) -> Int {
        if (root == nil) {
            return currentLength
        }
        if (root!.left == nil && root!.right == nil) {
            // Leaf
            return currentLength + 1
        } else {
            return max(longestPath(root!.left, currentLength: currentLength + 1), longestPath(root!.right, currentLength: currentLength + 1))
        }
    }
}
//==============================================================================

//==============================================================================
//Given a string containing digits from 2-9 inclusive, return all possible letter combinations that the number could represent.
//
//A mapping of digit to letters (just like on the telephone buttons) is given below. Note that 1 does not map to any letters.
//
//Example:
//Input: "23"
//Output: ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"].
class LetterCombinationsOfAPhoneNumber {
    func letterCombinations(_ digits: String) -> [String] {
        //Convert to array
        if digits == "" {
            return []
        }
        let input = Array(digits)
        var combinations = [String]()
        recursiveLetterCombos(input, index: 0, current: "", result: &combinations)
        return combinations
    }
    
    private func recursiveLetterCombos(_ digits: [Character], index: Int, current: String, result: inout [String]) {
        if index == digits.count {
            result.append(current)
            return
        }
        
        if let num = Int(String(digits[index])) {
            let letters = lettersFor(int: num)
            for letter in letters {
                recursiveLetterCombos(digits, index: index + 1, current: current + letter, result: &result)
            }
        }
    }
    
    private func lettersFor(int: Int) -> [String] {
        switch int {
        case 2: return ["a", "b", "c"]
        case 3: return ["d", "e", "f"]
        case 4: return ["g", "h", "i"]
        case 5: return ["j", "k", "l"]
        case 6: return ["m", "n", "o"]
        case 7: return ["p", "q", "r", "s"]
        case 8: return ["t", "u", "v"]
        case 9: return ["w", "x", "y", "z"]
        default: return []
        }
    }
}

let letterCombos = LetterCombinationsOfAPhoneNumber()
letterCombos.letterCombinations("22345").count
