//
//  CharacterView.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 27.10.2023.
//

import SwiftUI


enum GroupType: String, CaseIterable {
    case characteristics = "Опыт и таланты Персонажа"
    case relics = "Реликвии персонажа"
    case weapon = "Оружие персонажа"
}

@available(iOS 14.0, *)
struct CurrentCharacterView: View {
    @Environment (\.presentationMode) var presentationMode
    @State var character: MockCharacter
    
    var body: some View {
            VStack {
                GroupBox(
                    label: Text(GroupType.characteristics.rawValue), content: {
                    VStack {
                        Toggle("is Level Max?", isOn: $character.isLevelMax)
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
            .navigationTitle("Прогресс \(character.name)")
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
}

struct MockCharacter {
    var name: String
    var icon: Image
    var isBodyOk: Bool
    var isChainOk: Bool
    var isFeetOk: Bool
    var isHandsOk: Bool
    var isHeadOk: Bool
    var isLevelMax: Bool
    var isSphereOk: Bool
    var isTraitMax: Bool
    var isWeaponOk: Bool
}

@available(iOS 14.0, *)
struct CharacterView_Preview: PreviewProvider {

    static var previews: some View {
        let mockCharacter = MockCharacter(name: "Voloda", icon: Image("default_char"), isBodyOk: true, isChainOk: false, isFeetOk: true, isHandsOk: true, isHeadOk: false, isLevelMax: true, isSphereOk: false, isTraitMax: false, isWeaponOk: true)
        CurrentCharacterView(character: mockCharacter)
    }
}





//
//extension CharacterEntity {
//    func updateCharacteristicsStatus() {
//        self.
//    }
//}
