//
//  BannerView.swift
//  QRScanner
//
//  Created by Attique Ullah on 11/06/2021.
//

import SwiftUI

struct BannerView: View {
    var body: some View {
        Image("admob_banner 1")
            .resizable()
            .frame(height: 54)
    }
}

struct BannerView_Previews: PreviewProvider {
    static var previews: some View {
        BannerView()
    }
}
