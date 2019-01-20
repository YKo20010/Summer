//
//  messageCVC.swift
//  Summer
//
//  Created by Artesia Ko on 12/27/18.
//  Copyright © 2018 Yanlam. All rights reserved.
//

import UIKit

class messageCVC: UICollectionViewCell {
    
    weak var chatLogController: ChatController?
    
    var userLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.textColor = .black
        l.text = ""
        return l
    }()
    var timeLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 14, weight: .ultraLight)
        l.textColor = .black
        l.text = ""
        return l
    }()
    var textView: UILabel = {
        let tv = UILabel()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.font = UIFont.systemFont(ofSize: 16, weight: .light)
        tv.textColor = .black
        //tv.isEditable = false
        tv.text = ""
        //tv.isScrollEnabled = false
        tv.sizeToFit()
        tv.numberOfLines = 0
        return tv
    }()
    let sep: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    let messageImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .clear
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let pad: CGFloat = 8
    var imageWidthAnchor: NSLayoutConstraint?
    var imageHeightAnchor: NSLayoutConstraint?
    var sepTopAnchor: NSLayoutConstraint?
    var sepTopAnchor2: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(userLabel)
        NSLayoutConstraint.activate([
            userLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: pad),
            userLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: pad)
            ])
     
        contentView.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: userLabel.topAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: userLabel.trailingAnchor, constant: pad),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -pad)
            ])
        let sepWidth: CGFloat = 1
        contentView.addSubview(sep)
        sepTopAnchor = sep.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 1.5)
        sepTopAnchor?.isActive = true
        sepTopAnchor2 = sep.topAnchor.constraint(equalTo: contentView.topAnchor)
        sepTopAnchor2?.isActive = false
        sep.leadingAnchor.constraint(equalTo: userLabel.leadingAnchor).isActive = true
        sep.widthAnchor.constraint(equalToConstant: sepWidth).isActive = true
        sep.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
     
        contentView.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: sep.trailingAnchor, constant: pad),
            textView.topAnchor.constraint(equalTo: sep.topAnchor),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1.0 * pad)
            ])
        contentView.addSubview(messageImageView)
        messageImageView.leadingAnchor.constraint(equalTo: sep.trailingAnchor, constant: pad).isActive = true
        messageImageView.topAnchor.constraint(equalTo: sep.topAnchor, constant: pad).isActive = true
        imageWidthAnchor = messageImageView.widthAnchor.constraint(equalToConstant: 100)
        imageWidthAnchor?.isActive = true
        imageHeightAnchor = messageImageView.heightAnchor.constraint(equalToConstant: 100)
        imageHeightAnchor?.isActive = true
        messageImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomTap)))
    }
    
    @objc func zoomTap(tapGesture: UITapGestureRecognizer) {
        if let imageView = tapGesture.view as? UIImageView {
            self.chatLogController?.zoomImage(imageView: imageView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
