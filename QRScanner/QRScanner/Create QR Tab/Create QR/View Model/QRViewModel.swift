//
//  QRViewModel.swift
//  QRScanner
//
//  Created by Attique Ullah on 11/06/2021.
//

import Foundation
import SwiftUI

class QRViewModel: ViewModel {
    
    @Published var state : CategoryListState
    
    init(service: Services) {
        self.state = CategoryListState(service: service, categories: service.categoryList(24), lastScans: [])
    }
    
    func trigger(_ input: CategoryListInput) {}
}
