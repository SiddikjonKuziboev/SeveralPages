//
//  AddressDetailedTVC.swift
//  BaxtWoman
//
//  Created by Azizbek Salimov on 23/05/23.
//  Copyright © 2023 Avazbek Olimov. All rights reserved.
//

import UIKit

class AddressDetailedTVC: UITableViewCell {

    
    // MARK: - UI Elements
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemPink.cgColor
        view.layer.cornerRadius = 12
    
        return view
    }()
    
    private lazy var h1StackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel,
                                                       closedImageView])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 8

        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .darkText
        label.textAlignment = .left
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultHigh , for: .horizontal)
        label.backgroundColor = .clear
        return label
    }()
    
    var closedImageView: UIImageView = {
        let img = UIImageView(image: UIImage(systemName: "circle"))
        img.tintColor = .systemGray4
        return img
    }()
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //MARK: - prepareForReuse is called every time before cellForRowAt
    }
    
    override func layoutSubviews() {
        
    }
    
    //For MainVC
    func configure(answers: Answer) {
        updateUI(title: answers.answer_text)
        if let _ = answers.sub_answers {
            closedImageView.image = UIImage(systemName: "chevron.right")
        }else {
            closedImageView.image = UIImage(systemName: answers.isSelected ? "circle.fill" : "circle")
        }
        
        
    }
    
      func configureForSub(answers: SubAnswer?) {
          guard let answers = answers else{return}
        updateUI(title: answers.answer_text)
        if let _ = answers.sub_answers {
            closedImageView.image = UIImage(systemName: "chevron.right")
        }else {
            closedImageView.image = UIImage(systemName: answers.isSelected ? "circle.fill" : "circle")
        }
        
        
    }
    
    private func updateUI(title: String) {
        titleLabel.text = title
       
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
extension AddressDetailedTVC {
    
    private func setupSubviews() {
        contentView.addSubview(mainView)
        mainView.addSubview(h1StackView)
        configureConstraints()
    }
    
    private func configureConstraints() {
        closedImageView.setDimensions(width: 25, height: 26)
        
        
        h1StackView.anchor(top: mainView.topAnchor,
                          left: mainView.leftAnchor,
                          bottom: mainView.bottomAnchor,
                          right: mainView.rightAnchor,
                          paddingTop: 13, paddingLeft: 10, paddingBottom: 13, paddingRight: 10)
        
        mainView.anchor(top: contentView.topAnchor,
                          left: contentView.leftAnchor,
                          bottom: contentView.bottomAnchor,
                          right: contentView.rightAnchor,
                          paddingTop: 8, paddingLeft: 16, paddingBottom: 8, paddingRight: 16)
        
    }
}
    
extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func center(inView view: UIView, yConstant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
    }
    
    func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let topAnchor = topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
        }
    }
    
    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil, paddingLeft: CGFloat? = nil, constant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant!).isActive = true
        
        if let leftAnchor = leftAnchor, let padding = paddingLeft {
            self.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
        }
    }
    
    func setDimensions(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
    
    func constrainWidth(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func constrainHeight(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
}
