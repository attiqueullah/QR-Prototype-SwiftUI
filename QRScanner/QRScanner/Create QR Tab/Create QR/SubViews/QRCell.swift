//
//  QRCell.swift
//  QRScanner
//
//  Created by Attique Ullah on 11/06/2021.
//

import SwiftUI

struct QRCell: View {
    
    var item: QRModel
    
    var body: some View {
        VStack {
            Image(item.image)
                .resizable()
                .frame(width: 60, height: 60, alignment: .center)
            Spacer()
                .frame(height: 7)
            Text(item.name)
                .font(.system(size: 12))
        }
        .frame(width: 62, height: 80)
    }
}

struct QRCell_Previews: PreviewProvider {
    static var previews: some View {
        QRCell(item: QRModel(name: "Email", image: "mail"))
    }
}
