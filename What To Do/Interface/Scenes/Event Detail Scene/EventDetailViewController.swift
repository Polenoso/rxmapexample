//
//  EventDetailViewController.swift
//  What To Do
//
//  Created by Aitor Pagán on 20/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EventDetailViewController: UIViewController {
    @IBOutlet var closeButton: UIButton!
    @IBOutlet var contentStackView: UIStackView!
    
    private let disposeBag = DisposeBag()
    var eventId: String = ""
    
    private var viewModel: EventDetailViewModel?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        let service = EventDetailViewModel(dataStore: EventsLocalDataStore())
        viewModel = service
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = closeButton.rx.tap
        button.bind {_ in self.dismiss(animated: true, completion: nil)} .disposed(by: disposeBag)
        bind()
    }
    
    private func bind() {
        viewModel?.bind(eventId).subscribe(onNext: { (modelView) in
            _ = modelView.map({ (item) -> Any in
                let auxiliaryView = EventItemDetailView()
                self.contentStackView.addArrangedSubview(auxiliaryView)
                auxiliaryView.updateUI(item)
                return auxiliaryView
            })
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }

}
