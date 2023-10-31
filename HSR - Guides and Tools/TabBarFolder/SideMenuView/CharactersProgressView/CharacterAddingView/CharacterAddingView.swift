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
                        HStack {
                            WebImage(url: URL(string:  coreDataCharacters[index].iconImageURL ?? ""))
                                .resizable()
                                .indicator(.activity)
                                .frame(width: 50, height: 50)
                                .padding()
                            Text(coreDataCharacters[index].name ?? "Персонаж")
                        }
                        .frame(width: 150, height: 50)
                        .padding()
                        .border(coreDataCharacters[index].isSelectedForAdd ? Color.green : Color.gray, width: 2)
                    }
                    
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
                           }),
                trailing:
                    Button(action: {
                        
                    }, 
                           label: {
                        Text("Сохранить")
                    }))
            
        }
    
    func checkCoreData() {
        let fetchRequest: NSFetchRequest<CharacterCoreData> = CharacterCoreData.fetchRequest()

        do {
            // Выполняем запрос к контексту CoreData
            let allCharacters = try CoreDataStack.shared.context.fetch(fetchRequest)
            
            // Печатаем каждый объект
            for character in allCharacters {
                print("ID: \(character.id ?? "N/A"), Name: \(character.name ?? "N/A"), IsSelectedForAdd: \(character.isSelectedForAdd)")
            }
            
        } catch {
            print("Ошибка при извлечении данных: \(error)")
        }
    }
}

