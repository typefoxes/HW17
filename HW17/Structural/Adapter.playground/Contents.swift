
/*
 Адаптер — это структурный паттерн, который позволяет подружить несовместимые объекты.
 Адаптер выступает прослойкой между двумя объектами, превращая вызовы одного в вызовы понятные другому.
 */

import Foundation

class Target {
    internal var dateFormat = "dd.MM.YYYY HH:mm"
    
    func request() -> String {
        return "Target: предлагаю работать с типом \(dateFormat)"
    }
}

class Adaptee {
    func specificRequest() -> Int {
        return Int(Date().timeIntervalSince1970)
    }
}

class Adapter: Target {
    
    private var adaptee: Adaptee
    
    init(_ adaptee: Adaptee) {
        self.adaptee = adaptee
    }
    
    override func request() -> String {

        let date = Date(timeIntervalSince1970: TimeInterval(self.adaptee.specificRequest()))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = NSLocale.autoupdatingCurrent
        dateFormatter.dateFormat = self.dateFormat
        let stringDate = dateFormatter.string(from: date)
        return stringDate
    }
}

class Client {
    internal static func execute(target: Target) {
        print(target.request())
    }
}

class AdapterConceptual {
    func testAdapterConceptual() {
        print("Client: получены данные с датой! Обращаемся к Target за инструкцией!")
        Client.execute(target: Target())
        
        let adaptee = Adaptee()
        print("Client: у Adaptee странный формат, не могу применить инструкцию")
        print("Adaptee: " + adaptee.specificRequest().description)
        
        print("Client: попробую применить Adapter:")
        Client.execute(target: Adapter(adaptee))
    }
}

let test = AdapterConceptual()
_ = test.testAdapterConceptual()
