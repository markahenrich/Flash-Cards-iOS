//
//  CreateCardView.swift
//  iCreate - Flash Cards
//
//  Created by Mark Henrich on 12/26/19.
//  Copyright © 2019 Mark Henrich. All rights reserved.
//

import SwiftUI
import CoreData

struct CreateCardView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var question = ""
    @State private var answer = ""
    private var colors = ["Blue", "Green", "Yellow", "Red", "Gray"]
    private var buttonColors = [Color.blue, Color.green, Color.yellow, Color.red, Color.gray]
    @State private var returnedColors = 0
    
    
    var body: some View {
        ZStack {
            VStack {
                Text("Create Your Flash Card")
                    .font(.headline)
                    .foregroundColor(.white)
                HStack {
                    Text("Q: ")
                    TextField("\(self.question)", text: $question)
                        .padding()
                        .background(buttonColors[returnedColors])
                        .foregroundColor(Color.white)
                        .cornerRadius(25)
                }
                HStack {
                    Text("A: ")
                    TextField("\(self.answer)", text: $answer)
                        .padding()
                        .background(buttonColors[returnedColors])
                        .foregroundColor(Color.white)
                        .cornerRadius(25)
                }
                Picker(selection: $returnedColors, label: Text("Color")
                    .font(.headline)
                    .foregroundColor(.white)
                
                ) {
                    ForEach(0..<5) {
                        Text(self.colors[$0])
                    }
                }
                .padding()
                .pickerStyle(SegmentedPickerStyle())
                
                Button(action: {
                    if self.question == "" && self.answer == "" {
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        let card = FlashCard(context: self.moc)
                        card.question = self.question
                        card.answer = self.answer
                        card.frontShowing = true
                        card.color = Int16(self.returnedColors)
                        
                        try? self.moc.save()
                        
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    
                }) {
                    Text("Save")
                        .padding(20)
                        .background(buttonColors[returnedColors])
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(Color.black, lineWidth: 0.5))
                        .shadow(color: .black, radius: 2)
                }
            }
            .padding()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct CreateCardView_Previews: PreviewProvider {
    static var previews: some View {
        CreateCardView()
    }
}
