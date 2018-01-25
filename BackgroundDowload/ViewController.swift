//
//  ViewController.swift
//  BackgroundDowload
//
//  Created by Kevin Remigio on 1/24/18.
//  Copyright © 2018 Kevin Remigio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var progressView: UIProgressView!
    var recordButton: UIButton!
    override func loadView() {
        super.loadView()
        
        let buttonFrame:CGRect = CGRect(x: 8, y: view.frame.height - 68, width: view.frame.width - 16, height: 52)
        recordButton = UIButton(frame: buttonFrame)
        recordButton.backgroundColor = UIColor.clear
        recordButton.setTitle("Record", for: .normal)
        recordButton.setTitleColor(view.tintColor, for: .normal)
        recordButton.addTarget(self, action: #selector(startDownload(_:)), for: .touchUpInside)
        view.addSubview(recordButton)
        
        let pFrame: CGRect = CGRect(x: 16, y: 220, width: view.frame.width - 32, height: 50)
        progressView = UIProgressView(frame: pFrame)
        view.addSubview(progressView)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let _ = DownloadManager.shared.activate()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DownloadManager.shared.onProgress = { (progress) in
            OperationQueue.main.addOperation {
                self.progressView.progress = progress
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        DownloadManager.shared.onProgress = nil
    }
    @objc func startDownload(_ sender: Any) {
        let url = URL(string: "https://scholar.princeton.edu/sites/default/files/oversize_pdf_test_0.pdf")!
        let task = DownloadManager.shared.activate().downloadTask(with: url)
        task.resume()
    }

}

