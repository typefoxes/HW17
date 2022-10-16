
/*
 Одиночка — это порождающий паттерн, который гарантирует существование только одного объекта определённого класса, а также позволяет достучаться до этого объекта из любого места программы.
 */

final class Singleton {
    private let bankcard: String?
    private let bitcoin: String?
    
    static let sharedInstance: Singleton = {
        let instance = Singleton()
        return instance
    }()

    private init() {
        self.bankcard = "1111222233334444"
        self.bitcoin = "1q2w3e4r5t6y7u8i9o0p"
    }

    internal func getCardNumber() -> String { "Bankcard: \(self.bankcard ?? "not specified")" }
    internal func getBitcoin() -> String { "Bitcoin: \(self.bitcoin ?? "not specified")" }
}

class Client {
    static func paymentMethod() {
        let bankcard = Singleton.sharedInstance
        let bitcoin = Singleton.sharedInstance
        
        if bankcard === bitcoin {
            print("Singleton работает, объекты ссылаются на один и тот же экземпляр класса")
            
            print("\nРеквизиты принадлежат одному и тому же человеку")
            print(bankcard.getCardNumber())
            print(bitcoin.getBitcoin())
        } else {
            fatalError("Singleton НЕ работает, объекты ссылаются на разные классы")
        }
    }
}

class PaymentSystem {
    func paymentMethod() { Client.paymentMethod() }
}

let test = PaymentSystem()
test.paymentMethod()
