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
import Firebase


enum HomeType: Int {
    case app = 0
    case game = 1
}

class HomeApp: BaseViewController {
    
    @IBOutlet weak var btPlay: UIButton!
    @IBOutlet weak var btRate: UIButton!
    @IBOutlet weak var btSupport: UIButton!
    @IBOutlet weak var viewGame: UIView!
    @IBOutlet weak var viewApp: UIView!
    @IBOutlet weak var btHome: UIButton!
    @IBOutlet weak var btContact: UIButton!
    
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
        let dataBase = Database.database().reference()
        dataBase.child("Home").observe(.childAdded) { (snapShot) in
            let isCheck = snapShot.value as? Int
            
            if isCheck == HomeType.game.rawValue {
                self.viewGame.isHidden = false
            } else {
                self.viewApp.isHidden = false
            }
        }
    }
    
    private func setupRX() {
        self.btPlay.rx.tap.bind { _ in
            let vc = PlayVC.initiationVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: disposeBag)
        
        self.btRate.rx.tap.bind { _ in
            self.moveToRateApp()
        }.disposed(by: disposeBag)
        
        self.btSupport.rx.tap.bind { _ in
            self.moveToMyApps()
        }.disposed(by: disposeBag)
        
        self.btHome.rx.tap.bind { _ in
            self.moveToHome()
        }.disposed(by: disposeBag)

        self.btContact.rx.tap.bind { _ in
            self.moveToZalo()
        }.disposed(by: disposeBag)

    }
    
    func moveToHome() {
        guard let urlStr = URL(string: "https://kubet66.info/") else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(urlStr, options: [:], completionHandler: nil)
            
        } else {
            UIApplication.shared.openURL(urlStr)
        }
    }
    
    func moveToZalo() {
        guard let urlStr = URL(string: "https://zalo.me/g/ehyttc149") else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(urlStr, options: [:], completionHandler: nil)
            
        } else {
            UIApplication.shared.openURL(urlStr)
        }
    }
    
    func moveToRateApp() {
        guard let urlStr = URL(string: AppSettings.share.appleDevelope) else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(urlStr, options: [:], completionHandler: nil)
            
        } else {
            UIApplication.shared.openURL(urlStr)
        }
    }
    
    func moveToMyApps() {
        guard let urlStr = URL(string: AppSettings.share.appleDevelope) else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(urlStr, options: [:], completionHandler: nil)
            
        } else {
            UIApplication.shared.openURL(urlStr)
        }
    }
}
extension HomeApp {
    func convertDataSnapshotToCodable<T: Codable> (data: DataSnapshot, type: T.Type) -> T? {
        do {
            let value = try JSONSerialization.data(withJSONObject: data.value, options: .prettyPrinted)
            let objec = try JSONDecoder().decode(T.self, from: value)
            return objec
        } catch let err {
            print(err.localizedDescription)
        }
        return nil
    }
}
