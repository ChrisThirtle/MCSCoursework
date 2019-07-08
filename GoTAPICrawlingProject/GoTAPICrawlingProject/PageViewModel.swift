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
  private let crawlStringifier: CrawlDataStringifier
  var navigationController: UINavigationController?
  
  init(stringifier: CrawlDataStringifier = CrawlDataViewModel()) {
    self.crawlStringifier = stringifier
  }
  
  func getCurrentPage() -> PageType? {
    return currentPage
  }
  
  func getCurrentPageSize() -> Int {
    return currentPage?.count ?? 0
  }
  
  func getTitleAndDetail(for index: Int) -> (String, String) {
    guard let currentPage = currentPage else { return ("","") }
    return crawlStringifier.titleAndDetailString(for: currentPage, index: index)
  }
}

extension PageViewModel: PageNavigator {
  func getNextPage(from data: CrawlData,
                   completion: @escaping (PageType?) -> Void) {
    PageType.getPage(from: data) { (page) in
      completion(page)
    }
  }
  func getRootPage(from urlString: String,
                   completion: @escaping (PageType?) -> Void) {
    PageType.getPage(from: urlString) { [weak self] (page) in
      self?.currentPage = page
      completion(page)
    }
  }
}

extension PageViewModel: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
    guard let data = currentPage?.getCrawlData(from: indexPath.row) else { return }
    getNextPage(from: data) { [weak self] (nextPage) in
      guard let newView = storyboard.instantiateViewController(withIdentifier: "CrawlerViewController") as? CrawlerViewController else { return }
      newView.pageViewModel.currentPage = nextPage
      DispatchQueue.main.async {
        self?.navigationController?.pushViewController(newView, animated: true)
      }
    }
  }
}
