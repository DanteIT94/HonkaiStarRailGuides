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
            characterGroupBox(type: .characteristics,
                              toggles: [
                                ("Is Level Max?", $character.isLevelMax),
                                ("Is Traits Max?", $character.isTraitMax)],
                              checkFunction: checkAllCharacterToogle)
            
            characterGroupBox(type: .relics,
                              toggles: [
                                ("Is Head Good?", $character.isHeadOk),
                                ("Is Hands Good?", $character.isHandsOk),
                                ("Is Body Good?", $character.isBodyOk),
                                ("Is Feet Good?", $character.isFeetOk),
                                ("Is Sphere Good?", $character.isSphereOk),
                                ("Is Chain Good?", $character.isChainOk)
                              ], checkFunction: checkAllRelicsToogle)
            
            characterGroupBox(type: .weapon,
                              toggles: [
                                ("Is Weapon Good?", $character.isWeaponOk)
                              ], checkFunction: saveChanges)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Прогресс \(self.character.name ?? "Персонаж")")
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
    
    //Параметризация UI-элементов
    func characterGroupBox(type: GroupType, toggles: [(String, Binding<Bool>)], checkFunction: @escaping () -> Void) -> some View {
        GroupBox(
            label: Text(type.rawValue),
            content: {
                VStack {
                    ForEach(toggles, id: \.0) { label, isOn in
                        customToggle(label: label, isOn: isOn, action: checkFunction)
                    }
                }
            }
        )
    }
    
    func customToggle(label: String, isOn: Binding<Bool>, action: @escaping () -> Void) -> some View {
        Toggle(label, isOn: isOn)
            .onChange(of: isOn.wrappedValue) { _ in
                action()
            }
    }
    
    
    func checkAllRelicsToogle() {
        let relicsState = [character.isHeadOk,
                           character.isHandsOk,
                           character.isBodyOk,
                           character.isFeetOk,
                           character.isSphereOk,
                           character.isChainOk
        ]
        character.isRelicsOk = relicsState.allSatisfy { $0 }
        saveChanges()
    }
    
    func checkAllCharacterToogle() {
        let characterState = [character.isLevelMax,
                              character.isTraitMax
        ]
        character.isCharacterMax = characterState.allSatisfy { $0 }
        saveChanges()
    }
    
    
}

