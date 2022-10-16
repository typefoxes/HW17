
/*
 Абстрактная фабрика — это порождающий паттерн проектирования, который решает проблему создания целых семейств связанных продуктов, без указания конкретных классов продуктов.
 
 Абстрактная фабрика задаёт интерфейс создания всех доступных типов продуктов, а каждая конкретная реализация фабрики порождает продукты одной из вариаций. Клиентский код вызывает методы фабрики для получения продуктов, вместо самостоятельного создания с помощью оператора new. При этом фабрика сама следит за тем, чтобы создать продукт нужной вариации.

 */

protocol AbstractFactory {
    func getMoney() -> Money
    func getCrypto() -> Crypto
}

class ConcreteFactory1: AbstractFactory {
    func getMoney() -> Money { RUR() }
    func getCrypto() -> Crypto { Bitcoin() }
}
class ConcreteFactory2 : AbstractFactory {
    func getMoney() -> Money { USD() }
    func getCrypto() -> Crypto { Ethereum() }
}


protocol Money { func exchange(to: Crypto) }
protocol Crypto { func exchange(to: Money) }


class RUR: Money {
    func exchange(to: Crypto) {
        print("\(type(of: self)) exchange for \(type(of: to.self))")
    }
}
class USD: Money {
    func exchange(to: Crypto) {
        print("\(type(of: self)) exchange for \(type(of: to.self))")
    }
}
class Bitcoin: Crypto {
    func exchange(to: Money) {
        print("\(type(of: self)) exchange for \(type(of: to.self))")
    }
    
}
class Ethereum: Crypto {
    func exchange(to: Money) {
        print("\(type(of: self)) exchange for \(type(of: to.self))")
    }
}

class Client {
    private let money: Money
    private let crypto: Crypto

    init(factory: AbstractFactory) {
        self.money = factory.getMoney()
        self.crypto = factory.getCrypto()
    }
    
    func getCrypto() { money.exchange(to: crypto) }
    func getMoney() { crypto.exchange(to: money) }
}

let factory1 = ConcreteFactory1()
let client1 = Client(factory: factory1)
client1.getCrypto()
client1.getMoney()

let factory2 = ConcreteFactory2()
let client2 = Client(factory: factory2)
client2.getMoney()
