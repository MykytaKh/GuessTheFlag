//
//  ContentView.swift
//  GuessFlag
//
//  Created by Никита Хламов on 11.10.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Poland", "Germany", "Italy", "Moldova", "Greece", "Hungary", "Portugal", "Spain", "France", "Turkey"].shuffled()  //".shuffled()" - потому что будем перемешивать строки внутри массива.
    @State private var correctAnswer = Int.random(in: 0...2) //"0...2" - потому что у нас 3 варианта ответа.
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.black, .gray, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all) //Это чтобы игнирировать safearea и залить всю площать, через "(.)" выбираем какую именно часть
            VStack {
                VStack {
                    Text("Сhoose the flag of ")
                        .foregroundColor(.white)
                        .font(.headline)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black) //жирность букв
                }
                
                ForEach(0..<3) { number in
                    Button(action: {
                        self.flagTapped(number) //при нажатии кнопки срабатывает фун-я "flagTapped".
                        self.showingScore = true //при нажатии кнопки, "showingScore" становится "true", а в таком случае срабатывает "alert" (от изменения значения).
                    }) {
                        Image(self.countries[number])
                            .resizable() //уменьшили
                            .frame(width: 300, height: 170)
                        // .renderingMode(.original) - чтобы отображалось оригинальное изображение, если отображаются синие кнопки.
                            .shadow(color: .black, radius: 10, x: 13, y: 13) //тень
                    }
                }
                Text("Total Score: \(score)")
                    .font(.headline)
                    .fontWeight(.black)
                    .padding()
            }
        } .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Total Score: \(score)"), dismissButton: .default(Text("Next")) {
                self.askQuestion() //задали что будет происходить после нажатия кнопки продолжить (срабатывает фук-я "askQuestion").
            })
        }
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "You are right!"
            score += 1
        } else {
            scoreTitle = "You are wrong! This is the flag of \(countries[number])"
            score -= 1
        }
    }
}



































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
