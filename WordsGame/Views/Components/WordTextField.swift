//
//  WordTextField.swift
//  WordsGame
//
//  Created by Yusup Aliskantiev on 15.12.2022.
//

import SwiftUI

struct WordTextField: View {
    @State var word: Binding<String>
    var placeHolder: String
    var body: some View {
        TextField(placeHolder, text: word)
            .font(.title2)
            .padding()
            .background(.green)
            .cornerRadius(12)
        
    }
}

