//
//  LocalState.swift
//  BankingClient
//
//  Created by Omar Khayyam on 2022-07-31.
//

import Foundation

class LocalState {
    private enum Keys: String {
        case hasOnboarded
    }

    public static var hasOnboarded: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.hasOnboarded.rawValue)
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.hasOnboarded.rawValue)
        }
    }
}
