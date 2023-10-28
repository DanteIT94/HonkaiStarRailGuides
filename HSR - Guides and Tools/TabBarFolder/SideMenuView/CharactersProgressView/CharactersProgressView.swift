//
//  CharactersProgressView.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 26.10.2023.
//

import SwiftUI
import CoreData

@available(iOS 14.0, *)
struct CharactersProgressView: View {
    @State private var searchText = ""
    
    @State private var characters: [CharacterData] = [
        CharacterData(characterImage: Image("default_char"), characterName: "Voloda", isCharacterMax: true, isRelicsGood: false, isWeaponGood: true),
        CharacterData(characterImage: Image("default_char"), characterName: "Vert", isCharacterMax: true, isRelicsGood: false, isWeaponGood: true),
        CharacterData(characterImage: Image("default_char"), characterName: "Alen", isCharacterMax: true, isRelicsGood: false, isWeaponGood: false),
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                //Бар поиска
                TextField("Поиск", text: $searchText)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color.lightGreyDayNight)
                    .cornerRadius(8)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                            
                            if searchText != "" {
                                Button(action: {
                                    self.searchText = ""
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                            }
                        }
                    )
                    .padding(.horizontal, 10)
                
                //CollectionView
                if characters.isEmpty {
                    Text("Вы еще не добавили ваших персонажей")
                        .foregroundColor(.blackDayNight)
                        .multilineTextAlignment(.center)
                        .padding()
                    Spacer()
                } else {
                    ScrollView {
                        Text("Мои Персонажи")
                            .font(.headline)
                            .fontWeight(.heavy)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                            ForEach(characters, id: \.characterName) { character in
                                NavigationLink(destination:
                                                CurrentCharacterView(character: MockCharacter(
                                                    name: character.characterName,
                                                    icon: character.characterImage,
                                                    isBodyOk: character.isCharacterMax,
                                                    isChainOk: character.isRelicsGood,
                                                    isFeetOk: character.isWeaponGood,
                                                    isHandsOk: true,
                                                    isHeadOk: false,
                                                    isLevelMax: true,
                                                    isSphereOk: false,
                                                    isTraitMax: false, isWeaponOk: true))){
                                                        CharacterProgressCell(characterImage: character.characterImage, characterName: character.characterName, isCharacterMax: character.isCharacterMax, isRelicsGood: character.isRelicsGood, isWeaponGood: character.isWeaponGood)
                                                    }
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Прогресс Персонажей")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {
                    //
                }) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.blackDayNight)
                },
                trailing:
                    HStack(spacing: 15) {
                        Button(action: {
                            
                        }) {
                            Image(systemName: "plus")
                                .foregroundColor(.blackDayNight)
                        }
                        Button(action: {
                            
                        }) {
                            Image(systemName: "questionmark.circle")
                                .foregroundColor(.blackDayNight)
                        }
                    }
            )
        }
    }
}

@available(iOS 14.0, *)
struct CharacterProgressView_Preview: PreviewProvider {
    static var previews: some View {
        CharactersProgressView()
    }
}


struct CharacterData {
    var characterImage: Image
    var characterName: String
    var isCharacterMax: Bool
    var isRelicsGood: Bool
    var isWeaponGood: Bool
    var isSelected: Bool = false
}
