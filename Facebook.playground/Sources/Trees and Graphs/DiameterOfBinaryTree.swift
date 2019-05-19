import Foundation

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
public class DiameterOfBinaryTree {
    public func testCase() {
        
    }
    private func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
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
