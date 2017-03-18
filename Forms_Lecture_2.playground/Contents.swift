//: Playground - noun: a place where people can play

import UIKit

class Airplane {

}

//protocol AirportObserver {
//    func airportScheduleDidChange(with planes: [Airplane])
//    func airportDidAcceptPlane(plane: Airplane)
//}
//
//class Airport {
//    private(set) var airplanes: [Airplane] = []
//    var observer: AirportObserver?
//
//    func accept(plane: Airplane) {
//        airplanes.append(plane)
//        observer?.airportDidAcceptPlane(plane: plane)
//        observer?.airportScheduleDidChange(with: airplanes)
//    }
//
//    func release() {
//        airplanes.removeLast()
//        observer?.airportScheduleDidChange(with: airplanes)
//    }
//}

//class Airport {
//    private(set) var airplanes: [Airplane] = []
//    var airplanesDidChange: (([Airplane]) -> Void)?
//    var airplaneDidLand: ((Airplane) -> Void)?
//
//    func accept(plane: Airplane) {
//        airplanes.append(plane)
//        airplaneDidLand?(plane)
//        airplanesDidChange?(airplanes)
//    }
//
//    func release() {
//        airplanes.removeLast()
//        airplanesDidChange?(airplanes)
//    }
//}

class Pipe<T> {
    var observers: [((T) -> Void)] = []

    func sendNext(_ value: T) {
        observers.forEach { $0(value) }
    }

    func onNext(_ observer: @escaping ((T) -> Void)) {
        observers.append(observer)
    }
}

class Observable<T>: Pipe<T> {
    var value: T {
        didSet {
            observers.forEach { $0(value) }
        }
    }

    override func sendNext(_ value: T) {
        self.value = value
    }

    init(_ value: T) {
        self.value = value
    }
}

class Airport {
    private(set) var airplanes = Observable<[Airplane]>([])
    var airplaneDidLand = Pipe<Airplane>()

    func accept(plane: Airplane) {
        var airplanes = self.airplanes.value
        airplanes.append(plane)
        self.airplanes.value = airplanes
        airplaneDidLand.sendNext(plane)
    }

    func release() {
        var airplanes = self.airplanes.value
        airplanes.removeLast()
        self.airplanes.value = airplanes
    }
}

extension Pipe {

    func map<U>(_ mapper: @escaping (T) -> U) -> Pipe<U> {
        let pipe = Pipe<U>() //- труба для груш

        self.onNext { // подпись на трубу яблок
            pipe.sendNext(mapper($0)) // преобразование яблок в груши и отправка в трубу груш
        }

        return pipe // отдаем трубу груш
    }

}

let airport = Airport()
//airport.airplaneDidLand.onNext { (value) in
//    print("Plane landed")
//}
airport.airplanes.map { $0.count }.map { $0 > 1 }.onNext { value in
    print(value)
}
//airport.airplanes.onNext { value in
//    print(value.count)
//}
airport.accept(plane: Airplane())
airport.accept(plane: Airplane())
airport.accept(plane: Airplane())
airport.release()
airport.release()

