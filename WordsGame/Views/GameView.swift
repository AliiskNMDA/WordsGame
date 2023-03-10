//
//  GameView.swift
//  WordsGame
//
//  Created by Yusup Aliskantiev on 15.12.2022.
//

import SwiftUI

struct GameView: View {
    
    @State private var word = ""
    var viewModel: GameViewModel
    @State private var confirmPresent = false
    @State private var isAlertPresent = false
    @State  var alertText = ""
    @State private var listOpacity = 0.0
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Button {
                    confirmPresent.toggle()
                    
                } label: {
                    Text("Выход")
                        .padding(6)
                        .padding(.horizontal, 16)
                        .background(Color("Orange"))
                        .cornerRadius(12)
                        .padding(6)
                        .foregroundColor(.white)
                        .font(.custom("AvenirNext-Bold", size: 18))
                    
                }
                Spacer()
            }
            
            
            Text(viewModel.word)
                .font(.custom("AvenirNext-Bold", size: 36))
                .foregroundColor(.white)
            HStack(spacing: 12){
                VStack{
                    Text("\(viewModel.player1.score)")
                        .font(.custom("AvenirNext-Bold", size: 60))
                        .foregroundColor(.white)
                    
                    Text("\(viewModel.player1.name)")
                        .font(.custom("AvenirNext-Bold", size: 24))
                        .foregroundColor(.white)
                }
                .padding(20)
                .frame(width: screen.width / 2.2 , height: screen.width / 2.2)
                .background(Color("FirstPlayer"))
                .cornerRadius(26)
                .shadow(color: viewModel.isFirst ? .red : .clear, radius: 15, x: 0, y: 0)
                
                VStack{
                    Text("\(viewModel.player2.score)")
                        .font(.custom("AvenirNext-Bold", size: 60))
                        .foregroundColor(.white)
                    
                    Text("\(viewModel.player2.name)")
                        .font(.custom("AvenirNext-Bold", size: 24))
                        .foregroundColor(.white)
                }
                .padding(20)
                .frame(width: screen.width / 2.2 ,
                       height: screen.width / 2.2)
                .background(Color("SecondPlayer"))
                .cornerRadius(26)
                .shadow(color:  viewModel.isFirst ? .clear : .purple,
                        radius: 15, x: 0, y: 0)
            }
            
            WordTextField(word: $word, placeHolder: "Вашe слово")
                .padding(.horizontal)
                .shadow(color: .black, radius: 5)
            
            Button {
                var score = 0
                
                do {
                    try score = viewModel.check(word: word)
                    self.listOpacity  = 1.0
                } catch WordError.beforeWord {
                    alertText = "Прояви фантазию, придумай новое слово"
                    isAlertPresent.toggle()
                }  catch WordError.littleWord {
                    alertText = "Слишком короткое слово"
                    isAlertPresent.toggle()
                }  catch WordError.theSameWord {
                    alertText = "Думаешь самый умный? Составленное слово не должно быть исходным!"
                    isAlertPresent.toggle()
                }  catch WordError.wrongWord {
                    alertText = "Такое слово не может быть составлено"
                    isAlertPresent.toggle()
                }  catch {
                    alertText = "Неизвестная ошибка"
                    isAlertPresent.toggle()
                }
                
                if score > 1 {
                    self.word = ""
                }
                
            } label: {
                Text("Готово!")
                    .padding(12)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color("Orange"))
                    .cornerRadius(16)
                    .font(.custom("AvenirNext-Bold", size: 26))
                    .padding(.horizontal)
                
            }
            if !viewModel.words.isEmpty {
                List {
                    
                    ForEach(0 ..< self.viewModel.words.count, id: \.description) { item in
                        WordCell(word: self.viewModel.words[item])
                            .listRowBackground(Color("Fon"))
                            .background(item % 2 == 0 ? Color("FirstPlayer") : Color("SecondPlayer"))
                            .listRowInsets(EdgeInsets())
                            .cornerRadius(16)
                    }
                }
                .padding()
                .listStyle(.plain)
            }
          Spacer()
        }.background(Image("Fon"))
        
            .confirmationDialog("Вы уверены, что хотите завершить игру?",
                                isPresented: $confirmPresent,
                                titleVisibility: .visible) {
                Button(role: .destructive) {
                    self.dismiss()
                } label: {
                    Text("Да")
                }
                
                Button(role: .cancel) { } label: {
                    Text("Нет")
                }
                
            }.alert(alertText,
                    isPresented: $isAlertPresent){
                Text("ok")
            }
        
                    .onTapGesture {
                        UIApplication.shared.sendAction(
                            #selector(UIResponder.resignFirstResponder),
                            to: nil,
                            from: nil,
                            for: nil)
                        
                    }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(player1: Player(name: "Вася"),
                                          player2: Player(name: "Петя"),
                                          word: "zzzzzzzzz"))
    }
}
