//
//  PowerReplenishView.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 19.10.2023.
//

import SwiftUI

@available(iOS 14.0, *)
struct EnergyView: View {
    @AppStorage("energyValue") private var energyValue: String = "240"

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Circle()
                    .trim(from: 0.0, to: CGFloat(min((Double(energyValue) ?? 0 ) / 240, 1)))
                    .stroke(Color.blue, lineWidth: 10)
                    .frame(width: 200, height: 200)
                    .overlay(
                        Image("default_spec")
                            .resizable()
                            .frame(width: 100, height: 100)
                    )
                HStack {
                    Text("Доступная Энергия")
                    NumberTextField(text: $energyValue) {
                        if let value = Int(energyValue), value > 240 {
                            energyValue = "240"
                        }
                    }
                    .frame(width: 100)
                }
                
            }
            .padding(.horizontal, 40)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Настройки").font(.headline)
            }
        }
    }
}

@available(iOS 14.0, *)
struct EnergyView_Previews: PreviewProvider {
    static var previews: some View {
        EnergyView()
    }
}
