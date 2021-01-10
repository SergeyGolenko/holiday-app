//
//  ViewController.swift
//  holiday-app
//
//  Created by Сергей Голенко on 09.01.2021.
//

import UIKit
import AVFoundation
import Combine

class ViewController: UIViewController {
    
    private var player : AVPlayer?
    private var playerLayer: AVPlayerLayer?
    private let notificationCenter = NotificationCenter.default
    private var appEventSubscribers = [AnyCancellable]()
    
    
    //MARK: - IBOutlets and IBAction
    @IBOutlet weak var darkView: UIView!
    @IBOutlet weak var getStartedButton: UIButton!
    @IBAction func getStartedButtonTapped(_ sender: Any) {
       
    }
    
    //MARK: - Navigation controller methods
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer?.frame = view.bounds
    }
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated:animated)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated:animated)
        observeAppEvents()
        setupPlayerIfNeeded()
        restartVideo()

    }
    
    //MARK: - functions
    private func setupViews(){
        getStartedButton.layer.cornerRadius = 28
        getStartedButton.layer.masksToBounds = true
        darkView.backgroundColor = UIColor.init(white: 0.1, alpha: 0.3)
    }
    
    private func buildPlayer() -> AVPlayer? {
        guard let filePath = Bundle.main.path(forResource: "holiday video", ofType: "mp4") else {return nil}
        let url = URL(fileURLWithPath: filePath)
        let player = AVPlayer(url: url)
        player.actionAtItemEnd = .none
        player.isMuted = true
        return player
    }
    
    private func buildPlayerLayer() -> AVPlayerLayer? {
        let layer = AVPlayerLayer(player: player)
        layer.videoGravity = .resizeAspectFill
        return layer
    }
    
    private func playVideo(){
        player?.play()
    }
    
    private func restartVideo(){
        player?.seek(to:.zero)
        playVideo()
    }
    
    private func pauseVideo(){
        player?.pause()
    }
    
    private func setupPlayerIfNeeded(){
        self.player = buildPlayer()
        self.playerLayer = buildPlayerLayer()
        
        if let layer = self.playerLayer,
            view.layer.sublayers?.contains(layer) == false {
            view.layer.insertSublayer(layer, at: 0)
        }
    }
    
    private func  observeAppEvents(){
        
        notificationCenter.publisher(for: .AVPlayerItemDidPlayToEndTime).sink { _ in
          print("video has ended")
            self.restartVideo()
        }.store(in: &appEventSubscribers)
    }

}

