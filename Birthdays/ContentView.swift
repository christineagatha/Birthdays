//
//  ContentView.swift
//  Birthdays
//
//  Created by christine j on 4/27/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var friends: [Friend]
    @Environment(\.modelContext) private var modelContext
    @State private var newName = ""
    @State private var newBirthday = Date.now
    
    var body: some View {
        NavigationStack {
            List(friends) { friend in
                HStack {
                    Text(friend.name)
                    Text(friend.birthday,format: .dateTime.month(.wide).day().year())
                }
            }
            .navigationTitle("Birthdays")
            .safeAreaInset(edge: .bottom) {
                VStack(spacing: 5) {
                    Text("New Birthday")
                    DatePicker(selection: $newBirthday) {
                        TextField("Name", text: $newName)
                    }
                    Button("Save") {
                        let newFriend = Friend(name: newName, birthday: newBirthday)
                        modelContext.insert(newFriend)
                        newName = ""
                        newBirthday = .now
                    }
                }
                .padding()
                .background(.gray.opacity(0.3))
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Friend.self, inMemory: true)
}
