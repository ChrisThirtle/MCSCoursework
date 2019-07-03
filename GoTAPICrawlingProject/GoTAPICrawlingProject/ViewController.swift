//
//  ViewController.swift
//  GoTAPICrawlingProject
//
//  Created by Consultant on 7/2/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var crawlerTableView: UITableView!
  
  private let apiUrl = "https://www.anapioficeandfire.com/api/"
  var pageViewModel = PageViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    pageViewModel.navigationController = navigationController
    crawlerTableView.dataSource = pageViewModel
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
