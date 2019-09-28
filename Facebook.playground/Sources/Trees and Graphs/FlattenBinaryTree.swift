import Foundation

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
public class FlattenBinaryTree {
    private var cur: TreeNode?
    
    public func testCase() {
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
    }
    
    private func flatten(_ root: TreeNode?) {
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

