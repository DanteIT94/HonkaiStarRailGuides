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
                                checkAllCharacterToogle()
                            }
                        Toggle("is Traits Max?", isOn: $character.isTraitMax)
                            .onChange(of: character.isLevelMax) { _ in
                                checkAllCharacterToogle()
                            }
                    }
                })
            
            GroupBox(
                label: Text(GroupType.relics.rawValue),
                content: {
                    VStack {
                        Toggle("is Head Good?", isOn: $character.isHeadOk)
                            .onChange(of: character.isHeadOk) { _ in
                                checkAllRelicsToogle()
                            }
                        Toggle("is Hands Good?", isOn: $character.isHandsOk)
                            .onChange(of: character.isHandsOk) { _ in
                                checkAllRelicsToogle()
                            }
                        Toggle("is Body Good?", isOn: $character.isBodyOk)
                            .onChange(of: character.isBodyOk) { _ in
                                checkAllRelicsToogle()
                            }
                        Toggle("is Feet Good?", isOn: $character.isFeetOk)
                            .onChange(of: character.isFeetOk) { _ in
                                checkAllRelicsToogle()
                            }
                        Toggle("is Sphere Good?", isOn: $character.isSphereOk)
                            .onChange(of: character.isSphereOk) { _ in
                                checkAllRelicsToogle()
                            }
                        Toggle("is Chain Good?", isOn: $character.isChainOk)
                            .onChange(of: character.isChainOk) { _ in
                                checkAllRelicsToogle()
                            }
                    }
                })
            
            GroupBox(
                label: Text(GroupType.weapon.rawValue),
                content: {
                    VStack {
                        Toggle("is Weapon Good?", isOn: $character.isWeaponOk)
                            .onChange(of: character.isWeaponOk) { _ in
                            saveChanges()
                            }
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
