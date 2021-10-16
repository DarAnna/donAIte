import Foundation
import UIKit
import SnapKit
import NKButton

enum ButtonBackground {
    case red
    case green
    case blue
}

struct ButtonDimension {
    let height: CGFloat
    let width: CGFloat
    
    init(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
    }
}

enum ButtonSize {
    case big
    case medium
    case small
    case smallMedium
    
    var size: ButtonDimension {
        switch self {
        case .big:
            return ButtonDimension(width: 180, height: 54)
        case .medium:
            return ButtonDimension(width: 100, height: 48)
        case .small:
            return ButtonDimension(width: 65, height: 30)
        case .smallMedium:
            return ButtonDimension(width: 75, height: 30)
        }
    }
}

class ITButton: NKButton {
    var buttonTitle: String
    var background: ButtonBackground
    var size: ButtonSize
    
    init(title: String, background: ButtonBackground, size: ButtonSize) {
        self.buttonTitle = title
        self.background = background
        self.size = size
        
        super.init()
        
        makeTitle()
        makeShadowAndRadius()
        makeColors()
        makeConstraints(width: size.size.width, height: size.size.height)
    }
    
    func makeTitle() {
        self.setTitle(buttonTitle, for: .normal)
        switch size {
        case .big:
            self.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        case .medium:
            self.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        case .small:
            self.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        case .smallMedium:
            self.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        }
    }
    
    func makeShadowAndRadius() {
        self.setShadowColor(.black, for: .normal) // set shadow color for normal state
        self.setShadowColor(.black, for: .highlighted) // set shadow color for highlight state
        self.shadowOffset = CGSize(width: 0, height: 0)
        self.shadowOpacity = 0.25
        self.shadowRadius = 6
        self.cornerRadius = 12.0
    }
    
    func makeColors() {
        var colors: [UIColor] = []
        switch background {
        case .green:
            colors = [UIColor(named: "button_green_start")!,
                      UIColor(named: "button_green_end")!]
        case .blue:
            colors = [UIColor(named: "button_blue_start")!,
                      UIColor(named: "button_blue_end")!]
        case .red:
            colors = [.systemPink, .red]
        }
        self.setGradientColor(colors, for: .normal) // set gradient color for normal state
        self.setGradientColor(colors.map { $0.withAlphaComponent(0.6) }, for: .highlighted) // set gradient color for highlight state
    }
        
    func makeConstraints(width: CGFloat, height: CGFloat) {
        self.snp.makeConstraints { make in
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    
}
