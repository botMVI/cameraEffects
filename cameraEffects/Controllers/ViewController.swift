//
//  ViewController.swift
//  cameraEffects
//
//  Created by Michael Iliouchkin on 27.05.2021.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    let step: Float = 10.0
    let label = UILabel()
    var imageView = UIImageView()
    var size: CGFloat = 250
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraCapture()
        sliderConfig()
        creatingLabel()
        
        imageView.backgroundColor = .red
        imageView.frame = CGRect(x: 0, y: 0, width: size, height: size)
        imageView.center = view.center
        self.view.addSubview(imageView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AppUtility.lockOrientation(.portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        AppUtility.lockOrientation(.all)
    }
    
    func cameraCapture() {
        let captureSession = AVCaptureSession()
        
        guard let captureDevice = AVCaptureDevice.default(for: .video ) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)
        
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
    }
    
    func creatingLabel() {
        label.frame = CGRect(x: 50, y: 570, width: 300, height: 20)
        label.text = ""
        label.textAlignment = .center
        
        
        view.addSubview(label)
        self.view = view
    }
    
    func sliderConfig() {
        let mySlider = UISlider(frame:CGRect(x: 50, y: 600, width: 300, height: 20))
        mySlider.minimumValue = 0
        mySlider.maximumValue = 1
        mySlider.isContinuous = true
        mySlider.tintColor = UIColor.systemBlue
        mySlider.thumbTintColor = UIColor.lightGray
        mySlider.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .valueChanged)
        
        self.view.addSubview(mySlider)
    }
    
    @objc func sliderValueDidChange(_ sender:UISlider!) {
        let value = sender.value
        label.text = "\(value)"
        
        imageView.frame = CGRect(x: 0, y: 0,
                                 width: size * CGFloat(value),
                                 height: size * CGFloat(value))
        imageView.center = view.center
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


/*
 void mainImage( out vec4 fragColor, in vec2 fragCoord )
 {
 float aberrationAmount =  0.1 + abs(iMouse.y / iResolution.y / 8.0);
 
 vec2 uv = fragCoord.xy / iResolution.xy;
 vec2 distFromCenter = uv - 0.5;
 
 // stronger aberration near the edges by raising to power 3
 vec2 aberrated = aberrationAmount * pow(distFromCenter, vec2(3.0, 3.0));
 
 fragColor = vec4
 (
 texture(iChannel0, uv - aberrated).r,
 texture(iChannel0, uv).g,
 texture(iChannel0, uv + aberrated).b,
 1.0
 );
 }
 */
