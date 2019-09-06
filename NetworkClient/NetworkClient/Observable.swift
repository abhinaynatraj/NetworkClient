//
//  Observable.swift
//  NetworkClient
//
//  Created by Abhiney Natarajan on 9/6/19.
//  Copyright © 2019 Abhiney Natarajan. All rights reserved.
//

import Foundation

// https://colindrake.me/post/an-observable-pattern-implementation-in-swift/

final class ObservationDispose {
    private var dispose: (ObjectIdentifier) -> ()

    fileprivate init(_ dispose: @escaping (ObjectIdentifier) -> ()) {
        self.dispose = dispose
    }

    deinit {
        dispose(ObjectIdentifier(self))
    }
}

protocol ObservableType {
    associatedtype Value
    var value: Value { get set }
    func subscribe(fireNow: Bool, _ block: @escaping (Value) -> ()) -> ObservationDispose
}

final class Observable<Value>: ObservableType {
    typealias ObserverBlock = (Value) -> ()

    private typealias ObserversEntry = (observationId: ObjectIdentifier, block: ObserverBlock)
    private var observers: [ObserversEntry]

    var value: Value {
        didSet {
            observers.forEach { (entry: ObserversEntry) in
                let (_, block) = entry
                block(value)
            }
        }
    }

    init(_ value: Value) {
        self.value = value
        observers = []
    }

    func subscribe(fireNow: Bool = false, _ block: @escaping ObserverBlock) -> ObservationDispose {
        let observationDispose = ObservationDispose { [weak self] (observationId) in
            self?.unsubscribe(observationId: observationId)
        }
        let observationId = ObjectIdentifier(observationDispose)
        let entry: ObserversEntry = (observationId: observationId, block: block)
        observers.append(entry)
        if fireNow {
            block(value)
        }
        return observationDispose
    }

    func bind<Value, Target>(to target: Target, at targetKeyPath: ReferenceWritableKeyPath<Target, Value>) -> ObservationDispose {
        return subscribe(fireNow: true) {
            target[keyPath: targetKeyPath] = $0 as! Value
        }
    }

    private func unsubscribe(observationId: ObjectIdentifier) {
        let filtered = observers.filter { entry in
            let (owner, _) = entry
            return owner != observationId
        }

        observers = filtered
    }
}
