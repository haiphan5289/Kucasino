//
//  ZodiacDetailVC.swift
//  FallInLove
//
//  Created by paxcreation on 1/19/21.
//

import UIKit
import RxCocoa
import RxSwift
import SwiftSoup

struct ZodiacModel: Codable {
    var image, text, day, code: String?
    enum CodingKeys: String, CodingKey {
        case image
        case text
        case day
        case code
    }
//    public init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        image = try values.decodeIfPresent(String.self, forKey: .image)
//        text = try values.decodeIfPresent(String.self, forKey: .text)
//        day = try values.decodeIfPresent(String.self, forKey: .day)
//        code = try values.decodeIfPresent(String.self, forKey: .code)
//    }
    mutating func createZodiac() {
        self.image = "bao binh"
        self.text = "bao binh"
    }
}

class ZodiacDetailVC: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var tvContent: UITextView!
    var source: ZodiacModel?
    private let disposeBag = DisposeBag()
//    private var interstitial: GADInterstitial!
//    private let banner: GADBannerView = {
//       let b = GADBannerView()
//        //source
////        ca-app-pub-3940256099942544/2934735716
//        //drawanime
//        //ca-app-pub-1498500288840011/7599119385
//        //ca-app-pub-1498500288840011/7599119385
//        b.adUnitID = AdModId.share.bannerID
//        b.load(GADRequest())
//        b.adSize = kGADAdSizeSmartBannerPortrait
//        if #available(iOS 13.0, *) {
//            b.backgroundColor = .secondarySystemBackground
//        } else {
//            b.backgroundColor = .white
//        }
//        return b
//    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.visualize()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
}
extension ZodiacDetailVC {
    private func visualize() {
        lbName.text = source?.day
        img.image = UIImage(named: source?.image ?? "")
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let result = formatter.string(from: date)
        var textDes: String = ""
        
//        var listWords: [String] = []
//        var t: String = ""
//        let text = "\(source?.image ?? "") "
//        text.forEach({ (c) in
//            t += "\(c)"
//            print("\(t) ====== \(c)")
//            if String(c) == " " {
//                listWords.append(t)
//                t = ""
//            }
//        })
//        print("\(listWords)")
//        let a = listWords.compactMap { $0 }.joined(separator: "-").replacingOccurrences(of: " ", with: "")
//        print("\(a)")
        title = "Hôm nay, của bạn"
        let url = URL(string: "https://thientue.vn/tu-vi-\(result)-cung-\(source?.code ?? "").html")
        guard let myURL = url else {
            print("Error: \(String(describing: url)) doesn't seem to be a valid URL")
            return
        }
        let html = try! String(contentsOf: myURL, encoding: .utf8)
        do {
            let doc: Document = try SwiftSoup.parse(html)
            let headerTitle = try doc.select("p")
            headerTitle.enumerated().forEach { (e) in
                switch e.offset {
                case 0...6:
                    do {
                        let t = try e.element.text()
                        textDes += t + "\n" + "\n"
                    } catch let err {
                        print("\(err.localizedDescription)")
                    }
                default:
                    break
                }
            }
            self.tvContent.text = textDes
            //                let els: Elements = try SwiftSoup.parse(html).select("a")
            //                for link: Element in els.array(){
            //                    let linkHref: String = try link.attr("href")
            //                    let linkText: String = try link.text()
            //                    print("\(linkHref)")
            //                    print("\(linkText)")
            //                }
            //                // my body
            //                let body = doc.body()
            //                // elements to remove, in this case images
            //                let undesiredElements: Elements? = try body?.select("img[src]")
            //                //remove
            //                try undesiredElements?.remove()
            
            
            //
            //                if let att = headerTitle?.htmlToAttributedString  {
            ////                    let count = att.string.count
            ////                    let att1 = NSMutableAttributedString(attributedString: att)
            ////                    att1.addAttributes([NSAttributedString.Key.font: UIFont(name: "Montserrat-Regular", size: 13.0) as Any ], range: NSMakeRange(0, count))
            //                    tvContent.attributedText = att
            //                }
        } catch Exception.Error(let _, let message) {
            print("Message: \(message)")
        } catch {
            print("error")
        }
        
//        self.interstitial = GADInterstitial(adUnitID: AdModId.share.interstitialID)
//        let request = GADRequest()
//        self.interstitial.load(request)
//        self.interstitial.delegate = self
        
        
//        self.view.addSubview(banner)
//        banner.rootViewController = self
//        banner.snp.makeConstraints { (make) in
//            make.left.right.equalToSuperview()
//            make.height.equalTo(70)
//            make.width.equalToSuperview()
//            make.bottom.equalTo(self.view)
//        }
        
        tvContent.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
        }
    }
}
//extension ZodiacDetailVC: GADInterstitialDelegate {
//    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
//        interstitial.present(fromRootViewController: self)
//    }
//}
