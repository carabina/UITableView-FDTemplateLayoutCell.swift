//
//  ViewController.swift
//  TableViewDynamicHeight
//
//  Created by 伯驹 黄 on 2017/2/21.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import SwiftyJSON

extension UISegmentedControl {
    var selectedTitle: String? {
        return titleForSegment(at: selectedSegmentIndex)
    }
}

class ViewController: UITableViewController {
    
    var feedEntitySections: [[FDFeedEntity]] = []
    
    var prototypeEntitiesFromJSON: [FDFeedEntity] = []
    
    
    
    private lazy var segmentConrol: UISegmentedControl = {
        let segmentConrol = UISegmentedControl(items: ["No cache", "IndexPath cache", "Key cache"])
        segmentConrol.selectedSegmentIndex = 1
        segmentConrol.addTarget(self, action: #selector(selectedChange), for: .valueChanged)
        return segmentConrol
    }()
    
    func selectedChange() {
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        navigationItem.titleView = segmentConrol

        tableView.register(FDFeedCell.self, forCellReuseIdentifier: "cell")
        
        buildTestData {
            self.feedEntitySections.append(self.prototypeEntitiesFromJSON)
            self.tableView.reloadData()
        }
    }
    
    func buildTestData(then: @escaping () -> ()) {
        // Simulate an async request
        DispatchQueue.global().async {

            // Data from `data.json`
            
            guard let dataFilePath = Bundle.main.path(forResource: "data", ofType: "json") else { return }
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: dataFilePath))
                let rootDict = JSON(data).dictionaryValue
                
                guard let feedDicts = rootDict["feed"]?.arrayValue else { return }
                
                // Convert to `FDFeedEntity`
                self.prototypeEntitiesFromJSON = feedDicts.map { FDFeedEntity(dict: $0.dictionaryValue ) }
            } catch let error {
                print(error)
            }

            DispatchQueue.main.async {
                then()
            }
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return feedEntitySections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedEntitySections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        configure(cell: cell, at: indexPath)
        return cell
    }
    
    func configure(cell: UITableViewCell, at indexPath: IndexPath) {
        let cell = cell as? FDFeedCell
        cell?.fd_enforceFrameLayout = true // Enable to use "-sizeThatFits:"
        if indexPath.row % 2 == 0 {
            cell?.accessoryType = .disclosureIndicator
        } else {
            cell?.accessoryType = .checkmark
        }
        cell?.entity = feedEntitySections[indexPath.section][indexPath.row]
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        switch segmentConrol.selectedTitle ?? "" {
        case "No cache":
            return tableView.fd_heightForCell(with: "cell") { (cell) in
                self.configure(cell: cell, at: indexPath)
            }
        case "IndexPath cache":
            return tableView.fd_heightForCell(with: "cell", cacheBy: indexPath) { (cell) in
                self.configure(cell: cell, at: indexPath)
            }
        case "Key cache":
            let entity = feedEntitySections[indexPath.section][indexPath.row]
            return tableView.fd_heightForCell(with: "cell", cacheByKey: entity.identifier ?? "") { (cell) in
                self.configure(cell: cell, at: indexPath)
            }
        default:
            return tableView.rowHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

