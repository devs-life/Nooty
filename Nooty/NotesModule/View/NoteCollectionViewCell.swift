//
//  CollectionViewCell.swift
//  Nooty
//
//  Created by Ajay on 27/11/21.
//

import UIKit
import SwiftUI

class NoteCollectionViewCell: UICollectionViewCell {
  static let identifier = "NoteCollectionViewCell"
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.textColor = .label
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .boldSystemFont(ofSize: 16)
    label.text = "Tasks"
    return label
  }()
  
  let tagView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 4
    view.layer.borderWidth = 0.5
    view.layer.borderColor = UIColor.systemBackground.cgColor
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let tagLabel: UILabel = {
    let tagLabel = UILabel()
    tagLabel.translatesAutoresizingMaskIntoConstraints = false
    tagLabel.textColor = .label
    tagLabel.font = .systemFont(ofSize: 12)
    tagLabel.text = "Design"
    tagLabel.textAlignment = .center
    return tagLabel
  }()
  
  let dateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .label
    label.font = .systemFont(ofSize: 12)
    label.text = "Sun, 16:22"
    label.textAlignment = .center
    return label
  }()
  
  let descriptionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.textColor = .label
    label.font = .systemFont(ofSize: 15)
    label.text = "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is"
    label.textAlignment = .left
    return label
  }()
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    if #available(iOS 13.0, *) {
      if (traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)) {
        // ColorUtils.loadCGColorFromAsset returns cgcolor for color name
        changeTagViewBorderColor()
      }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
    changeTagViewBorderColor()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    contentView.backgroundColor = .init(named: "lightBlack")
    contentView.layer.cornerRadius = 20
    contentView.layer.shadowRadius = 4
    contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
    contentView.layer.shadowColor = UIColor.black.cgColor
    contentView.layer.shadowOpacity = 0.2
    setupTitleLabel()
    setupTagView()
    setupDateLabel()
    setupDescriptionLabel()
  }
  
  private func setupTitleLabel() {
    addSubview(titleLabel)
    titleLabel.anchor(left: leadingAnchor, top: topAnchor, right: trailingAnchor, bottom: nil, paddingLeft: 20, paddingTop: 20, paddingRight: 8, paddingBottom: 0)
    titleLabel.anchorHeightAndWidth(height: nil, heightConstant: 20, heightMultiplier: nil, width: nil, widthConstant: nil, widthMultiplier: nil)
  }
  
  private func setupTagView() {
    addSubview(tagView)
    tagView.anchor(left: leadingAnchor, top: nil, right: nil, bottom: bottomAnchor, paddingLeft: 20, paddingTop: 0, paddingRight: 0, paddingBottom: 22)
    
    tagView.anchorHeightAndWidth(height: nil, heightConstant: 24, heightMultiplier: nil, width: widthAnchor, widthConstant: nil, widthMultiplier: 0.33)
    
    tagView.addSubview(tagLabel)
    tagLabel.centerInView(centerX: tagView.centerXAnchor, centerY: tagView.centerYAnchor)
  }
  
  private func setupDateLabel() {
    addSubview(dateLabel)
    
    dateLabel.anchor(left: nil, top: nil, right: trailingAnchor, bottom: bottomAnchor, paddingLeft: 0, paddingTop: 0, paddingRight: 17, paddingBottom: 26.5)
    
    dateLabel.anchorHeightAndWidth(height: nil, heightConstant: nil, heightMultiplier: nil, width: widthAnchor, widthConstant: nil, widthMultiplier: 0.44)
  }
  
  private func setupDescriptionLabel() {
    addSubview(descriptionLabel)
    descriptionLabel.anchor(left: leadingAnchor, top: titleLabel.bottomAnchor, right: trailingAnchor, bottom: tagView.topAnchor, paddingLeft: 20, paddingTop: 10, paddingRight: 17, paddingBottom: 10)
  }
  
  private func changeTagViewBorderColor() {
    if self.traitCollection.userInterfaceStyle == .dark {
      tagView.layer.borderColor = UIColor.white.cgColor
    } else {
      tagView.layer.borderColor = UIColor.black.cgColor
    }
  }
}

// MARK: SwiftUI Preview
#if DEBUG
struct NoteCollectionCellContainer: UIViewRepresentable {
  typealias UIViewType = NoteCollectionViewCell
  
  func makeUIView(context: Context) -> UIViewType {
    return NoteCollectionViewCell(frame: .zero)
  }
  
  func updateUIView(_ uiView: NoteCollectionViewCell, context: Context) {}
}

struct BackgroundViewContainer_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      NoteCollectionCellContainer().colorScheme(.light)
      NoteCollectionCellContainer().colorScheme(.dark)
    }.previewLayout(.fixed(width: 190, height: 260))
  }
}
#endif
