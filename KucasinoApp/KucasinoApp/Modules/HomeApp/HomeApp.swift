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
        
    }
}
