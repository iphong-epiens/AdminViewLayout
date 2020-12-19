//
//  ViewController.swift
//  layout
//
//  Created by Inpyo Hong on 2020/12/18.
//

import UIKit
import BonMot

class ViewController: UIViewController {
    @IBOutlet weak var showHostInfoView: UIView!
    @IBOutlet weak var showHostInfoLabel: UILabel!
    
    @IBOutlet weak var textBannerView: UIView!
    @IBOutlet weak var textBannerLabel: UILabel!

    @IBOutlet weak var brcastNoticeView: UIView!
    @IBOutlet weak var brcastNoticeLabelView: UIView!
    @IBOutlet weak var brcastNoticeLabel: UILabel!
    @IBOutlet weak var brcastNoticeSeeMoreView: UIView!
    @IBOutlet weak var brcastNoticeSeeMoreLabel: UILabel!
    @IBOutlet weak var brcastNoticeLabelTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var brcastNoticeDetailButton: UIButton!
    
    var adminInfoView = [UIView]()
    
    var attributedStringShadow: NSShadow = {
      let shadow = NSShadow()
      shadow.shadowColor = UIColor(white: 20.0 / 255.0, alpha: 0.4)
      shadow.shadowOffset = CGSize(width: 0, height: 1)
      return shadow
    }()
    
    let seeMoreStr: NSAttributedString = {
      let shadow = NSShadow()
      shadow.shadowColor = UIColor(white: 20.0 / 255.0, alpha: 0.4)
      shadow.shadowOffset = CGSize(width: 0, height: 1)

      let seeMoreTextStyle = StringStyle(
        .font(.systemFont(ofSize: 17)),
        .lineBreakMode(.byCharWrapping),
        .color(.white),
        .baselineOffset(4),
        .extraAttributes([
          .shadow: shadow
        ])
      )

      return NSAttributedString.composed(
        of: [
          ("더보기", "iconArrowRightWhSm")
        ].map {
          NSAttributedString.composed(of: [
            $0.styled(with: seeMoreTextStyle),
            UIImage(named: $1)!
          ])
        }, separator: " ")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configAdminInfoView()

        self.showHostInfoLabel.text = "Nullam id dolor id nibh ultricies vehicula ut id elit.Nullam id do"
        self.showHostInfoLabel.numberOfLines = 2
        
        let brcastNoticeAttributedString: NSMutableAttributedString = NSMutableAttributedString(attributedString: self.brcastNoticeAttributeText(image: "iconManagerYellowSm", baselineOffset: 4, message: "Nullam id dolor id nibh ultricies vehicula ut id elit.Nullam id dolor id nibh ultricies vehicula ut id elit."))
        self.brcastNoticeLabel.attributedText = brcastNoticeAttributedString
        self.brcastNoticeSeeMoreLabel.attributedText = NSAttributedString(attributedString: seeMoreStr)
    }
    
    func configAdminInfoView() {
        adminInfoView.append(self.showHostInfoView)
        adminInfoView.append(self.textBannerView)
        adminInfoView.append(self.brcastNoticeView)

        _ = self.adminInfoView.map { view in view.isHidden = false }

        self.showHostInfoLabel.text = "\n"
        self.brcastNoticeLabel.text = "\n"
        
        DispatchQueue.main.async {
            print("brcastNoticeLabel height", self.brcastNoticeLabel.frame.size.height)
            if self.brcastNoticeLabel.frame.size.height > 50 {
                self.brcastNoticeSeeMoreView.isHidden = false
                self.brcastNoticeLabel.numberOfLines = 2
                self.brcastNoticeLabelTrailingConstraint.constant = 80
                self.brcastNoticeDetailButton.isEnabled = true
            }
        }
    }

    @IBAction func tapbrcastNoticeDetailButton(_ sender: Any) {
        print(#function)
    }
}

extension ViewController {
    func brcastNoticeAttributeText(image: String, baselineOffset: CGFloat, message: String) -> NSAttributedString {
      let attributedString: NSAttributedString = {
        let textStyle = StringStyle(
          .font(.systemFont(ofSize: 17)),
          .lineBreakMode(.byCharWrapping),
          .color(UIColor(red: 1.0, green: 226.0 / 255.0, blue: 77.0 / 255.0, alpha: 1.0)),
          .baselineOffset(baselineOffset),
          .extraAttributes([
            .shadow: self.attributedStringShadow
          ])
        )

        return NSAttributedString.composed(
          of: [
            (image, message)
          ].map {
            NSAttributedString.composed(of: [
              UIImage(named: $0)!,
              $1.styled(with: textStyle)
            ])
          }, separator: " ")
      }()

      return attributedString
    }
}
