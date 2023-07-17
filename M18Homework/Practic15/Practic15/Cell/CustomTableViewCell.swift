//
//  CustomTableViewCell.swift
//  Practic15
//
//  Created by Даниил Циркунов on 27.02.2023.
//

import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    private lazy var lableHeader: UILabel = {
        let lable = UILabel()
        lable.textColor = .black
        lable.font = Constants.Fonts.ui16Semi
        lable.numberOfLines = 0
        return lable
    }()
    
    let service = Service()
    
    private lazy var lableText: UILabel = {
        let lable = UILabel()
        lable.textColor = .black
        lable.font = Constants.Fonts.ui14Regular
        lable.numberOfLines = 0
        return lable
    }()
    
    private lazy var lableDate: UILabel = {
        let lable = UILabel()
        lable.textColor = Constants.Colors.gray03
        lable.font = Constants.Fonts.ui14Regular
        return lable
    }()
    
    private lazy var contentBlockImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = Constants.Colors.gray01
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ viewModel: CustomTableViewCellModel){
        lableText.text = viewModel.text
        lableHeader.text = viewModel.header
        lableDate.text = viewModel.date
    
        self.service.loadImage(urlString: viewModel.image ?? String()) { image in
            DispatchQueue.main.async {
                self.contentBlockImage.image = image
            }
        }
    }

    
    private func setupView(){
        contentView.addSubview(lableDate)
        contentView.addSubview(lableText)
        contentView.addSubview(lableHeader)
        contentView.addSubview(contentBlockImage)
        contentView.contentMode = .scaleAspectFill
    }
    
    private func setupConstraints(){
        contentBlockImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).inset(16)
            make.left.equalTo(contentView.snp.left).inset(16)
            make.right.equalTo(lableText.snp.left).inset(-16)
            make.right.equalTo(lableHeader.snp.left).inset(-16)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        lableText.snp.makeConstraints { make in
            make.right.equalTo(contentView.snp.right).inset(24)
            make.bottom.equalTo(contentView.snp.bottom).inset(16)
            //make.top.equalTo(contentView.snp.top).inset(43)
        }
        
        lableHeader.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).inset(16)
            make.right.equalTo(lableDate.snp.right).inset(10)
            make.bottom.equalTo(lableText.snp.top).inset(-10)
        }
        
        lableDate.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).inset(18)
            make.right.equalTo(contentView.snp.right).inset(16)
        }
    }
}
