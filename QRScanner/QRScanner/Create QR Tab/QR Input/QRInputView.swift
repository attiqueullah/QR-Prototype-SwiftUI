//
//  QRInputView.swift
//  QRScanner
//
//  Created by Attique Ullah on 12/06/2021.
//

import SwiftUI



enum QRCreateInput {
    case done
    case cancel
}

struct QRInputView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var qrViewModel: QRInputViewModel = QRInputViewModel()
    @State private var isAlert = false
   
    var body: some View {
        List (content: {
            Section(header:
                        Text(qrViewModel.urlMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                 ,footer: Text("Indicate the link to the website that you want to convert into a QR code. When someone scans such a QR code, it will open this website in a browser."), content: {
                CustomField(text: $qrViewModel.txtURL)
                      .placeholder("URL-address")
            })
            
        })
        .alert(isPresented: $isAlert, content: {
            Alert(title: Text("QR Scanner"), message: Text(qrViewModel.urlMessage), dismissButton: .default(Text("Ok")))
        })
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(GroupedListStyle())
        .navigationTitle("QR: Website")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action: {
                navigationButtonPressed(input: .done)
            }, label: {
                Text("Cancel")
            }),
            trailing: Button(action: {
                if qrViewModel.urlMessage.count > 0 {
                    self.isAlert = true
                }
                else {
                    navigationButtonPressed(input: .cancel)
                }
                
            }, label: {
                Text("Done")
            })
            )
    }
}

private extension QRInputView {
    func navigationButtonPressed(input:QRCreateInput){
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct QRInputView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            QRInputView()
        }
        
    }
}

struct CustomField: UIViewRepresentable {

    class Coordinator: NSObject, UITextFieldDelegate {

        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }

    }
    
    @Binding var text: String
    private var placeholder = ""
    
    init(text:Binding<String>) {
        _text = text
    }
    
    func makeUIView(context: UIViewRepresentableContext<CustomField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        uiView.placeholder = placeholder
        uiView.becomeFirstResponder()
    }
    
    func makeCoordinator() -> CustomField.Coordinator {
        return Coordinator(text: $text)
    }
    
}

extension CustomField {
    func placeholder(_ text:String) -> CustomField{
        var view = self
        view.placeholder = text
        return view
    }
}
