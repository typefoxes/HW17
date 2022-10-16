
/*
 Стратегия — это поведенческий паттерн, выносит набор алгоритмов в собственные классы и делает их взаимозаменимыми.
 Другие объекты содержат ссылку на объект-стратегию и делегируют ей работу. Программа может подменить этот объект другим, если требуется иной способ решения задачи.
 
 Паттерн Стратегия определяет набор алгоритмов, инкапсулируя каждый из них и обеспечивая их взаимозаменяемость.
 В зависимости от ситуации можно заменить один используемый алгоритм другим и это произойдет независимо от объекта, который использует данный алгоритм.
 Например, когда есть несколько родственных классов, которые отличаются поведением. Можно задать один основной класс, а разные варианты поведения вынести в отдельные классы и применять их при необходимости.
 */
import Foundation

class GameObject: CombatBehavior {
    func attack(targets: [GameObject]) {
        print("\(type(of: self)) атакует \(targets.map{$0})")
    }
    init() { }
}

extension GameObject: CustomStringConvertible { var description: String { "\(type(of: self))" } }

protocol Mode { func details(object: GameObject) }
class Dynamic: Mode { func details(object: GameObject) { print("\(object) -> динамичный") } }
class Static: Mode { func details(object: GameObject) { print("\(object) – статичный") } }

protocol CombatBehavior { func attack(targets: [GameObject]) }


protocol Weapon { func name() -> String }
class Blaster: Weapon { func name() -> String { "\(type(of: self))" } }
class Bazooka: Weapon { func name() -> String { "\(type(of: self))" } }

final class NPC: GameObject {
    public private(set) var behavior: CombatBehavior!
    public private(set) var mode: Mode!
    public private(set) var weapon: Weapon!
    
    func setWeapon(weapon: Weapon) {
        self.weapon = weapon
        print("\(type(of: self)) владеет: \(self.weapon.name())")
    }

    private var motileProperty: Bool? = false {
        didSet {
            if motileProperty != oldValue {
                self.setMotileProperty(mode: Dynamic())
            } else {
                self.setMotileProperty(mode: Static())
            }
        }
    }
    
    private func setMotileProperty(mode: Mode) {
        self.mode = mode
        self.mode.details(object: self)
    }
    private func workaround(motile: Bool) {
        self.motileProperty = motile
    }
    init(motile: Bool) {
        super.init()
        print("NPC создан!")
        self.workaround(motile: motile)
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) не был реализован")
    }
}

final class Player: GameObject {
    public private(set) var mode: Mode! = Dynamic()
    public private(set) var weapon: Weapon!
    
    func setWeapon(weapon: Weapon) {
        self.weapon = weapon
        print("\(type(of: self)) владеет: \(self.weapon.name())")
    }
    
    override init() {
        super.init()
        print("\(type(of: self)) создан!")
        self.mode.details(object: self) 
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) не был реализован")
    }
}


let player = Player()
player.setWeapon(weapon: Blaster())

print()
let npc = NPC(motile: true)
npc.setWeapon(weapon: Bazooka())

print()
player.attack(targets: [npc])
npc.attack(targets: [player])
player.attack(targets: [npc])

print()
player.setWeapon(weapon: Bazooka())
