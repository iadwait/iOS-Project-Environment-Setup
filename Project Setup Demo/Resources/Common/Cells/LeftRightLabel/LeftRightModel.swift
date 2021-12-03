//
//  LeftRightModel.swift
//  Project Setup Demo
//
//  Created by Adwait Barkale on 03/12/21.
//

import Foundation

/// This Class is used to hold Left Label Data and Right Label Data
class LeftRightModel {
    
    // MARK: - Variable Declaration
    
    var leftData = String()
    var rightData = String()
    
    // MARK: - User Defined Functions
    
    /// Function call when user need to create object of left right label data
    /// - Parameters:
    ///   - leftLabelData: Left Label
    ///   - rightLabelData: Right Label
    class func createObject(leftLabelData: String,rightLabelData: String) -> LeftRightModel {
        let obj = LeftRightModel()
        obj.leftData = leftLabelData
        obj.rightData = rightLabelData
        return obj
    }
    
}
