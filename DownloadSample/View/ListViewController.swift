//
//  ListViewController.swift
//  DownloadSample
//
//  Created by Mahesh Mavurapu on 21/11/19.
//  Copyright © 2019 ojas. All rights reserved.
//

import UIKit
import PKHUD

protocol ListViewProtocol: class {
    var presenter: ListViewPresenterProtocol? { get set }
    
    func showPosts(_ posts: [Hits])
    func hideLoading()
    func showLoading()
    func showError()
}

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var presenter: ListViewPresenterProtocol?
    var posts: [Hits] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension ListViewController: ListViewProtocol {
    func showPosts(_ posts: [Hits]) {
        self.posts = posts
        if self.posts.count > 0 {
            DispatchQueue.main.async { [unowned self] in
                self.tableView.reloadData()
            }
        }
    }
    
    func hideLoading() {
        HUD.hide()
    }
    
    func showLoading() {
        HUD.show(.progress)
    }
    
    func showError() {
        HUD.flash(.label("Internet disconnection"), delay: 1.0)
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        let post = self.posts[indexPath.row]
        cell.set(forPost: post)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        presenter?.showPostDetail(forPost: self.posts[indexPath.row])
    }
}
