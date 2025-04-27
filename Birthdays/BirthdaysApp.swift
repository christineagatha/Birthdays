//
//  BirthdaysApp.swift
//  Birthdays
//
//  Created by christine j on 4/27/25.
//

import SwiftUI
import SwiftData

@main
struct BirthdaysApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Friend.self)
        }
    }
}
