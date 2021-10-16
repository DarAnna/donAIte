import UIKit
import Kingfisher
import SnapKit

public class OrganizationCell: UICollectionViewCell {
    
    let topContainer = UIView()
    let topContainerShadow = UIImageView()
    let topContentContainer = UIView()
    
//    let middleContainer = UIView()
//    var middleContainerBlur = UIVisualEffectView(effect: UIBlurEffect(style: .light))
//    let middleContentContainer = UIView()
    
    let bottomContainer = UIView()
    var bottomContainerBlur = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    let bottomContentContainer = UIView()
    
    let titleLabel = UILabel()
    let category = UILabel()
    
    let donateButton = ITButton(title: "Donate", background: .blue, size: .small)
    
    
  
    let detailsLabel = UILabel()
    let mainImage = UIImageView()
    let blurredUpperPartImage = UIImageView()
    let blurredLowerPartImage = UIImageView()
    
    let topContainerShadowHeight = 130
    
    //let middleContainerHeight: CGFloat = 88
    let bottomContainerHeight: CGFloat = 88
    

    let categoryContainerAndImageHeight = 26
    
    let topContainerOffset: CGFloat = 20
    let topContainerInterOffset: CGFloat = 10
    let topContainerEdgeOffset: CGFloat = 20
    let topContainerDividedBy: Int = 7
    let contentContainerOffset = 16
    let verticalOffsetBetweenContainers = 10
    let verticalOffsetBetweenContainersMin = 4
    let horizontalOffsetBetweenViews = 8
    let verticalOffsetFromBottomToCenterButton = 30
    let offsetScrollViewToBottom = 120
    let rowHeight: CGFloat = 22
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if #available(iOS 13, *) {
            //middleContainerBlur = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialDark))
            bottomContainerBlur = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        }
        
        configureCellContentView()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.isUserInteractionEnabled = true
    }
    
    func configureCellContentView() {
        self.contentView.layer.cornerRadius = 8.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 8.0
        self.layer.shadowOpacity = 0.24
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds,
                                             cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }

    
    func bind(organization: Organization) {
        let placeholder: UIImage = #imageLiteral(resourceName: "placeholder_image")
        
        mainImage.kf.setImage(
            with: URL(string: organization.imageLink ?? ""),
            placeholder: placeholder
        )
        
        topContainerShadow.image = #imageLiteral(resourceName: "post_shadow_bg")
        topContainerShadow.contentMode = .scaleToFill
        
        blurredUpperPartImage.kf.setImage(
            with: URL(string: organization.imageLink ?? ""),
            placeholder: placeholder
        )
        
        blurredLowerPartImage.kf.setImage(
            with: URL(string: organization.imageLink ?? ""),
            placeholder: placeholder
        )
        
        titleLabel.text = organization.name
        
        category.text = organization.category
        
        detailsLabel.text = organization.description
    }
    
    // MARK: View Tree
    
    private func setupViews() {
        contentView.addSubview(topContainer)
        //contentView.addSubview(middleContainer)
        contentView.addSubview(bottomContainer)
        
        makeTopContainerLayout()
        //makeMiddleContainerLayout()
        makeBottomContainerLayout()
    }
    
    func makeTopContainerLayout() {
        topContainer.addSubview(mainImage)
        topContainer.addSubview(topContainerShadow)
        topContainer.addSubview(topContentContainer)
        topContentContainer.addSubview(titleLabel)
        topContentContainer.addSubview(category)
        topContentContainer.addSubview(donateButton)
    
        
        mainImage.clipsToBounds = true
        mainImage.contentMode = .scaleAspectFill
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        category.textColor = .white
        category.numberOfLines = 4

       
        
        topContainer.snp.makeConstraints { make in
            make.height.equalTo(self.contentView.frame.height - bottomContainerHeight)
            make.leading.top.left.width.equalToSuperview()
        }
        
        mainImage.snp.makeConstraints { make in
            make.edges.equalTo(topContainer)
        }
        
        topContainerShadow.snp.makeConstraints { make in
            make.top.left.right.equalTo(topContainer)
            make.height.equalTo(topContainerShadowHeight)
        }
        
        topContentContainer.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(contentContainerOffset)
            make.bottom.right.equalToSuperview().offset(-contentContainerOffset)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.width.equalToSuperview()
        }
        
       
        category.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(verticalOffsetBetweenContainersMin)
            make.left.right.equalToSuperview()
        }
        
        donateButton.snp.makeConstraints { make in
            make.bottom.equalTo(topContainer).offset(-10)
        }
        
        
    }
    
//    func makeMiddleContainerLayout() {
//        middleContainer.addSubview(blurredUpperPartImage)
//
//        blurredUpperPartImage.clipsToBounds = true
//        blurredUpperPartImage.contentMode = .scaleAspectFill
//
//        middleContainer.addSubview(middleContainerBlur)
//        middleContainer.addSubview(middleContentContainer)
//        middleContentContainer.addSubview(detailsLabel)
//
//        detailsLabel.numberOfLines = 2
//        detailsLabel.font = .systemFont(ofSize: 15, weight: .regular)
//
//
//        middleContainer.snp.makeConstraints { make in
//            make.height.equalTo(middleContainerHeight)
//            make.left.width.equalToSuperview()
//            make.top.equalTo(topContainer.snp.bottom)
//        }
//
//        blurredUpperPartImage.snp.makeConstraints { make in
//            make.edges.equalTo(middleContainer)
//        }
//
//        middleContainerBlur.snp.makeConstraints { make in
//            make.edges.equalTo(middleContainer)
//        }
//
//        middleContentContainer.snp.makeConstraints { make in
//            make.top.left.equalToSuperview().offset(contentContainerOffset)
//            make.bottom.right.equalToSuperview().offset(-contentContainerOffset)
//        }
//
//
//        detailsLabel.snp.makeConstraints { make in
//            make.top.left.right.equalToSuperview()
//            make.left.right.equalToSuperview()
//            make.height.equalTo(detailsLabel)
//        }
//    }
    
    func makeBottomContainerLayout() {
        bottomContainer.addSubview(blurredLowerPartImage)
        bottomContainer.addSubview(bottomContainerBlur)
        bottomContainer.addSubview(bottomContentContainer)
        bottomContainer.addSubview(detailsLabel)
        
        
        detailsLabel.numberOfLines = 4
        detailsLabel.font = .systemFont(ofSize: 15, weight: .regular)
                
//        bottomContainer.backgroundColor = .orange.withAlphaComponent(0.6)
//        bottomContentContainer.backgroundColor = .blue.withAlphaComponent(0.6)
        
        blurredLowerPartImage.clipsToBounds = true
        blurredLowerPartImage.contentMode = .scaleAspectFill
 
        bottomContainer.snp.makeConstraints { make in
            make.height.equalTo(bottomContainerHeight)
            make.left.width.equalToSuperview()
            make.top.equalTo(topContainer.snp.bottom)
        }
        
        blurredLowerPartImage.snp.makeConstraints { make in
            make.edges.equalTo(bottomContainer)
        }
        
        bottomContainerBlur.snp.makeConstraints { make in
            make.edges.equalTo(bottomContainer)
        }
        
        bottomContentContainer.snp.makeConstraints { make in
            make.edges.equalTo(bottomContainer)
        }
        
        detailsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.left.right.equalToSuperview().offset(8)
            make.height.equalTo(bottomContainer)
        }
    }
    
    
}
