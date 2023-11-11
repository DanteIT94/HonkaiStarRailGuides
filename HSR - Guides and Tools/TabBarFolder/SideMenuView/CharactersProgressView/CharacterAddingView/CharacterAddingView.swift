//
//  CharacterAddingView.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 28.10.2023.
//

import SwiftUI
import CoreData
import SDWebImageSwiftUI

@available(iOS 14.0, *)
struct CharacterAddingView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: CharacterCoreData.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \CharacterCoreData.name,
                             ascending: true)
        ]
    ) private var coreDataCharacters: FetchedResults<CharacterCoreData>
    
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(coreDataCharacters.indices, id: \.self) { index in
                    Button(action: {
                        coreDataCharacters[index].isSelectedForAdd.toggle()
                        do {
                            try managedObjectContext.save()
                            checkCoreData()
                        } catch {
                            print("Не удалось сохранить контекст")
                        }
                    }) {
                        HStack(alignment: .center, spacing: 10)  {
                            WebImage(url: URL(string:  coreDataCharacters[index].iconImageURL ?? ""))
                                .resizable()
                                .indicator(.activity)
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .padding(.leading, 5)
                            Text(coreDataCharacters[index].name ?? "Персонаж")
                                .foregroundColor(Color.whiteDayNight)
                                
                        }
                        .frame(width: 130, height: 50, alignment: .leading)
                        .padding()
                        
                    }
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(coreDataCharacters[index].isSelectedForAdd ? Color.green : Color.gray, lineWidth: 4)
                    )
                    
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .navigationTitle("Добавь персонажей")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .navigationBarItems(
                leading:
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    },
                           label: {
                               Image(systemName: "chevron.backward")
                           })
                )
        }
    }
    
    func checkCoreData() {
        let fetchRequest: NSFetchRequest<CharacterCoreData> = CharacterCoreData.fetchRequest()
        
        do {
            // Выполняем запрос к контексту CoreData
            let allCharacters = try CoreDataStack.shared.context.fetch(fetchRequest)
            
            // Печатаем каждый объект
            for character in allCharacters {
                print("ID: \(character.id ?? "N/A"), Name: \(character.name ?? "N/A"), IsSelectedForAdd: \(character.isSelectedForAdd), IsFavorite: \(character.isFavorite)")
            }
            
        } catch {
            print("Ошибка при извлечении данных: \(error)")
        }
    }
}

