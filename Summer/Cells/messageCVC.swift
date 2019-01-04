//
//  messageCVC.swift
//  Summer
//
//  Created by Artesia Ko on 12/27/18.
//  Copyright © 2018 Yanlam. All rights reserved.
//

import UIKit

class messageCVC: UICollectionViewCell {
    
    var userLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
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
        return iv
    }()
    
    let pad: CGFloat = 8
    var imageWidthAnchor: NSLayoutConstraint?
    var imageHeightAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(userLabel)
        NSLayoutConstraint.activate([
            userLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: pad),
            userLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: pad),
            userLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1.0 * pad)
            ])
        let sepWidth: CGFloat = 1
        contentView.addSubview(sep)
        NSLayoutConstraint.activate([
            sep.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 1.5),
            sep.leadingAnchor.constraint(equalTo: userLabel.leadingAnchor),
            sep.widthAnchor.constraint(equalToConstant: sepWidth),
            sep.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        contentView.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: sep.trailingAnchor, constant: pad),
            textView.topAnchor.constraint(equalTo: userLabel.bottomAnchor),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1.0 * pad)
            ])
        contentView.addSubview(messageImageView)
        messageImageView.leadingAnchor.constraint(equalTo: sep.trailingAnchor, constant: pad).isActive = true
        messageImageView.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: pad).isActive = true
        imageWidthAnchor = messageImageView.widthAnchor.constraint(equalToConstant: 100)
        imageWidthAnchor?.isActive = true
        imageHeightAnchor = messageImageView.heightAnchor.constraint(equalToConstant: 100)
        imageHeightAnchor?.isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
