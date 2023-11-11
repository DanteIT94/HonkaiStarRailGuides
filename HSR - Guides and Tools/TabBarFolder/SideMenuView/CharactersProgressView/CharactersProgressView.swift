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
    @Environment(\.presentationMode) var presentationMode
    
    @State var showQuestionView = false
    @State private var searchText = ""
    @FetchRequest private var favoriteCharacters: FetchedResults<CharacterCoreData>
    @FetchRequest private var myCharacters: FetchedResults<CharacterCoreData>
    
    init() {
//        let predicateIsSelectedForAdd = NSPredicate(format: "isSelectedForAdd == %@", NSNumber(value: true))
//        let predicateIsNotFavorite = NSPredicate(format: "inFavorite == %@", NSNumber(value: false))
//        
//        let combinedPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicateIsSelectedForAdd, predicateIsNotFavorite])
        
        _myCharacters = FetchRequest<CharacterCoreData>(
            entity: CharacterCoreData.entity(),
            sortDescriptors: [
            NSSortDescriptor(
                keyPath: \CharacterCoreData.name,
                ascending: true)],
        predicate: NSPredicate(format: "isFavorite == %@ AND isSelectedForAdd == %@", NSNumber(value: false), NSNumber(true)))
        
        _favoriteCharacters = FetchRequest<CharacterCoreData>(
            entity: CharacterCoreData.entity(),
            sortDescriptors: [
            NSSortDescriptor(
                keyPath: \CharacterCoreData.name,
                ascending: true)
            ],
            predicate: NSPredicate(format: "isFavorite == %@ AND isSelectedForAdd == %@", NSNumber(value: true), NSNumber(value: true)))
        
    }
    
    
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
                
                //                CollectionView
                if myCharacters.isEmpty {
                    Text("Вы еще не добавили ваших персонажей")
                        .foregroundColor(.blackDayNight)
                        .multilineTextAlignment(.center)
                        .padding()
                    Spacer()
                } else {
                    ScrollView {
                        if !favoriteCharacters.isEmpty {
                            Text("Избранные")
                                .font(.headline)
                                .fontWeight(.heavy)
                            
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                                ForEach(favoriteCharacters, id: \.id) { character in
//                                    Text("Количество избранных персонажей: \(favouriteCharacters.count)")
                                    NavigationLink(destination: CurrentCharacterView(character: character)) {
                                        CharacterProgressCell(
                                            character: character,
                                            characterImageURL: URL(string: character.iconImageURL ?? ""),
                                            characterName: character.name ?? "Char",
                                            isCharacterMax: character.isCharacterMax,
                                            isRelicsGood: character.isRelicsOk,
                                            isWeaponGood: character.isWeaponOk
                                        )
                                    }
                                }
                            }
                        }
                        
                        if !myCharacters.isEmpty {
                            Text("Мои Персонажи")
                                .font(.headline)
                                .fontWeight(.heavy)
                            
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                                ForEach(myCharacters, id: \.id) { character in
//                                    Text("Количество  моих персонажей: \(myCharacters.count)")
                                    NavigationLink(destination: CurrentCharacterView(character: character)) {
                                        CharacterProgressCell(
                                            character: character,
                                            characterImageURL: URL(string: character.iconImageURL ?? ""),
                                            characterName: character.name ?? "Char",
                                            isCharacterMax: character.isCharacterMax,
                                            isRelicsGood: character.isRelicsOk,
                                            isWeaponGood: character.isWeaponOk
                                        )
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Прогресс Персонажей")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.blackDayNight)
                },
                trailing:
                    HStack(spacing: 15) {
                        NavigationLink(destination: CharacterAddingView()
                            .environment(\.managedObjectContext, CoreDataStack.shared.context))
                        {
                            Image(systemName: "plus")
                                .foregroundColor(.blackDayNight)
                        }
                        Button(action: {
                            self.showQuestionView.toggle()
                        }) {
                            Image(systemName: "questionmark.circle")
                                .foregroundColor(.blackDayNight)
                        }
                    }
            )
        }
        .overlay(
            Group {
                if showQuestionView {
                    QuestionView(showQuestionView: $showQuestionView)
                }
            })
    }
}



@available(iOS 14.0, *)
struct CharacterProgressView_Preview: PreviewProvider {
    static var previews: some View {
        CharactersProgressView()
    }
}

