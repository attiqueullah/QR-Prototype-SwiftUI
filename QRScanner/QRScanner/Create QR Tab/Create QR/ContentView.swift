//
//  ContentView.swift
//  QRScanner
//
//  Created by Attique Ullah on 11/06/2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: AnyViewModel<CategoryListState, CategoryListInput>
    
    var body: some View {
        NavigationView(content: {
            ZStack {
                Color.init("background")
                .edgesIgnoringSafeArea(.all)
                VStack {
                    CreateQRView(viewModel: viewModel)
                }
            }
            .padding(.top)
            .navigationTitle("Create QR")
        })
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = AnyViewModel(QRViewModel(service: QRService()))
        ContentView(viewModel: viewModel)
    }
}
