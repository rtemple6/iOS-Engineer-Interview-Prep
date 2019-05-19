import Foundation

//Convert a non-negative integer to its english words representation. Given input is guaranteed to be less than 2^31 - 1.
public class IntegerToWords {
    public func testCase() {
        let intToWords = IntegerToWords()
        print(intToWords.numberToWords(1234567892))
    }
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
    
    private func numberToWords(_ num: Int) -> String {
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
