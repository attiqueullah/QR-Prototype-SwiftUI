//
//  MoreBar.swift
//  QRScanner
//
//  Created by Attique Ullah on 11/06/2021.
//

import SwiftUI

struct MoreBar: View {
    
    var services : Services
    var catTitle : QRTitle
    @ObservedObject var viewModel: AnyViewModel<ScanListState, ScanListInput>
    
    var body: some View {
        HStack {
            Text(services.getTitle(category: catTitle))
                .foregroundColor(.init("create_qr"))
                .padding([.leading],16)
            
            Spacer()
            
            NavigationLink(destination:
                            (catTitle == .create ? AnyView(MoreCategoriesView(service: services)) : AnyView(MoreScansView( viewModel: viewModel)))
    
            ) {
                Text("More")
                    .padding([.trailing],16)
                    .foregroundColor(Color.blue)
                    
            }
            
            
        }
        .frame( maxWidth: .infinity, idealHeight: 40, maxHeight: 40)
        .background(Color.clear)
    }
}

struct MoreBar_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = AnyViewModel(ScanListViewModel(service: QRService()))
        MoreBar(services: QRService(), catTitle: .create, viewModel: viewModel)
    }
}
