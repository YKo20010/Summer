//
//  CanvasController.swift
//  Summer
//
//  Created by Artesia Ko on 1/19/19.
//  Copyright © 2019 Yanlam. All rights reserved.
//

import UIKit

class CanvasController: UIViewController {
    var me: Person?
    var user: Person? {
        didSet {
            navigationItem.title = ""
        }
    }
    
    weak var delegate: sendDrawing?
    
    let canvas: Canvas = Canvas()
    var undoButton: UIBarButtonItem!
    var clearButton: UIBarButtonItem!
    var sendButton: UIBarButtonItem!
    let yellowButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = UIColor.yellow
        b.addTarget(self, action: #selector(changeColor), for: .touchDown)
        return b
    }()
    let redButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = UIColor.red
        b.addTarget(self, action: #selector(changeColor), for: .touchDown)
        return b
    }()
    let orangeButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = UIColor.orange
        b.addTarget(self, action: #selector(changeColor), for: .touchDown)
        return b
    }()
    let greenButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = UIColor.green
        b.addTarget(self, action: #selector(changeColor), for: .touchDown)
        return b
    }()
    let blueButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = UIColor.blue
        b.addTarget(self, action: #selector(changeColor), for: .touchDown)
        return b
    }()
    let purpleButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = UIColor.purple
        b.addTarget(self, action: #selector(changeColor), for: .touchDown)
        return b
    }()
    let blackButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = UIColor.black
        b.addTarget(self, action: #selector(changeColor), for: .touchDown)
        return b
    }()
    let darkGrayButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = UIColor.darkGray
        b.addTarget(self, action: #selector(changeColor), for: .touchDown)
        return b
    }()
    let grayButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = UIColor.gray
        b.addTarget(self, action: #selector(changeColor), for: .touchDown)
        return b
    }()
    let lightGrayButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = UIColor.lightGray
        b.addTarget(self, action: #selector(changeColor), for: .touchDown)
        return b
    }()
    let cyanButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = UIColor.cyan
        b.addTarget(self, action: #selector(changeColor), for: .touchDown)
        return b
    }()
    
    let slider: UISlider = {
        let s = UISlider()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.minimumValue = 1
        s.maximumValue = 20
        s.addTarget(self, action: #selector(changeWidth), for: .valueChanged)
        return s
    }()

    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Static.lightAqua
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = Static.lightAqua
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = false
        
        let b1 = UIButton()
        b1.setImage(UIImage(named: "iconUndo"), for: .normal)
        b1.addTarget(self, action: #selector(undo), for: .touchDown)
        b1.contentMode = .scaleAspectFit
        undoButton = UIBarButtonItem(customView: b1)
        undoButton.customView?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        undoButton.customView?.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        let b2 = UIButton()
        b2.setImage(UIImage(named: "iconRefresh"), for: .normal)
        b2.addTarget(self, action: #selector(clear), for: .touchDown)
        b2.contentMode = .scaleAspectFit
        clearButton = UIBarButtonItem(customView: b2)
        clearButton.customView?.heightAnchor.constraint(equalToConstant: 34).isActive = true
        clearButton.customView?.widthAnchor.constraint(equalToConstant: 30).isActive = true
    
        let b3 = UIButton()
        b3.setImage(UIImage(named: "iconSend"), for: .normal)
        b3.addTarget(self, action: #selector(send), for: .touchDown)
        b3.contentMode = .scaleAspectFit
        sendButton = UIBarButtonItem(customView: b3)
        sendButton.customView?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        sendButton.customView?.widthAnchor.constraint(equalToConstant: 34).isActive = true
        
        self.navigationItem.rightBarButtonItems = [sendButton, clearButton, undoButton]
        
        let stackView = UIStackView(arrangedSubviews: [redButton, orangeButton, yellowButton, greenButton, cyanButton, blueButton, lightGrayButton, grayButton, darkGrayButton, blackButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: view.frame.width/CGFloat(stackView.arrangedSubviews.count)).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        slider.value = 10
        view.addSubview(slider)
        slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        slider.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -10).isActive = true
        slider.heightAnchor.constraint(equalToConstant: 15).isActive = true
        slider.minimumTrackTintColor = .white
        slider.maximumTrackTintColor = Static.darkAqua
        slider.thumbTintColor = .white
        slider.layer.shadowOpacity = 0
        
        canvas.translatesAutoresizingMaskIntoConstraints = false
        canvas.backgroundColor = .white
        view.addSubview(canvas)
        canvas.bottomAnchor.constraint(equalTo: slider.topAnchor, constant: -10).isActive = true
        canvas.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        canvas.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        canvas.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    @objc func undo() {
        canvas.undo()
    }
    
    @objc func clear() {
        canvas.clear()
    }
    
    @objc func changeColor(button: UIButton) {
        if let color = button.backgroundColor {
            canvas.changeColor(color: color)
        }
    }
    
    @objc func changeWidth() {
        canvas.changeWidth(size: slider.value)
    }
    
    @objc func send() {
        if (canvas.lines.count == 0) { return }
        UIGraphicsBeginImageContext(canvas.bounds.size)
        canvas.draw(CGRect(x: 0, y: 0, width: canvas.frame.width, height: canvas.frame.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.delegate?.sendDrawing(image: image!)
        self.navigationController?.popViewController(animated: true)
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
