//
//  TCollectionView.swift
//  uzcard trade
//
//  Created by Muhammadjon Tohirov on 11/26/19.
//  Copyright © 2019 Plum Technologies. All rights reserved.
//

import UIKit

@IBDesignable
public final class TCollectionView: UICollectionView, TUIProtocol, TUIContainerProtocol {
    private let shadowView: TView = TView()
    
    @IBInspectable
    public var radius: CGFloat = 0 {
        didSet {
            
            self.clipsToBounds = true
            self.layer.cornerRadius = self.radius
            
            self.shadowView.clipsToBounds = true
            self.shadowView.layer.cornerRadius = self.radius
            
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var shadowColor: UIColor = UIColor.black.withAlphaComponent(0.5)
    
    @IBInspectable
    public var shadowY: CGFloat = 0 {
        didSet {
            self.setupShadow()
        }
    }
    
    @IBInspectable
    public var shadowX: CGFloat = 0 {
        didSet {
            self.setupShadow()
        }
    }
    
    @IBInspectable
    public var shadowRadius: CGFloat = 8 {
        didSet {
            self.setupShadow()
        }
    }
    
    public var hasItems: Bool {
        for i in 0..<self.numberOfSections {
            if self.numberOfItems(inSection: i) != 0 {
                return true
            }
        }
        return false
    }
    
    public var noItemsMessage: String = "" {
        didSet {
            self.noItemLabel.text = self.noItemsMessage
        }
    }
    
    private lazy var noItemLabel: TLabel = {
        let lbl = TLabel()
        lbl.tag = 5231
        lbl.text = self.noItemsMessage
        lbl.label.textAlignment = .center
        lbl.textColor = UIColor.lightGray.withAlphaComponent(0.8)
        lbl.label.numberOfLines = 4
        lbl.font = UIFont.museoSansCyrlBold(ofSize: 32)
        return lbl
    }()
    
    public func setupShadow() {
        self.shadowView.addShadow(shadowColor: self.shadowColor, radius: self.shadowRadius, width: self.shadowX, height: self.shadowY)
        self.setupShadowView()
    }
    
    private func setupShadowView() {
        shadowView.frame = self.bounds
        self.sendSubviewToBack(self.shadowView)
    }
    
    public func register<T: UICollectionViewCell>(classObj: T.Type) {
        self.register(classObj, forCellWithReuseIdentifier: String(describing: classObj))
    }
    
    public func dequeue<T: UICollectionViewCell>(classObj: T.Type, indexPath: IndexPath) -> T? {
        return self.dequeueReusableCell(withReuseIdentifier: String(describing: classObj), for: indexPath) as? T
    }
    
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.initView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initView()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.updateFrames(self.size)
    }
    
    public func initView() {
        self.addSubview(shadowView)
        self.addSubview(self.noItemLabel)
    }
    
    public func updateFrames(_ size: CGSize) {
        let x: CGFloat = 0
        let y: CGFloat = 0
        let h: CGFloat = size.height / 2
        let w: CGFloat = size.width
        noItemLabel.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    public override func reloadData() {
        super.reloadData()
        DispatchQueue.main.async {
            self.noItemLabel.isHidden = self.hasItems
        }
    }
    
    public func setupVerticalFlowLayout(_ size: CGSize) {
        if let layout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = size
            layout.scrollDirection = .vertical
        }
    }
    
    public func setupHorizontalFlowLayout(_ size: CGSize) {
        if let layout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = size
            layout.scrollDirection = .horizontal
        }
    }
    
    public func setupFlowLayout(itemSize size: CGSize) {
        if let layout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = size
        }
    }
    
    public func spacesBetweenCells(between: (row: CGFloat, column: CGFloat)) {
        if let layout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = between.row
            layout.minimumInteritemSpacing = between.column
        }
    }
    
    public func bind<T: UICollectionViewDelegate, S: UICollectionViewDataSource>(delegate dlgt: T, dataSource dts: S) {
        self.delegate = dlgt
        self.dataSource = dts
    }
}
