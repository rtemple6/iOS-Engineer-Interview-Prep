import Foundation
import UIKit

public class SetOperations {
    public func testCase() {
        //Set operations
        var colors: Set<UIColor> = [.red, .blue, .purple]
        let colors1: Set<UIColor> = [.red, .black, .purple]
        
        //colors.contains(.red)
        //colors.remove(.red)
        //colors.insert(.green)
        
        //Order not guranteed
        for color in colors1 {
            print(color)
        }
        
        //Returns all color in colors1 that also in colors
        print(colors.intersection(colors1))
        //Removes all color in colors that colors1 contains
        colors.subtract(colors1)
    }
}

