//
//  ContentView.swift
//  iCreate - Flash Cards
//
//  Created by Mark Henrich on 12/22/19.
//  Copyright © 2019 Mark Henrich. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: FlashCard.entity(), sortDescriptors: []) var flashCards: FetchedResults<FlashCard>
    
    @State private var showingAddView = false
    let colors: [Color] = [.blue, .green, .yellow, .red, .gray]
    
    var body: some View {
        NavigationView {
            Form {

                Section {
                    List {
                        ForEach(flashCards, id: \.self) { flashCard in
                            CardView(text: flashCard.frontShowing ? flashCard.wrappedQuestion : flashCard.wrappedAnswer, color: self.colors[Int(flashCard.color)])
                                .environment(\.managedObjectContext, self.moc)
                                .onTapGesture {
                                    flashCard.frontShowing.toggle()
                            }
                        }    
                        .onDelete(perform: delete)
                    
                        Section {
                            HStack {
                                Spacer()
                                Button(action: {
                                    self.showingAddView.toggle()
                                }) {
                                    Text("New Card")
                                }
                                Spacer()
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Flash Cards")
            .navigationBarItems(trailing: HStack {
                EditButton()
                
                Button (action: {
                    self.showingAddView = true
                }) {
                    Image(systemName: "plus")
                }
                .padding(5)
            })
            .sheet(isPresented: $showingAddView) {
                CreateCardView().environment(\.managedObjectContext, self.moc)
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        for offset in offsets {
            let flashCard = flashCards[offset]
            
            moc.delete(flashCard)
        }
        
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
