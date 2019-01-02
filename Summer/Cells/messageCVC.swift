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
    var textView: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.font = UIFont.systemFont(ofSize: 16, weight: .light)
        tv.textColor = .black
        tv.isEditable = false
        tv.text = ""
        tv.isScrollEnabled = false
        return tv
    }()
    let sep: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    let pad: CGFloat = 8
    
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
            textView.widthAnchor.constraint(equalToConstant: contentView.frame.width - 3.0 * pad - sepWidth),
            textView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
