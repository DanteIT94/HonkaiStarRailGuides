//
//  PowerReplenishView.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 19.10.2023.
//

import SwiftUI
import UserNotifications


@available(iOS 15.0, *)
struct EnergyView: View {
    @AppStorage("energyValue") private var energyValue: String = "120"
    @AppStorage("lastUpdateTime") private var lastUpdateTime: Double = Date().timeIntervalSince1970
    
    let timer = Timer.publish(every: 6 * 60, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                ZStack {
                    ForEach(0..<60) { tick in
                        VStack {
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width: 2, height: 10)
                                .offset(y: -100)
                        }
                        .rotationEffect(.degrees(Double(tick) * 6))
                    }
                    Circle()
                        .trim(from: 0.0, to: CGFloat(min((Double(energyValue) ?? 0 ) / 240, 1)))
                        .stroke(Color.blue, lineWidth: 10)
                        .frame(width: 200, height: 200)
                        .overlay(
                            Image("energy_image")
                                .resizable()
                                .frame(width: 150, height: 150)
                        )
                }
                
                HStack {
                    Text("Доступная Энергия")
                    NumberTextField(text: $energyValue) {
                        if let value = Int(energyValue), value > 240 {
                            energyValue = "240"
                        }
                        scheduleEnergyFullNotification(currentEnergy: Int(energyValue) ?? 0)
                    }
                    .frame(width: 50, height: 35)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5)
                }
                
            }
            .padding(.top, 40)
            .padding(.horizontal, 40)
            .onAppear {
                NotificationCenter.default.addObserver(forName: NSNotification.Name("energyFull"), object: nil, queue: .main) { _ in
                    self.energyValue = "240"
                }
                let notificationCenter = NotificationCenter.default
                notificationCenter.addObserver(
                    forName: UIApplication.willResignActiveNotification,
                    object: nil,
                    queue: .main) { _ in
                        print("Ушел в Фон")
                    self.lastUpdateTime = Date().timeIntervalSince1970
                }
                notificationCenter.addObserver(
                    forName: UIApplication.didBecomeActiveNotification,
                    object: nil, queue: .main) { _ in
                        print("открылся")
                        self.updateEnergy()
                }
            }
            .onReceive(timer) { _ in
                updateEnergy()
            }
        }
        .background(Color(uiColor: .whiteDayNight))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Настройки").font(.headline)
            }
        }
    }
    
    func updateEnergy() {
        let currentTime = Date().timeIntervalSince1970
        let elapsedTime = currentTime - lastUpdateTime
        let energyToAdd = Int(elapsedTime / (6 * 60))
        
        if energyToAdd > 0 {
            if let currentEnergy = Int(energyValue) {
                let newEnergy = min(currentEnergy + energyToAdd, 240)
                energyValue = String(newEnergy)
            }
            lastUpdateTime = currentTime
        }
    }
    
    func scheduleEnergyFullNotification(currentEnergy: Int) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        let energyToBeFilled = 240 - currentEnergy
        if energyToBeFilled <= 0 { return }
        let timeToBeFilled =  Double(energyToBeFilled) * 6 * 60
        
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


@available(iOS 15.0, *)
struct EnergyView_Previews: PreviewProvider {
    static var previews: some View {
        EnergyView()
    }
}
