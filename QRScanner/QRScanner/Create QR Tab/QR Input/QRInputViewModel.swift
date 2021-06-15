//
//  QRInputViewModel.swift
//  QRScanner
//
//  Created by Attique Ullah on 12/06/2021.
//

import Foundation
import SwiftUI
import Combine

enum URLCheck {
    case valid
    case empty
    case invalid
}

class QRInputViewModel: ObservableObject {
    
    @Published var txtURL : String = ""
    @Published var urlMessage: String  = ""
    
    
    private var disposables = Set<AnyCancellable>()
    
    init() {
        
        initializeURLPubisher()

    }
    
    private func initializeURLPubisher() {
        isURLValidPublisher
            .receive(on: RunLoop.main)
            .map { status in
                switch status {
                case .empty : return ""
                case .valid : return ""
                case .invalid : return "URL is not valid. Please enter correct url."
                }
            }
            .assign(to: \.urlMessage, on: self)
            .store(in: &disposables)
    }
    
    private var isURLValidPublisher : AnyPublisher<URLCheck,Never> {
        Publishers.CombineLatest( isURLAddressEmpty, isURLAddressValid)
            .map({ isURLEmpty, isURLValid in
                if isURLEmpty {
                    return .empty
                }
                else if (isURLValid) {
                    return .valid
                }
                return .invalid
            })
            .eraseToAnyPublisher()
    }
    private var isURLAddressValid : AnyPublisher<Bool,Never> {
        $txtURL
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                return self.verifyUrl(urlString: input)
            }
            .eraseToAnyPublisher()
    }
    private var isURLAddressEmpty : AnyPublisher<Bool,Never> {
        $txtURL
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                return input.count == 0
            }
            .eraseToAnyPublisher()
    }
    
    private func verifyUrl (urlString: String?) -> Bool {
        if urlString?.count == 0 {
            return false
        }
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
}
