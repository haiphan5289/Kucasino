//
//  HomeApp.swift
//  KucasinoApp
//
//  Created by paxcreation on 3/8/21.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class HomeApp: BaseViewController {
    
    @IBOutlet weak var btPlay: UIButton!
    
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.visualize()
        self.setupRX()
    }
    
}
extension HomeApp {
    private func visualize() {
    }
    
    private func setupRX() {
        self.btPlay.rx.tap.bind { _ in
            let vc = PlayVC.initiationVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: disposeBag)
    }
}
