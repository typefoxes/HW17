
/*
 Строитель — это порождающий паттерн проектирования, который позволяет создавать объекты пошагово.
 В отличие от других порождающих паттернов, Строитель позволяет производить различные продукты, используя один и тот же процесс строительства.
 */
class Substance {
    var carbon = 0
    var hydrogen = 0
    var nitricOxide = 0
}

protocol SubstanceBuilder {
    func carbon(_ amount: Int)
    func hydrogen(_ amount: Int)
    func nitricOxide(_ amount: Int)
}

class Catecholamine: SubstanceBuilder {
    let element: Substance
    
    init(formula: Substance) { self.element = formula }
    
    func carbon(_ amount: Int) { element.carbon = amount }
    func hydrogen(_ amount: Int) { element.hydrogen = amount }
    func nitricOxide(_ amount: Int) { element.nitricOxide = amount }
}

class Director {

    func dopamine(builder: SubstanceBuilder) -> Substance {
        let builder = Catecholamine(formula: Substance())
        builder.carbon(8)
        builder.hydrogen(11)
        builder.nitricOxide(2)
        print("C8H11NO2 – Dopamine")
        return builder.element
    }

    func norepinephrine(builder: SubstanceBuilder) -> Substance {
        let builder = Catecholamine(formula: Substance())
        builder.carbon(8)
        builder.hydrogen(11)
        builder.nitricOxide(3)
        print("C8H11NO3 – Norepinephrine")
        return builder.element
    }
    func adrenaline(builder: SubstanceBuilder) -> Substance {
        let builder = Catecholamine(formula: Substance())
        builder.carbon(9)
        builder.hydrogen(13)
        builder.nitricOxide(3)
        print("C9H13NO3 – Adrenaline")
        return builder.element
    }
}

print(Director().dopamine(builder: Catecholamine(formula: Substance())))
