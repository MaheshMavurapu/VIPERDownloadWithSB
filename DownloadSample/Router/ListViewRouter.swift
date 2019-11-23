//
//  ListViewRouter.swift
//  DownloadSample
//
//  Created by Mahesh Mavurapu on 21/11/19.
//  Copyright © 2019 ojas. All rights reserved.
//

import Foundation
import UIKit

protocol ListViewRouterProtocol: class {
    static func createListViewController() -> UIViewController
//    func presentPostDetailScreen(from view: ListViewProtocol, forPost post: Post)
}

class ListViewRouter: ListViewRouterProtocol {
    
    class func createListViewController() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "NavigationController")
        if let view = navController.children.first as? ListViewController {
            
            let router: ListViewRouterProtocol = ListViewRouter()
            let entity: ListViewEntityProtocol = ListViewEntity()
            let presenter: ListViewPresenterProtocol = ListViewPresenter()
            let interactor: ListViewInteractorProtocol = ListViewInteractor()
            
            view.presenter = presenter
            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router
            interactor.presenter = presenter
            interactor.entity = entity
            
            return navController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
//    func presentPostDetailScreen(from view: ListViewProtocol, forPost post: Post) {
//        let postDetailViewController = PostsDetailRouter.createPostDetailModule(forPost: post)
//        if let sourceView = view as? UIViewController {
//           sourceView.navigationController?.pushViewController(postDetailViewController, animated: true)
//        }
//    }
}

