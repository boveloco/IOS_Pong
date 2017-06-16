//
//  Menu.swift
//

import SpriteKit

class Menu : SKScene {
    
    let menu01 : SKLabelNode
    let menu02 : SKLabelNode
    
    override init(size: CGSize) {
        
        menu01 = SKLabelNode(fontNamed:"Chalkduster")
        menu02 = SKLabelNode(fontNamed:"Chalkduster")
        
        super.init(size: size)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        view.backgroundColor = UIColor.black
        
        menu01.text = "IOS PONG"
        menu01.fontColor = SKColor.white
        menu01.fontSize  = 70
        menu01.position = CGPoint(x: self.frame.midX, y: self.size.height * 0.7)
        self.addChild(menu01)
        
        menu02.text = "Touch to play"
        menu02.fontColor = SKColor.white
        menu02.fontSize  = 70
        menu02.position = CGPoint(x: self.frame.midX, y: self.size.height * 0.3)
        self.addChild(menu02)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let novaCena = GameScene(size:self.size)
        novaCena.scaleMode = scaleMode
        let reveal = SKTransition.crossFade(withDuration: 1.5)
        self.view?.presentScene(novaCena, transition: reveal)
    }
}
