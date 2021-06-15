//
//  QRGRidView.swift
//  QRScanner
//
//  Created by Attique Ullah on 11/06/2021.
//

import SwiftUI

struct QRGRidView: View {
    
    var services : Services
    var data : [QRModel]
   
    let columns = [
        GridItem(.flexible(minimum: 60, maximum: 180), spacing: 30),
        GridItem(.flexible(minimum: 60, maximum: 180), spacing: 30),
        GridItem(.flexible(minimum: 60, maximum: 180), spacing: 30),
        GridItem(.flexible(minimum: 60, maximum: 180), spacing: 30)
        ]

    var body: some View {
        ScrollView ([], showsIndicators: false, content: {
            LazyVGrid(columns: columns, alignment: .center, spacing: 13) {
                
                        ForEach(data, id: \.self) { item in
                            NavigationLink(destination: QRInputView()) {
                                QRCell(item: item)
                            }
                        }
                    }
        })
        //.frame(maxHeight:.infinity)
        .background(Color.clear)
        
       
        
    }
}

struct QRGRidView_Previews: PreviewProvider {
    static var previews: some View {
        QRGRidView(services: QRService(), data: [])
    }
}
