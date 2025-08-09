//
//  Extension+UIViewcontroller.swift
//  MVVMBasic
//
//  Created by 박현진 on 8/7/25.
//

import Foundation
import UIKit

extension UIViewController {
    
    func BMIcalculator<T: BinaryFloatingPoint>(weight: T, height: T) -> Int {
        
        let result = weight / ((height * 0.01) * (height * 0.01))
        return Int(result)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "문제 발생", message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func Birthday<T: Numeric>(year: T, month: T, day: T) -> String {
        
//        let inputDate = year + month + day
//        
//        let format = DateFormatter()
//        format.dateFormat = "yyyy-MM-dd"
//        let startDate = format.date(from: inputDate as! String)
//        for i in 0...3 {
//            let datePicker = UIDatePicker()
//            print(datePicker.date.addingTimeInterval(TimeInterval(60*60*24*100*(i+1))).formatted(date: .complete, time: .omitted))
//        }
        return "\(year)년 \(month)월 \(day)일 + 130일입니다"
    }
}
