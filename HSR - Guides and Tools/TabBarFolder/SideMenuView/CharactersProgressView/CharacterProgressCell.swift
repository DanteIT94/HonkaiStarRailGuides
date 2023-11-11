//
//  CharacterProgressCell.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 26.10.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterProgressCell: View {
    
    @Environment(\.managedObjectContext) private var managedObjectContext
    var character: CharacterCoreData
    
    var characterImageURL: URL?
    var characterName: String
    var isCharacterMax: Bool
    var isRelicsGood: Bool
    var isWeaponGood: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            //Подложка
            VStack(spacing: 15){
                HStack(spacing: 10) {
                    WebImage(url: characterImageURL)
                        .resizable()
                        .placeholder(Image("default_char"))
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                    Text(characterName).font(.headline)
                }
                StatusView(title: "Is Character Max?", isOk: isCharacterMax)
                StatusView(title: "Is Relics Perfect?", isOk: isRelicsGood)
                StatusView(title: "Is Weapon Good?", isOk: isWeaponGood)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            
            Button(action: {
                self.toogleFavoriteStatus(character: character)
            }) {
                Text(character.isFavorite ? "Delete from Fav." : "Add to Fav.")
            }
        }
    }
    
    func toogleFavoriteStatus(character: CharacterCoreData) {
        character.isFavorite.toggle()
        
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error.localizedDescription)")
        }
    }
//    
//    func addToFavorites(character: CharacterCoreData) {
//        character.isFavorite = true
//        do {
//            try managedObjectContext.save()
//        } catch {
//            print("\(error.localizedDescription)")
//        }
//    }
//    
//    func deleteFromFavorites(character: CharacterCoreData) {
//        character.isFavorite = false
//        do {
//            try managedObjectContext.save()
//        } catch {
//            print("\(error.localizedDescription)")
//        }
//    }
    
}

struct StatusView: View {
    var title: String
    var isOk: Bool
    
    var body: some View {
        HStack{
            Text(title)
            Spacer()
            Circle()
                .fill(isOk ? Color.greenUni : Color.redUni)
                .frame(width: 20, height: 20)
        }
    }
}

//struct CharacterProgressView_Review: PreviewProvider {
//    static var previews: some View {
//        CharacterProgressCell(characterImage: Image("default_char", bundle: nil),
//                              characterName: "Voloda",
//                              isCharacterMax: true,
//                              isRelicsGood: false,
//                              isWeaponGood: true)
//    }
//}
