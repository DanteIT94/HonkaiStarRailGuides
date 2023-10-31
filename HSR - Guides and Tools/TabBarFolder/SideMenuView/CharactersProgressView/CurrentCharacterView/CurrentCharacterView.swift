//
//  CharacterView.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 27.10.2023.
//

import SwiftUI
import CoreData


enum GroupType: String, CaseIterable {
    case characteristics = "Опыт и таланты Персонажа"
    case relics = "Реликвии персонажа"
    case weapon = "Оружие персонажа"
}

@available(iOS 14.0, *)
struct CurrentCharacterView: View {
    @Environment (\.presentationMode) var presentationMode
    @ObservedObject var character: CharacterCoreData
    @Environment(\.managedObjectContext) private var moc
    
    var body: some View {
            VStack {
                GroupBox(
                    label: Text(GroupType.characteristics.rawValue), content: {
                    VStack {
                        Toggle("is Level Max?", isOn: $character.isLevelMax)
                            .onChange(of: character.isLevelMax) { _ in
                            saveChanges()}
                        Toggle("is Traits Max?", isOn: $character.isTraitMax)
                    }
                })
                
                GroupBox(
                    label: Text(GroupType.relics.rawValue),
                    content: {
                        VStack {
                            Toggle("is Head Good?", isOn: $character.isHeadOk)
                            Toggle("is Hands Good?", isOn: $character.isHandsOk)
                            Toggle("is Body Good?", isOn: $character.isBodyOk)
                            Toggle("is Feet Good?", isOn: $character.isFeetOk)
                            Toggle("is Sphere Good?", isOn: $character.isSphereOk)
                            Toggle("is Chain Good?", isOn: $character.isChainOk)
                        }
                })
                
                GroupBox(
                    label: Text(GroupType.weapon.rawValue),
                    content: {
                        VStack {
                            Toggle("is Weapon Good?", isOn: $character.isWeaponOk)
                        }
                    })
                        
                Spacer()
            }
            .padding()
            .navigationTitle("Прогресс Lbvs")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .navigationBarItems(
                leading: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.blackDayNight)
                }
            )
    }
    
    func saveChanges() {
        do {
            try moc.save()
        } catch {
            print("Error in saving datas in CoreData")
        }
    }
}
