//
//  QRService.swift
//  QRScanner
//
//  Created by Attique Ullah on 11/06/2021.
//

import Foundation

enum QRTitle : String{
    case create = "CREATE QR"
    case lScans = "LAST SCANS"
}

protocol Services {
    
    func getTitle(category: QRTitle)-> String
    // Category list
    func categoryList(_ max: Int) -> [QRModel]
    
    // Last Scan list
    func lastScanList(_ max: Int) -> [String]
    
    
    func removeScan(index:Int)
}

class QRService: Services {
    
    // MARK: Mock data
    
    var lastScans: [String] = [
        "Scan 1",
        "Scan 2",
        "Scan 3",
        "Scan 4",
        "Scan 5"
    ]
    
    var categories: [QRModel] {
        if let baseURL = Bundle.main.path(forResource: "QRData", ofType: "plist") {
            if let codeDic = NSArray(contentsOfFile: baseURL){
                return createArray(list: codeDic as! [[String : Any]])
            }
            else {
                return []
            }
        }else {
            return []
        }
    }
    
    
    private func createArray(list:[[String: Any]])->[QRModel]{
        var array :[QRModel] = []

        for item in list {
            let check = QRModel(name: item["name"] as? String ?? "", image: item["image"] as? String ?? "")
            array.append(check)
        }
        return array
    }
    
    func categoryList(_ max: Int) -> [QRModel] {
        return Array(categories.prefix(max))
    }
    
    func lastScanList(_ max: Int) -> [String] {
        return lastScans
    }
    
    func getTitle(category: QRTitle)-> String {
        return category.rawValue
    }
    
    func removeScan(index:Int) {
        lastScans.remove(at: index)
    }
}
