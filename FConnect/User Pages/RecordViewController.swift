//
//  RecordViewController.swift
//  FConnect
//
//  Created by hor kimleng on 11/15/19.
//  Copyright © 2019 kimlenghor. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class RecordViewController: UIViewController, AVAudioRecorderDelegate {

    var recordButton: UIButton!
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var result = ""
    var keywords = [String]()
    var answer = ""
    
    //IBOutlets
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var popupView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.popupView.createRoundCorner(cornerRadius: 20)

        recordingSession = AVAudioSession.sharedInstance()

        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.loadRecordingUI()
                    } else {
                        // failed to record!
                    }
                }
            }
        } catch {
            // failed to record!
        }
        
    }
    
    func loadRecordingUI() {
        recordButton = UIButton(frame: CGRect(x: self.view.frame.width / 4, y:self.view.frame.height / 2, width: 200, height: 32))
        recordButton.setImage(#imageLiteral(resourceName: "microphone"), for: .normal)
        recordButton.setTitle("Tap to Record", for: .normal)
        recordButton.titleLabel?.font = UIFont (name: "Avenir-bold", size: 15)
        recordButton.setTitleColor(#colorLiteral(red: 0.07962145656, green: 0.05101636797, blue: 0.3584266305, alpha: 1), for: .normal)
        recordButton.addTarget(self, action: #selector(recordTapped), for: .touchUpInside)
        view.addSubview(recordButton)
    }
    
    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")

        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            recordButton.setTitle("Tap to Stop", for: .normal)
        } catch {
            finishRecording(success: false)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(paths[0])
        return paths[0]
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil

        if success {
            recordButton.setTitle("Tap to Re-record", for: .normal)
            startSpinnerAnimation(view: self.view)
            recordButton.isEnabled = false
            
            SFSpeechRecognizer.requestAuthorization { authStatus in
                if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                    if let path = Bundle.main.url(forResource: "Eunice", withExtension: "m4a") {
                        let recognizer = SFSpeechRecognizer()
                        let request = SFSpeechURLRecognitionRequest(url: path)
                        recognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
                            if let error = error {
                                print("There was an error: \(error)")
                            } else {
                                //print (result?.bestTranscription.formattedString)
                                if let script = result?.bestTranscription.formattedString {
                                    self.result = script
                                    print(self.result)
                                }
                            }
                        })
                    }
                }
            }
            
            Timer.scheduledTimer(withTimeInterval: 12, repeats: false) { (_) in
                spinner.removeFromSuperview()
                self.recordButton.isEnabled = true
                print(self.result)
                print(self.keywords)
                
                var count = 0
                for index in 0..<self.keywords.count {
                    if self.result.lowercased().contains(self.keywords[index].lowercased()) {
                        count += 1
                    }
                }
                
                self.recordButton.isHidden = true
                self.popupView.isHidden = false
                let percentage = (Double(count) / Double(self.keywords.count) * 100)
                self.percentageLabel.text = "\(percentage) %"
                self.answerLabel.text = self.answer
            }
            
//            let audioURL = Bundle.main.url(forResource: "carry", withExtension: "mp3")
//
//            let recognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
//            let request = SFSpeechURLRecognitionRequest(url: audioURL!)
//
//            request.shouldReportPartialResults = true
//
//            if (recognizer?.isAvailable)! {
//
//                recognizer?.recognitionTask(with: request) { result, error in
//                    guard error == nil else { print("Error: \(error!)"); return }
//                    guard let result = result else { print("No result!"); return }
//
//                    print(result.bestTranscription.formattedString)
//                }
//            } else {
//                print("Device doesn't support speech recognition")
//            }
            
        } else {
            recordButton.setTitle("Tap to Record", for: .normal)
            // recording failed :(
        }
    }
    
    @objc func recordTapped() {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
}
