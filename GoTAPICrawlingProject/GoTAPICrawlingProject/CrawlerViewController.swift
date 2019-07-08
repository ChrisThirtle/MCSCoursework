//
//  ViewController.swift
//  GoTAPICrawlingProject
//
//  Created by Consultant on 7/2/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

class CrawlerViewController: UIViewController {
  
  @IBOutlet weak var crawlerTableView: UITableView!
 
  private let apiUrl = "https://www.anapioficeandfire.com/api/"
  var pageViewModel = PageViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    pageViewModel.navigationController = navigationController
    
    crawlerTableView.dataSource = self
    crawlerTableView.delegate = pageViewModel
    
    //If there is no current page, i.e. the app has just started, load from the base URL
    if pageViewModel.getCurrentPage() == nil {
      pageViewModel.getRootPage(from: apiUrl) { [weak self] (_) in
        DispatchQueue.main.async {
          self?.crawlerTableView.reloadData()
        }
      }
    }
  }
}

extension CrawlerViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pageViewModel.getCurrentPageSize()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")
        ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
    let (titleString, detailString) = pageViewModel.getTitleAndDetail(for: indexPath.row)
    cell.textLabel?.text = titleString
    cell.detailTextLabel?.text = detailString
    return cell
  }
}
