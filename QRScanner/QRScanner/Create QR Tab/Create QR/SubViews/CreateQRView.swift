//
//  CreateQRView.swift
//  QRScanner
//
//  Created by Attique Ullah on 11/06/2021.
//

import SwiftUI

enum Category: Int {
    case limited = 12
    case all = 24
}

struct CategoryListState {
    var service: Services
    var categories: [QRModel]
    var lastScans: [QRModel]
}

enum CategoryListInput {
    case hideTitle
}

struct CreateQRView: View {
    
    @ObservedObject var viewModel: AnyViewModel<CategoryListState, CategoryListInput>
    
    var body: some View {
        VStack {
            BannerView()
            VStack(spacing:0) {
                MoreBar(services: viewModel.state.service, catTitle: .create, viewModel: AnyViewModel(ScanListViewModel(service: QRService())))
                Divider()
                QRGRidView(services: viewModel.state.service, data: viewModel.state.categories)
                    .padding([.top], 12)
            }
            .frame(maxWidth: .infinity, idealHeight: 330, maxHeight: 330)
            .background(Color.white)
            .cornerRadius(8.0)
            .padding(.all , 12)
            Spacer()
            
        }
        
        
        
    }
}

struct CreateQRView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = AnyViewModel(QRViewModel(service: QRService()))
        CreateQRView(viewModel: viewModel)
    }
}
