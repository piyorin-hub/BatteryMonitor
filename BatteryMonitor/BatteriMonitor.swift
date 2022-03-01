//
//  BatteriMonitor.swift
//  BatteryMonitor
//
//  Created by Hayashi Norito on 2022/03/02.
//

import Foundation
import UIKit

class BatteryMonitor {
    var BatteryImageView: UIImageView!
    var BatteryLevelLabel: UILabel!
    var currentLevel: Int!
    var currentStatus: UIDevice.BatteryState!
    
    func startMonitoring (){
        
        UIDevice.current.isBatteryMonitoringEnabled = true
//        self.currentLevel = Int(UIDevice.current.batteryLevel)
//        self.currentStatus = UIDevice.current.batteryState
    }
    
    func displayStatus()->String{
        
        var state:String = "バッテリーステータス: "
        
        switch UIDevice.current.batteryState {
            case .unplugged:
                state += "Unplugged"

            case .charging:
                state += "Charging"
                BatteryImageView.image = UIImage(systemName: "battery.100.bolt")?.withTintColor(.green)
            case .full:
                state += "full"
                BatteryImageView.image = UIImage(systemName: "battery.100")?.withTintColor(.green)
            case .unknown:
                state += "Unknown"
                BatteryImageView.image = UIImage(systemName: "exclamationmark.triangle")?.withTintColor(.red)
            @unknown default:
                state += "monitorError"
                BatteryImageView.image = UIImage(systemName: "exclamationmark.triangle")?.withTintColor(.red)
        }
        print(state)
        return state
    }
    // displayStatusで.unplugedの時
    func displayBatteryLevel() {
        // バッテリーのモニタリングをenableにする
        UIDevice.current.isBatteryMonitoringEnabled = true
        
        // Battery Lebelの初期値
        currentLevel = Int(UIDevice.current.batteryLevel)
        var label = self.BatteryLevelLabel.text
        var batteryImage = self.BatteryImageView.image

        if currentLevel == -1 {
            // バッテリーレベルがモニターできないケース
            BatteryImageView.image = UIImage(systemName: "exclamationmark.triangle")?.withTintColor(.red)
            
        } else if currentLevel <= 100 && currentLevel > 75{
            batteryImage = UIImage(systemName: "battery.100")?.withTintColor(.green)
            label = "\(currentLevel!)%"
        } else if currentLevel <= 75 && currentLevel > 50 {
            batteryImage = UIImage(systemName: "battery.75")?.withTintColor(.green)
            label = "\(currentLevel!)%"
        } else if currentLevel <= 50 && currentLevel > 20 {
            batteryImage = UIImage(systemName: "battery.25")?.withTintColor(.green)
            label = "\(currentLevel!)%"
        } else if currentLevel <= 20 {
            batteryImage = UIImage(systemName: "battery.25")?.withTintColor(.red)
            label = "\(currentLevel!)%"
        } else {
            batteryImage = UIImage(systemName: "bayyery.0")?.withTintColor(.red)
            label = "\(currentLevel!)%"
        }
    }
}
