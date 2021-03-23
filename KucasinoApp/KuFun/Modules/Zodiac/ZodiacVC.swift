//
//  ZodiacVC.swift
//  FallInLove
//
//  Created by paxcreation on 1/18/21.
//

import UIKit
import RxCocoa
import RxSwift

class ZodiacVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let disposeBag = DisposeBag()
    @VariableReplay private var source: [ZodiacModel] = []
//    private var interstitial: GADInterstitial!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.visualize()
        self.setupRX()
    }
}
extension ZodiacVC {
    private func visualize() {
        let buttonLeft = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 44, height: 44)))
//        let img: UIImage = UIImage(systemName: "chevron.backward") ?? UIImage()
//        ic-back
        let img: UIImage = UIImage(named: "ic-back") ?? UIImage()
        buttonLeft.setImage(img, for: .normal)
        buttonLeft.imageView?.image = buttonLeft.imageView?.image?.withRenderingMode(.alwaysTemplate)
        buttonLeft.imageView?.tintColor = .black
        buttonLeft.contentEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        let leftBarButton = UIBarButtonItem(customView: buttonLeft)

        navigationItem.leftBarButtonItem = leftBarButton
        buttonLeft.rx.tap.bind { _ in
            self.dismiss(animated: true, completion: nil)
        }.disposed(by: disposeBag)

        title = "12 Cung hoàng đạo"
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        collectionView.register(ZodiacCell.nib, forCellWithReuseIdentifier: ZodiacCell.identifier)

        
        collectionView.snp.makeConstraints { (make) in
//            make.bottom.equalTo(banner.snp.top)
            make.bottom.equalToSuperview()
        }
        
    }
    private func setupRX() {
        self.$source.asObservable()
            .bind(to: self.collectionView.rx.items(cellIdentifier: ZodiacCell.identifier, cellType: ZodiacCell.self)) { row, data, cell in
                cell.lbName.text = data.text
                cell.imgName.image = UIImage(named: data.image ?? "")
            }.disposed(by: disposeBag)
        
        ReadJSONFallLove.shared
            .readJSONObs(offType: [ZodiacModel].self, name: "zodiac", type: "json")
            .subscribe { [weak self] (result) in
                guard let wSelf = self else {
                    return
                }
                switch result {
                case .success(let data):
                    wSelf.source = data
                case .failure(let err):
                    print("\(err.localizedDescription)")
                }
            } onError: { (err) in
                print("\(err.localizedDescription)")
            }.disposed(by: disposeBag)
    }
}
extension ZodiacVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = (self.view.bounds.size.width - 20) / 3
        return CGSize(width: w, height: w)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.source[indexPath.row]
        let vc = ZodiacDetailVC(nibName: "ZodiacDetailVC", bundle: nil)
        vc.source = item
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
//extension ZodiacVC: GADInterstitialDelegate {
//    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
//        interstitial.present(fromRootViewController: self)
//    }
//}
