import Foundation

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

public class BinaryTreePaths {
    public func testCase() {
        
    }
    private func binaryTreePaths(_ root: TreeNode?) -> [String] {
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
