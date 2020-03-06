//
//  LeftMenuViewController.swift
//  uzcard trade
//
//  Created by Muhammadjon Tohirov on 12/2/19.
//  Copyright © 2019 Plum Technologies. All rights reserved.
//

import UIKit

public protocol LeftMenuDelegate {
    func onSelect(id: LeftMenuItem)
}

public final class LeftMenuController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    private let tableView: TTableView = TTableView()
    private let logoImage: TImageView = TImageView(frame: .zero)
    private let exitButton: TButton = TButton()
    private var model = LeftMenuModel()
    public var delegate: LeftMenuDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        exitButton.setImage( #imageLiteral(resourceName: "icon_exit"), for: .normal)
        logoImage.image = #imageLiteral(resourceName: "uzcard_trade_dark")
        logoImage.contentMode = .scaleAspectFit
        exitButton.onClick(self, #selector(onClickExit))
    }
    
    public override func initialize() {
        self.addSubviews(self.tableView, logoImage, exitButton)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 50
        self.tableView.backgroundColor = .clear
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var w: CGFloat = UIScreen.main.bounds.width * 0.32
        var h: CGFloat = 40 * 0.538
        var y = (40 - h) / 2 + self.topSafe
        var x: CGFloat = 24
        self.logoImage.frame = CGRect(x: x, y: y, width: w, height: h)
        self.logoImage.imageView.wrapWidth()
        
        x = 24
        y = self.logoImage.maxY + 16
        self.exitButton.frame = CGRect(x: x, y: y, width: 24, height: 24)
        
        x = 0
        y = self.exitButton.maxY + 8
        w = view.width
        h = view.height - y
        self.tableView.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    public func setModel(_ model: LeftMenuModel) {
        self.model = model
        self.tableView.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TTableViewCell ?? TTableViewCell(style: .default, reuseIdentifier: "cell")
        
        let item = self.model.items[indexPath.row]
        
        cell.makeSimpleRow()
        cell.textLabel?.text = item.title
        return cell
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let isTop = (scrollView.contentOffset.y < 30)
        if let v = self.tableView.headerView(forSection: 0) {
            if !isTop {
                v.backgroundView?.makeBlur(style: .light)
            } else {
                v.backgroundView?.clearFromBlur()
            }
        }
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Категории товаров"
    }
    
    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = (view as? UITableViewHeaderFooterView)
        headerView?.tintColor = UIColor.clear
        headerView?.textLabel?.font = UIFont.museoSansCyrlBold(ofSize: 18)
        headerView?.textLabel?.contentMode = .bottom
        headerView?.textLabel?.textColor = UIColor.appBlack
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.onSelect(id: self.model.items[indexPath.row])
    }
    
    @objc func onClickExit() {
        (self.navigationController as? SideMenuNavigationController)?.dismiss(animated: true, completion: nil)
    }
}
