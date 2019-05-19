import Foundation

//Given two binary strings, return their sum (also a binary string).
//The input strings are both non-empty and contains only characters 1 or 0.
//Example 1:
//Input: a = "11", b = "1"
//Output: "100"
//Example 2:
//Input: a = "1010", b = "1011"
//Output: "10101"
public class AddBinary {
    
    public func testCase(){
        let addBinary = AddBinary()
        print(addBinary.addBinary("11", "1"))
    }
    
    private func addBinary(_ a: String, _ b: String) -> String {
        //Track the carry
        var carry = 0
        
        //Stores Sum of Two binary strings
        var totalSum = [String]()
        
        //Convert Strings to Arrays of Characters
        var aArray = Array(a)
        var bArray = Array(b)
        
        //Make both arrays even lengths
        while aArray.count != bArray.count {
            if aArray.count > bArray.count {
                bArray.insert(Character(String(0)), at: 0)
            } else {
                aArray.insert(Character(String(0)), at: 0)
            }
        }
        
        //Start at end of array and step backwards
        var index = aArray.count - 1
        while index >= 0 {
            
            //Compute the sum
            let first = Int(String(aArray[index])) ?? 0
            let second = Int(String(bArray[index])) ?? 0
            let sum = first + second + carry
            
            index -= 1
            
            //Sum can be up 0,1,2,3
            switch sum {
            case 0, 1:
                totalSum.append("\(sum)")
                carry = 0
                break
            case 2:
                totalSum.append("0")
                carry = 1
                break
            case 3:
                totalSum.append("1")
                carry = 1
            default:
                break
            }
        }
        
        //Append a final Carry
        if carry != 0 {
            totalSum.append(String(carry))
        }
        
        //Return total sum reversed as a String
        return totalSum.reversed().joined()
    }
}
