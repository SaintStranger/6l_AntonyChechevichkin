//
//  main.swift
//  6l_AntonyChechevichkin
//
//  Created by Антон Чечевичкин on 12.09.2020.
//  Copyright © 2020 Антон Чечевичкин. All rights reserved.
//

import Foundation


//Реализовать очередь с использованием дженериков

protocol Mode {
    var electro: Bool {get set}
    var price: Int {get set}
}


class Guitar: Mode {
    var strings: Int
    var modelName: String
    var cover: Bool
    var electro: Bool
    var price: Int

    init(strings: Int, modelName: String, cover: Bool, electro: Bool, price: Int?) {
        self.strings = strings
        self.modelName = modelName
        self.cover = cover
        self.electro = electro
        self.price = price ?? 150
    }

}

class Piano: Mode {
    var keys: Int
    var modelName: String
    var stand: Bool
    var electro: Bool
    var price: Int

    init(keys: Int, modelName: String, stand: Bool, electro: Bool, price: Int?) {
        self.keys = keys
        self.modelName = modelName
        self.stand = stand
        self.electro = electro
        self.price = price ?? 50
    }
}

class Drums: Mode {
    var drum: Int
    var moderName: String
    var electro: Bool
    var price: Int

    init(drum: Int, modelName: String, electro: Bool, price: Int?) {
        self.drum = drum
        self.moderName = modelName
        self.electro = electro
        self.price = price ?? 100
    }
}

struct queue<T: Mode> {
    var instruments: [T] = []
    mutating func push(_ instrument: T) {
        instruments.append(instrument)
    }

    mutating func pop() -> T {
        return instruments.removeFirst()
    }
}


var gibson = Guitar(strings: 6, modelName: "LesPaul", cover: true, electro: true, price: 356)
var epiphone = Guitar(strings: 6, modelName: "Gmodel", cover: false, electro: true, price: 213)


var queueGuitars = queue<Guitar>()
queueGuitars.push(gibson)
queueGuitars.push(epiphone)
queueGuitars.push(Guitar(strings: 6, modelName: "Stratocaster", cover: true, electro: true, price: 345))
queueGuitars.push(Guitar(strings: 6, modelName: "Brahner", cover: false, electro: false, price: 17))
queueGuitars.pop()


print(queueGuitars.instruments[0].modelName)
print(queueGuitars.instruments[1].modelName)


var queuePiano = queue<Piano>()
queuePiano.push(Piano(keys: 88, modelName: "Casio", stand: false, electro: true, price: nil))

var queueDrums = queue<Drums>()
queueDrums.push(Drums(drum: 12, modelName: "Roland", electro: true, price: nil))

print(queueDrums.instruments[0].price)


//Добавить методы высшего порядка


func acousticOnlyFilter (array: Array<Any>, predicate: (Guitar) -> Bool) -> [Any] {
    var tempArray: [Any] = []
    for item in array {
        if predicate (item as! Guitar) {
            tempArray.append(item)
        }
    }

    return tempArray
}

acousticOnlyFilter(array: queueGuitars.instruments, predicate: { (Guitar) -> Bool in return Guitar.electro == true})

//То же самое из библиотеки

queueGuitars.instruments.filter({$0.electro == true})




//Добавить свой subscript


struct queueSub<T: Mode> {
    var instruments: [T] = []
    mutating func push(_ instrument: T) {
        instruments.append(instrument)
    }
    
    mutating func pop() -> T {
        return instruments.removeFirst()
    }
    
    subscript(index: Int) -> Int? {
        var price = 0
  
        guard index >= 0, index < self.instruments.count else  {
            print("Такого объекта не существует")
            return nil
        }
        price += self.instruments[Int(index)].price
        print("Цена за инструмент составит \(price)")
        return price
        
    }
    
}


var secondQueueGuitars = queueSub<Guitar>()
secondQueueGuitars.push(gibson)
secondQueueGuitars.push(epiphone)
secondQueueGuitars.push(Guitar(strings: 6, modelName: "Stratocaster", cover: true, electro: true, price: 345))
secondQueueGuitars.push(Guitar(strings: 6, modelName: "Brahner", cover: false, electro: false, price: 17))


secondQueueGuitars[2]

secondQueueGuitars[12]
