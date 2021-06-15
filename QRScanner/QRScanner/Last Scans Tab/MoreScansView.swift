//
//  MoreScansView.swift
//  QRScanner
//
//  Created by Attique Ullah on 13/06/2021.
//

import SwiftUI

struct MoreScansView: View {
    
    @State var isDelete : Bool = false
    @ObservedObject var viewModel: AnyViewModel<ScanListState, ScanListInput>
    @State private var selection = Set<String>()
    
    var body: some View {
        VStack {
            BannerView()
            ScanListView(scrollEnable: true, isDelete: $isDelete, selection: $selection, viewModel: viewModel)
                .padding([.top], 12)
            if isDelete {
                DeleteScansView(isDelete: $isDelete, selection: $selection, viewModel: viewModel)
            }
            else {
                EmptyView()
            }
        }
        .navigationTitle("Last Scans")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MoreScansView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = AnyViewModel(ScanListViewModel(service: QRService()))
        MoreScansView( viewModel: viewModel)
        DeleteScansView(isDelete: .constant(false), selection: .constant(Set<String>()), viewModel: viewModel)
    }
}

struct DeleteScansView: View {
    
    @Binding var isDelete : Bool
    @Binding var selection: Set<String>
    @State private var deleteAlert : Bool = false
    @ObservedObject var viewModel: AnyViewModel<ScanListState, ScanListInput>
    
    var body: some View {
        VStack {
            Divider()
                .background(Color.gray)
            ZStack {
                Button(action: {
                    self.deleteAlert.toggle()
                }, label: {
                    Text("Delete")
                        .foregroundColor((isDelete && selection.count > 0) ? .red:.gray)
                    
                })
                .frame(width: 110, height: 44.0, alignment: .center)
                .disabled(!isDelete)
            }
            .frame( maxWidth: .infinity, idealHeight: 80.0, maxHeight: 80.0, alignment: .topTrailing)
            .background(Color.init("bottom"))
            .edgesIgnoringSafeArea(.bottom)
        }
        .alert(isPresented: $deleteAlert, content: {
            Alert(title: Text("Are you sure?"), message: Text("Selected file(s) will be deleted. This action cannot be undone."), primaryButton: .cancel(), secondaryButton: .destructive(Text("Delete"), action: {
                deleteNumbers()
            }))
        })
    }
    
    private func deleteNumbers() {
        for id in selection {
            if let index = viewModel.lastScans.lastIndex(where: { $0 == id })  {
                viewModel.trigger(.delete(index))
                }
            }
        selection = Set<String>()
    }
}
