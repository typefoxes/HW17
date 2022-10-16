
/*
 Заместитель — это объект, который выступает прослойкой между клиентом и реальным сервисным объектом. Заместитель получает вызовы от клиента, выполняет свою функцию (контроль доступа, кеширование, изменение запроса и прочее), а затем передаёт вызов сервисному объекту. Заместитель имеет тот же интерфейс, что и реальный объект, поэтому для клиента нет разницы — работать через заместителя или напрямую.
 */
import Foundation

protocol SOCKS {
    func request(from: String, site: String)
}

class Object: SOCKS {
    func request(from: String, site: String) {
        print("\(site): поступил запрос от \(from)")
    }
}

class Proxy: SOCKS {
    var object: Object?
    internal var ip: String = "5.1.4.9"
    
    func request(from: String, site: String) {
        print("\(type(of: self)): \(from) хочет открыть \(site)")
        if (object == nil) {
            object = Object()
        }
        print("\(type(of: self)): обращаюсь к \(site) от имени \(self.ip)")
        object?.request(from: self.ip, site: site)
    }
}

class Client {
    internal var ip: String = "1.2.3.4"
    
    func test() {
        let proxy: SOCKS = Proxy()
        let url: String = "Google"
        print("\(type(of: self)): открываю \(url) с помощью \(type(of: proxy))")
        proxy.request(from: self.ip, site: url)
    }
}

let client = Client()
client.test()
