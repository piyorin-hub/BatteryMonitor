import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var batteryLebelLabel: UILabel!
    @IBOutlet weak var batteryStatusLabel: UILabel!
    @IBOutlet weak var batteryImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

       
        DispInitialize()

        timerFiring()
    }
    
    func timerFiring() {
        let timer = Timer(timeInterval: 1,
                          target: self,
                          selector: #selector(getBatteryStatus),
                          userInfo: nil,
                          repeats: true)
        RunLoop.main.add(timer, forMode: .default)
    }

    func DispInitialize() {
        batteryLebelLabel.isEnabled = false
        batteryStatusLabel.isEnabled = false
        batteryImage.image = UIImage(systemName: "battery.100")
    }

    @objc func getBatteryStatus() {
        UIDevice.current.isBatteryMonitoringEnabled = true

        let batRemain = UIDevice.current.batteryLevel
        batteryLebelLabel.text = NSString(format: "%.1f", batRemain * 100) as String + "%"
        let batStatus: UIDevice.BatteryState = UIDevice.current.batteryState
        switch batStatus {
        case .charging:
            batteryStatusLabel.text = "充電中ですよ。"
            batteryImage.image = UIImage(systemName: "battery.100.bolt")?.withTintColor(.green)
        case .full:
            batteryStatusLabel.text = "フルチャージ！！"
            batteryImage.image = UIImage(systemName: "battery.100")?.withTintColor(.green)
        case .unplugged:
            batteryStatusLabel.text = "充電してないっす。"
            batteryImageChange(batRemain: Int(batRemain))
        case .unknown:
            batteryStatusLabel.text = "わかんね。"
            batteryImage.image = UIImage(systemName: "exclamationmark.octagon.fill")?.withTintColor(.red)
        default:
            batteryStatusLabel.text = "マジでわかんね。"
        }

        UIDevice.current.isBatteryMonitoringEnabled = false
    }
    
    func batteryImageChange(batRemain: Int) {
        
        
        if batRemain == -1 {
            // バッテリーレベルがモニターできないケース
            batteryImage.image = UIImage(systemName: "exclamationmark.triangle")?.withTintColor(.red)
            
        } else if batRemain <= 100 && batRemain > 75{
            batteryImage.image = UIImage(systemName: "battery.100")?.withTintColor(.green)
            
        } else if batRemain <= 75 && batRemain > 50 {
            batteryImage.image = UIImage(systemName: "battery.75")?.withTintColor(.green)
            
        } else if batRemain <= 50 && batRemain > 20 {
            batteryImage.image = UIImage(systemName: "battery.25")?.withTintColor(.green)
            
        } else if batRemain <= 20 {
            batteryImage.image = UIImage(systemName: "battery.25")?.withTintColor(.red)
            
        } else {
            batteryImage.image = UIImage(systemName: "bayyery.0")?.withTintColor(.red)
            
        }
    }
}
