//
//  ViewController.swift
//  CoreMLTier1
//
//  Created by Pawel Kowalczuk on 10/07/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var preview: UIView!
    @IBOutlet private weak var detectorName: UILabel!
    
    private var video: Video!
    private var detectorType: DetectorType = .squeezeNet {
        didSet {
            detectorName.text = detector.name
        }
    }
    private lazy var detector: Detector = {
        return self.detectorType.detector
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalTransitionStyle = .flipHorizontal
        detectorName.text = detector.name
        initalizeVideo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        video.stop()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        video.start()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        video.resizePreview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showSettings() {
        
        let ctrl = SettingsViewController(selected: detectorType) { [weak self] (selectedType) in
            guard let strongSelf = self else { return }
            strongSelf.detector = selectedType.detector
            strongSelf.detectorType = selectedType
        }
        ctrl.modalTransitionStyle = .flipHorizontal
        present(ctrl, animated: true) { [unowned self] in
            self.video.stop()
        }
    }
    
    private func initalizeVideo() {
        
        video = Video(camera: .back,
                      previewLayer: preview.layer)
        
        video.videoHandler = { [unowned self] buffer in
            self.detector.handleDetection(buffer,
                                          completion: { [weak self] (result, probability) in
                                            guard probability > 0.2 else { return }
                                            self?.infoLabel.text = result
            })
        }
    }

}

