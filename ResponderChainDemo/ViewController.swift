//
//  ViewController.swift
//  ResponderChainDemo
//
//  Created by Matt Hayes on 9/22/17.
//

import UIKit

class TitleEvent : UIEvent {
    var title : String = ""
    init(title: String) {
        self.title = title
    }
}

@objc protocol TitleTableViewCellActionHandler {
    func updateTitleForCell(sender:AnyObject, forEvent:TitleEvent)
}

class TitleTableViewCell : UITableViewCell {
    let button = UIButton()
    
    func populate() {
        self.textLabel?.text = "Ok"
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.blue, for: .normal)
        button.setTitle("Test", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: UIControlEvents.touchUpInside)
        contentView.addSubview(button)
        
        let viewsDict = ["button":button]
        
        var constraints = [NSLayoutConstraint]()
        constraints.append(contentsOf:NSLayoutConstraint.constraints(withVisualFormat: "H:[button(200)]-0-|", options: [], metrics: nil, views: viewsDict))
        constraints.append(contentsOf:NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[button]-0-|", options: [], metrics: nil, views: viewsDict))
        
        addConstraints(constraints)
    }
    
    @objc func buttonTapped() {
        let event = TitleEvent(title: button.titleLabel?.text ?? "nil")
        let application = UIApplication.shared
        application.sendAction(#selector(TitleTableViewCellActionHandler.updateTitleForCell(sender:forEvent:)), to: nil, from: self, for: event)
    }
}

class ViewController : UIViewController,  UITableViewDataSource, UITableViewDelegate, TitleTableViewCellActionHandler {
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: "TitleTableViewCell")
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        let viewsDict = ["tableView":tableView]
        var constraints = [NSLayoutConstraint]()
        constraints.append(contentsOf:NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tableView]-0-|", options: [], metrics: nil, views: viewsDict))
        constraints.append(contentsOf:NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[tableView]-0-|", options: [], metrics: nil, views: viewsDict))
        
        view.addConstraints(constraints)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell", for: indexPath)
        if let titleCell = cell as? TitleTableViewCell {
            titleCell.populate()
        }
        return cell
    }
    
    @objc func updateTitleForCell(sender: AnyObject, forEvent titleEvent: TitleEvent) {
        navigationItem.title = titleEvent.title
    }
}

