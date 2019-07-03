//
//  PageViewModel.swift
//  GoTAPICrawlingProject
//
//  Created by Consultant on 7/2/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit


protocol PageNavigator {
  var navigationController: UINavigationController? { get }
  func getNextPage(from data: CrawlData,
                   completion: @escaping (PageType?) -> Void)
  func getRootPage(from urlString: String,
                   completion: @escaping (PageType?) -> Void)
}

class PageViewModel: NSObject {
  private var currentPage: PageType?
  private var crawlStringifier: CrawlDataStringifier
  var navigationController: UINavigationController?
  
  init(stringifier: CrawlDataStringifier = CrawlDataManager()) {
    self.crawlStringifier = stringifier
  }
  
  func getCurrentPage() -> PageType? {
    return currentPage
  }
}

extension PageViewModel: PageNavigator {
  func getNextPage(from data: CrawlData,
                   completion: @escaping (PageType?) -> Void) {
    PageType.getPage(from: data) { (page) in
      completion(page)
    }
  }
  func getRootPage(from urlString: String, completion: @escaping (PageType?) -> Void) {
    PageType.getPage(from: urlString) { [weak self] (page) in
      self?.currentPage = page
      completion(page)
    }
  }
}

extension PageViewModel: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let currentPage = currentPage else { return 0 }
    return currentPage.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell = {
      guard let temp = tableView.dequeueReusableCell(withIdentifier: "cell") else {
        return UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
      }
      return temp
    }()
    guard let currentPage = currentPage else { return cell }
    let (titleString, detailString) = crawlStringifier.titleAndDetailString(for: currentPage, index: indexPath.row)
    cell.textLabel?.text = titleString
    cell.detailTextLabel?.text = detailString
    return cell
  }
}

extension PageViewModel: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
    guard let data = currentPage?.getCrawlerData(from: indexPath.row) else { return }
    getNextPage(from: data) { [weak self] (nextPage) in
      guard let nextPage = nextPage,
        let newView = storyboard.instantiateViewController(withIdentifier: "CrawlerViewController") as? ViewController else { return }
      newView.pageViewModel.currentPage = nextPage
      DispatchQueue.main.async {
        self?.navigationController?.pushViewController(newView, animated: true)
      }
    }
  }
}
