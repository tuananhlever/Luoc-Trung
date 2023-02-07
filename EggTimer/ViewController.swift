import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    var eggTime = ["Soft": 3, "Medium": 4, "Hard" : 7]
    var secondPass = 1
    var totalTime = 0
    var timer = Timer()
    var player: AVAudioPlayer?
    @IBAction func hardnessSelected(_ sender: UIButton) {
       let hardness = sender.currentTitle!
        timer.invalidate()
        totalTime = eggTime[hardness]!
        sender.alpha = 0.5
        progressView.progress = 1.0
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if self.totalTime > 0 {
                let percentage = Float(self.secondPass)/Float(self.totalTime)
        
                self.totalTime -= 1
                self.progressView.progress = 1 - percentage
    
                self.titleLabel.text = "Boiling"
            } else {
                self.timer.invalidate()
                self.titleLabel.text = "Done!"
                let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                self.player = try! AVAudioPlayer(contentsOf: url!)
                self.player?.play()
                self.progressView.progress = 0
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.titleLabel.text = "How do you like your eggs?"
                    self.progressView.progress = 1.0
                    sender.alpha = 1
                }
            }
            
        }
        
        
  }
}
