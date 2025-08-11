//
//  MapViewModel.swift
//  MVVMBasic
//
//  Created by 박현진 on 8/12/25.
//

import Foundation


class MapViewModel {
    
    var inputCategory = Observable(value: "")
    
    init() {
        inputCategory.bind { value in
            //self.resultErrorCheck()
        }
    }
    
    var outputMenu = Observable(value: "")
    
    
    
}
