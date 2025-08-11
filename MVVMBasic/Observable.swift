//
//  Observable.swift
//  MVVMBasic
//
//  Created by 박현진 on 8/11/25.
//

import Foundation

class Observable {
    
    private var action: ((String) -> Void)?
    
    var value :String {
        didSet {
            print("값 변경 확인", oldValue, value)
            action?(value)
        }
    }
    
    init(value: String) {
        self.value = value
    }
    
    func bind(closure: @escaping (String) -> Void) {
        print(#function, "START")
        closure(value)
        action = closure
        print(#function, "END")

    }
}
