//
//  ScanListViewModel.swift
//  QRScanner
//
//  Created by Attique Ullah on 13/06/2021.
//

import Foundation
import SwiftUI

class ScanListViewModel: ViewModel {
    
    @Published var state : ScanListState
   
    init(service: Services) {
        
        self.state = ScanListState(service: service, lastScans: service.lastScanList(0))
    }
    
    func trigger(_ input: ScanListInput) {
        switch input {
        case .delete(let index):
            state.service.removeScan(index: index)
            state.lastScans = state.service.lastScanList(0)
        case .selectAll: break
        }
    }
}

