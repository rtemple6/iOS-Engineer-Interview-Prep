import Foundation

//Given a binary tree, imagine yourself standing on the right side of it, return the values of the nodes you can see ordered from top to bottom.
//
//Example:
//
//Input: [1,2,3,null,5,null,4]
//Output: [1, 3, 4] 

public class BinaryTreeRightSideView {
    public func testCase() {
        
    }
    // dfs(node, res, depth)
    // alwasy visit right node first
    // if depth == res.count, add node.val
    private func rightSideView(_ root: TreeNode?) -> [Int] {
        var res = [Int]()
        dfs(root, &res, 0)
        return res
    }
    
    private func dfs(_ node: TreeNode?, _ res: inout [Int], _ depth: Int) {
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
