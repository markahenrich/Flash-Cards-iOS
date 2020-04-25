//
//  CardView.swift
//  iCreate - Flash Cards
//
//  Created by Mark Henrich on 12/22/19.
//  Copyright © 2019 Mark Henrich. All rights reserved.
//

import SwiftUI

struct CardView: View {
    var text: String
    var color: Color
    
    private let colors: [Color] = [.blue, .red, .green, .yellow, .gray]
   
    var body: some View {
        
        Text(text)
            .frame(width: 300, height: 200)
            .background(color)
            .foregroundColor(.white)
            .font(.title)
            .cornerRadius(25)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(text: "Hello", color: .blue)
    }
}
