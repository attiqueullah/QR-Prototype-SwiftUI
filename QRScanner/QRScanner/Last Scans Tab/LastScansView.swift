//
//  LastScansView.swift
//  QRScanner
//
//  Created by Attique Ullah on 13/06/2021.
//

import SwiftUI

struct ScanListState {
    var service: Services
    var lastScans: [String]
}

enum ScanListInput {
    case delete(Int)
    case selectAll
}

struct LastScansMainView: View {
    
    @ObservedObject var viewModel: AnyViewModel<ScanListState, ScanListInput>
    
    var body: some View {
        
        NavigationView(content: {
            ZStack {
                Color.init("background")
                .edgesIgnoringSafeArea(.all)
                VStack {
                    LastScansView(viewModel: viewModel)
                }
            }
            .padding(.top)
            
        })
        
    }
}


struct LastScansView: View {
    
    @ObservedObject var viewModel: AnyViewModel<ScanListState, ScanListInput>
    
    var body: some View {
        VStack {
            BannerView()
            VStack(spacing:0) {
                MoreBar(services: viewModel.state.service, catTitle: .lScans, viewModel: viewModel)
                Divider()
                ScanListView(scrollEnable: false, isDelete: .constant(false), selection: .constant(Set<String>()), viewModel: viewModel)
            }
            .frame(maxWidth: .infinity, idealHeight: 330, maxHeight: 400)
            .background(Color.white)
            .cornerRadius(8.0)
            .padding(.all , 12)
            Spacer()
            
        }
        .navigationTitle("Last Scans")
        
    }
}

struct ScanListView: View {
    
    var scrollEnable: Bool
    @Binding var isDelete : Bool
    @Binding var selection : Set<String>
    @ObservedObject var viewModel: AnyViewModel<ScanListState, ScanListInput>
    
    @State private var isBackButtonHidden : Bool = false
    @State var editMode: EditMode = .inactive
   
   
    var body: some View {
        List(viewModel.state.lastScans, id: \.self, selection: $selection, rowContent: { item in
            NavigationLink(destination: ScanDetailView()) {
                ScanCellView()
            }
        })
        
        .listStyle(PlainListStyle())
        .hasScrollEnabled(scrollEnable)
        .navigationBarBackButtonHidden(isBackButtonHidden)
        .navigationBarItems(leading: selectAllButton , trailing: editButton)
        .environment(\.editMode, self.$editMode)
        
        
    }
    
    private var editButton: AnyView {
        if scrollEnable {
            let view =   Button(action: {
                self.editMode.toggle()
                if self.editMode == .inactive {
                    selection = Set<String>()
                }
                self.isBackButtonHidden.toggle()
                withAnimation(.spring()) {
                    self.isDelete.toggle()
                }
            }) {self.editMode.title}
            
            return AnyView(view)
        }
        
       return AnyView(EmptyView())
    }
    
    private var selectAllButton: AnyView {
        if isBackButtonHidden {
            let view =   Button(action: {
                selection = Set(viewModel.state.lastScans.map { $0 })
            }) {
                Text("Select All")
                .fontWeight(.semibold)
            }
            return AnyView(view)
        }
        return AnyView(EmptyView())
    }
    
    
}


struct ScanCellView: View {
    var body: some View {
        HStack(alignment:.top,spacing: 10, content: {
            Image("barcode")
            VStack(alignment: .leading) {
               Text("Barcode 3284209420")
                .fontWeight(.semibold)
                .font(.system(size: 15))
                Spacer()
                    .frame(height: 6)
               Text("Barcode • 28:03:2020, 02:21 pm")
                .foregroundColor(Color.init("create_qr"))
                .font(.system(size: 13))
            }
            Spacer()
            
        })
        .frame( maxWidth: .infinity, idealHeight: 60.0, maxHeight: 60.0)
    }
}

extension View {
    
    func hasScrollEnabled(_ value: Bool) -> some View {
        self.onAppear {
            UITableView.appearance().isScrollEnabled = value
        }
    }
}

extension EditMode {
    var title: some View {
        self == .active ? AnyView(Text("Done").fontWeight(.semibold)) : AnyView(Image(systemName: "square.and.pencil").font(.system(size: 20)))
    }

    mutating func toggle() {
        self = self == .active ? .inactive : .active
    }
}


struct LastScansView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = AnyViewModel(ScanListViewModel(service: QRService()))
        LastScansMainView(viewModel: viewModel)
        LastScansView(viewModel: viewModel)
        ScanListView(scrollEnable: false, isDelete: .constant(false), selection: .constant(Set<String>()), viewModel: viewModel)
        ScanCellView()
        
    }
}
