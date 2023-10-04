//
//  DeveloperView.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 02.10.2023.
//

import SwiftUI

struct DeveloperView: View {
    @ObservedObject var viewModel = ExternalLinksViewModel()
    @State private var showingMail = false
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Image("developerImage")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                    VStack(alignment: .center) {
                      Text("Денис")
                            .font(.headline)
                        Text("Чакыр")
                            .font(.headline)
                    }
                    .padding([.leading, .trailing], 20)
                }
                
                VStack (alignment: .leading) {
                    Text("Моя история")
                        .font(.headline)
                    Text("Тут более подробная инсформация обо мне ")
                        .font(.subheadline)
                }
                .padding(.top)
                .padding([.leading, .trailing], 20)
                
                VStack(alignment: .leading) {
                    Text("Обратная связь")
                        .font(.headline)
                    Button(action: {
                        viewModel.openDeveloperTelegram()
                    
                    }) {
                        HStack {
                            Image(systemName: "paperplane.fill")
                            Text("Telegram:")
                            Spacer()
                            Text("@ChakyrIT")
                        }
                    }
                    .sheet(isPresented: $viewModel.showSafari) {
                        if let url = viewModel.safariURL {
                            SafariView(url: url)
                        }
                    }
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "envelope.fill")
                            Text("Почта:")
                            Spacer()
                            Text("ChakyrIT@gmail.com")
                        }
                    }
                }
                .padding(.top)
                .padding([.leading, .trailing], 20)

            }
        }
        .padding()
        .navigationBarTitle("О разработчике", displayMode: .inline)
    }
}


struct Developer_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            DeveloperView()
        } else {
            
        }
    }
}
