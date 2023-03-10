//
//  TitleTableViewCell.swift
//  Netflix Clone
//
//  Created by MacBookPro on 4/03/23.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
     
    static let identifier = "TitleTableViewCell"
    
    private let playTitleButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle",withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        //label.backgroundColor = .red
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private let titlesPosterUIImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle,reuseIdentifier:String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titlesPosterUIImageView)
        contentView.addSubview(titleLabel )
        contentView.addSubview(playTitleButton)
        
        applyConstrains()
    }
    
    private func applyConstrains(){
        let titlesPosterUIImageViewContrains = [
            titlesPosterUIImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titlesPosterUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            titlesPosterUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            titlesPosterUIImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let titleLabelContrains = [
            titleLabel.leadingAnchor.constraint(equalTo:titlesPosterUIImageView.trailingAnchor,constant: 20),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        let playTitleButtonConstrains = [
            playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(titlesPosterUIImageViewContrains)
        NSLayoutConstraint.activate(titleLabelContrains)
        NSLayoutConstraint.activate(playTitleButtonConstrains)
    }
    
    public func configure(with model: TitleViewModel){
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {return}
        titlesPosterUIImageView.sd_setImage(with: url,completed:nil)
        titleLabel.text = model.titleName
    }
    
    required init?(coder: NSCoder){
        fatalError()
    }
}
