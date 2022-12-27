//
//  ContentView.swift
//  WordsGame
//
//  Created by Yusup Aliskantiev on 15.12.2022.
//

import SwiftUI

struct StartView: View {
    
    @State var bigWord: String = ""
    @State var player1: String = ""
    @State var player2: String = ""
    @State var isShowGame = false
    @State var isAlertPresent = false
    var body: some View {
        
        VStack{
            TitleText(text: "WordsGame")
            
            WordTextField(word: $bigWord, placeHolder: "Введите длинное слово")
                .padding(20)
                .shadow(color: .black, radius: 5)
            
            WordTextField(word: $player1, placeHolder: "Игрок 1")
                .cornerRadius(12)
                .padding(.horizontal, 20)
                .shadow(color: .black, radius: 5)
            
            
            WordTextField(word: $player2, placeHolder: "Игрок 2")
                .cornerRadius(12)
                .padding(.horizontal, 20)
                .shadow(color: .black, radius: 5)
        
            Button {
                
                if bigWord.count > 7 {
                    isShowGame.toggle()
                } else {
                    self.isAlertPresent.toggle()
                }
                
               
            } label: {
                Text("Srart ")
                
                    .font(.custom("AvenirNext-Bold", size: 30))
                    .foregroundColor(.white)
                    .padding(6)
                    .padding(.horizontal, 64)
                    .background(Color("FirstPlayer"))
                    .cornerRadius(100)
                    .padding(.top)
            }
            
        }    .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        
        .background(Image("Fon"))
        .alert("Длинное слово слишком короткое", isPresented: $isAlertPresent, actions: {
            Text("OK")
           
        })
        .fullScreenCover(isPresented: $isShowGame) {
            
            let name1 = player1 == "" ? "Игрок 1" : player1
            let name2 = player2 == "" ? "Игрок 2" : player2
            
            let player1 = Player(name: name1)
            let player2 = Player(name: name2)
            
            let gameViewModel = GameViewModel(player1: player1, player2: player2, word: bigWord)
            
            GameView(viewModel: gameViewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
