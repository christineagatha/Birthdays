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
    @State private var selectedFriend: Friend?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(friends) { friend in
                    HStack {
                        HStack {
                            Text(friend.name)
                            Spacer()
                            Text(friend.birthday,format: .dateTime.month(.wide).day().year())
                        }
                        .onTapGesture {
                            selectedFriend = friend
                        }
                    }
                }
                .onDelete(perform: deleteFriend)
            }
            .navigationTitle("Birthdays")
            .sheet(item: $selectedFriend) { friend in
                NavigationStack {
                    EditFriendView(friend: friend)
                }
            }
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
    func deleteFriend(at offsets: IndexSet) {
        for index in offsets {
            let friendToDelete = friends[index]
            modelContext.delete(friendToDelete)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Friend.self, inMemory: true)
}
