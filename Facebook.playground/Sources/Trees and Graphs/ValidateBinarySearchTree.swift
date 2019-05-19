import Foundation

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


public class ValidateBinarySearchTree {
    public func testCase() {
        let validateBinary = ValidateBinarySearchTree()
        let root = TreeNode(2)
        let left = TreeNode(1)
        let right = TreeNode(3)
        root.left = left
        root.right = right
        validateBinary.isValidBST(root)

    }
    private func isValidBST(_ root: TreeNode?) -> Bool {
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
