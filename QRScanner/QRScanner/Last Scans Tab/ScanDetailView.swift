//
//  ScanDetailView.swift
//  QRScanner
//
//  Created by Attique Ullah on 15/06/2021.
//

import SwiftUI

struct ScanDetailView: View {
    var body: some View {
        ZStack {
            Color.init("background")
            .edgesIgnoringSafeArea(.all)
            
            VStack (spacing: 12.0){
                Spacer()
                    .frame(height: 20)
                HStack(alignment: .center, spacing: 12.0, content: {
                    ScanImageView()
                    VStack(alignment: .leading, spacing: 12.0, content: {
                        ScanTypeView(lblType: "Code type", lblValue: "QR")
                        ScanTypeView(lblType: "Element", lblValue: "Website")
                    })
                })
                .frame(maxWidth:.infinity,maxHeight: 132)
                
                ScanWebView()
            
                Button(action: {
                    
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                                        .fill(Color.blue)
                                        .frame(height: 56)
                        Text("Open in brower")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            
                            
                    }
                    
                })
                Spacer()
            }
            .padding([.leading,.trailing],15)
            .navigationTitle("Scan result")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {
                
            }, label: {
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: 20))
            }))
        }
    }
}

struct ScanDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ScanDetailView()
        ScanImageView()
        ScanTypeView(lblType: "Code type", lblValue: "QR")
        ScanWebView()
    }
}

struct ScanImageView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 0.0, content: {
            Image("SSCC18 1")
                .padding([.leading,.trailing],3)
        })
        .frame(width: 132, height: 132, alignment: .center)
        .background(Color.white)
    }
}

struct ScanTypeView: View {
    
    var lblType : String
    var lblValue: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 16.0, content: {
            VStack(alignment: .leading, spacing: 6.0, content: {
                Text(lblType)
                    .font(.system(size: 11))
                
                Text(lblValue)
                    .font(.system(size: 13))
                    .foregroundColor(.blue)
            })
            .padding(16)
            Spacer()
        })
        .frame(maxWidth:.infinity,maxHeight: 60)
        .background(Color.white)
        .cornerRadius(6.0)
    }
}

struct ScanWebView: View {
    var body: some View {
        ZStack(alignment: .init(horizontal: .trailing, vertical: .center)) {
            ScanTypeView(lblType: "Website", lblValue: "https:www.apple.com")
            Image(systemName: "eye.circle")
                .frame(width: 34, height: 34, alignment: .trailing)
                .font(.title)
                .padding(.trailing, 15)
                .foregroundColor(.blue)
        }
        .cornerRadius(6.0)
    }
}
