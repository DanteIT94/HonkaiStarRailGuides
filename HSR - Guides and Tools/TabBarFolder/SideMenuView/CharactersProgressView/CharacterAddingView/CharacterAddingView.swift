//
//  CharacterAddingView.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 28.10.2023.
//

import SwiftUI

@available(iOS 14.0, *)
struct CharacterAddingView: View {
    @Binding var characters: [CharacterData]
    
    var body: some View {
        NavigationView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(characters.indices, id: \.self) { index in
                    Button(action: {
                        characters[index].isSelected.toggle()
                    }) {
                        HStack {
                            characters[index].characterImage
                                .resizable()
                                .frame(width: 50, height: 50)
                                .padding()
                            Text(characters[index].characterName)
                        }
                        .frame(width: 150, height: 50)
                        .padding()
                        .border(characters[index].isSelected ? Color.green : Color.gray, width: 2)
                    }
                    
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .navigationTitle("Добавь персонажей")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading:
                    Button(action: {
                        
                    },
                           label: {
                               Image(systemName: "chevron.backward")
                           }),
                trailing:
                    Button(action: {
                        
                    }, 
                           label: {
                        Text("Сохранить")
                    }))
            
        }
    }
}

@available(iOS 14.0, *)
struct CharacterAddingView_Preview: PreviewProvider {
    
    static var previews: some View {
        CharacterAddingView_PreviewContainer()
    }
    
    struct CharacterAddingView_PreviewContainer: View {
        @State var mockCharacters: [CharacterData] = [
            CharacterData(characterImage: Image("default_char"), characterName: "Voloda", isCharacterMax: true, isRelicsGood: false, isWeaponGood: true, isSelected: false),
            CharacterData(characterImage: Image("default_char"), characterName: "Vert", isCharacterMax: true, isRelicsGood: false, isWeaponGood: true, isSelected: true),
            CharacterData(characterImage: Image("default_char"), characterName: "Alen", isCharacterMax: true, isRelicsGood: false, isWeaponGood: false, isSelected: false),
        ]
        
        var body: some View {
            CharacterAddingView(characters: $mockCharacters)
        }
    }
}
