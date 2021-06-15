//
//  MainView.swift
//  QRScanner
//
//  Created by Attique Ullah on 13/06/2021.
//

import SwiftUI

struct MainView: View {
    
    let viewModel = AnyViewModel(QRViewModel(service: QRService()))
    let scanViewModel = AnyViewModel(ScanListViewModel(service: QRService()))
    
    var body: some View {
        TabView {
            ContentView(viewModel: viewModel).tabItem { Label("Create QR", systemImage: "barcode.viewfinder") }.tag(1)
            
            LastScansMainView(viewModel: scanViewModel).tabItem { Label("Last Scans", systemImage: "clock") }.tag(2)
        }

    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
