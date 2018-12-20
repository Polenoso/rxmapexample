//
//  EventListTableViewController.swift
//  What To Do
//
//  Created by Aitor Pagán on 19/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EventListTableViewController: UITableViewController {
    
    var navigator: EventListNavigatorProtocol?
    var viewModel: EventListViewModelProtocol?
    
    let disposeBag = DisposeBag()
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        setup()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let service = EventListViewModel(with: EventsLocalDataStore())
        let navigation = EventListNavigator()
        navigation.viewController = self
        viewModel = service
        navigator = navigation
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bind()
    }
    
    private func setupTableView() {
        tableView.estimatedRowHeight = 2.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.delegate = nil
        tableView.dataSource = nil
        tableView.register(EventListTableViewCell.self, forCellReuseIdentifier: EventListTableViewCell.ReusableIdentifier)
    }
    
    private func bind() {
        viewModel?.bind()
            .drive(tableView
                .rx
            .items(cellIdentifier: EventListTableViewCell.ReusableIdentifier, cellType: EventListTableViewCell.self)) { (_, event, cell) in
                cell.updateUI(event)
        }.disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(EventViewModel.self)
            .bind { (vm) in
            self.navigator?.navigateToDetail(vm)
        }
            .disposed(by: disposeBag)
    }

}
