//
//  PlayVC.swift
//  KucasinoApp
//
//  Created by paxcreation on 3/8/21.
//

import UIKit
import RxSwift
import RxCocoa

class PlayVC: BaseViewController {
    
    @IBOutlet weak var btBack: UIButton!
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var numberOne: UILabel!
    @IBOutlet weak var numberTwo: UILabel!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var BtResult1: UIButton!
    @IBOutlet weak var btResultTwo: UIButton!
    @IBOutlet weak var btResultThree: UIButton!
    @IBOutlet weak var btResultFour: UIButton!
    
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.visualize()
        self.setupRX()
    }
    
}
extension PlayVC {
    private func visualize() {
        self.numberOne.text = "\(self.randomeNumber())"
        self.numberTwo.text = "\(self.randomeNumber())"
        self.result.text = "???"
        self.generateNumber()
    }
    
    private func setupRX() {
        
        Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).bind(onNext: weakify({ (value, wSelf) in
            wSelf.timer.text = "Timer: \(value)"
        })).disposed(by: disposeBag)
        
        let bts = [self.BtResult1, self.btResultTwo, self.btResultThree, self.btResultFour]
        bts.forEach { (bt) in
            guard let bt = bt else {
                return
            }
            bt.rx.tap.bind { _ in
                guard let value = self.BtResult1.titleLabel?.text, let v = Int(value) else {
                    return
                }
                self.checkValue(value: v)
            }.disposed(by: disposeBag)
        }
//        self.BtResult1.rx.tap.bind { _ in
//            guard let value = self.BtResult1.titleLabel?.text, let v = Int(value) else {
//                return
//            }
//            self.checkValue(value: v)
//        }.disposed(by: disposeBag)
        
        self.btBack.rx.tap.bind { _ in
            self.navigationController?.popViewController(animated: true)
        }.disposed(by: disposeBag)
    }
    
    private func checkValue(value: Int) {
        if value == self.totalTwoNumber() {
            self.visualize()
        } else {
            let alert: UIAlertController = UIAlertController(title: nil, message: "Kết quả bạn sai", preferredStyle: .alert)
            let btCancel: UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(btCancel)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func generateNumber(){
        var list: [Int] = []
        
        let numberOne = self.randomeNumber()
        let numberTwo = self.randomeNumber()
        let numberThree = self.randomeNumber()
        
        let numberFour1 = Int(self.numberOne.text ?? "0") ?? 0
        let numberFour2 = Int(self.numberTwo.text ?? "0") ?? 0
        let numberFour = numberFour1 + numberFour2
        
        
        list.append(numberOne)
        list.append(numberTwo)
        list.append(numberThree)
        list.append(numberFour)
        
        let text1 = Int.random(in: 0..<list.count - 1)
        self.BtResult1.setTitle("\(list[text1])", for: .normal)
        
        let list2 = self.removeNumber(list: list, number: list[text1])
        let text2 =  Int.random(in: 0..<list2.count - 1)
        self.btResultTwo.setTitle("\(list2[text2])", for: .normal)
        
        let list3 = self.removeNumber(list: list2, number: list2[text2])
        let text3 =  Int.random(in: 0..<list3.count - 1)
        self.btResultThree.setTitle("\(list3[text3])", for: .normal)
        
        let list4 = self.removeNumber(list: list3, number: list3[text3])
        self.btResultFour.setTitle("\(list4[0])", for: .normal)
    }
    
    private func totalTwoNumber() -> Int {
        let numberFour1 = Int(self.numberOne.text ?? "0") ?? 0
        let numberFour2 = Int(self.numberTwo.text ?? "0") ?? 0
        let numberFour = numberFour1 + numberFour2
        return numberFour
    }
    
    private func removeNumber(list: [Int], number: Int) -> [Int] {
        var l = list
        
        list.enumerated().forEach { (item) in
            if item.element == number {
                l.remove(at: item.offset)
            }
        }
        
        return l
    }
    
    private func randomeNumber() -> Int {
        let number = Int.random(in: 0..<100)
        return number
    }
}
