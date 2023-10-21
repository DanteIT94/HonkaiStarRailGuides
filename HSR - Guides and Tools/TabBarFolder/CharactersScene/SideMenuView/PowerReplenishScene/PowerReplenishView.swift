//
//  PowerReplenishView.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 19.10.2023.
//

import SwiftUI
import UserNotifications


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
                        scheduleEnergyFullNotification(currentEnergy: Int(energyValue) ?? 0)
                    }
                    .frame(width: 100)
                }
                
            }
            .padding(.horizontal, 40)
            .onAppear {
                NotificationCenter.default.addObserver(forName: NSNotification.Name("energyFull"), object: nil, queue: .main) { _ in
                    self.energyValue = "240"
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Настройки").font(.headline)
            }
        }
    }
    
    func scheduleEnergyFullNotification(currentEnergy: Int) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        let energyToBeFilled = 240 - currentEnergy
        if energyToBeFilled <= 0 { return }
        let timeToBeFilled =  Double(energyToBeFilled) * 1 * 60
        
        let content = UNMutableNotificationContent()
        content.title = "Эй, Первопроходец!"
        content.body = "Энергия достигла максимума!"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeToBeFilled, repeats: false)
        
        let request = UNNotificationRequest(identifier: "energyFullNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
                    if let error = error {
                        print("Ошибка при планировании уведомления: \(error)")
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
