//
//  MoreCategoriesView.swift
//  QRScanner
//
//  Created by Attique Ullah on 12/06/2021.
//

import SwiftUI

struct MoreCategoriesView: View {
    
    @ObservedObject var viewModel: AnyViewModel<CategoryListState, CategoryListInput>
    
    init(service: Services) {
        self.viewModel = AnyViewModel(QRViewModel(service: service))
    }
    
    var body: some View {
        VStack {
            BannerView()
            QRGRidView(services: viewModel.state.service, data: viewModel.state.service.categoryList(Category.all.rawValue))
                .padding([.top], 12)
        }
        .navigationTitle("Create QR")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct MoreCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        MoreCategoriesView(service: QRService())
    }
}
