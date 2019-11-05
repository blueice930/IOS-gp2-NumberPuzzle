//
//  MainView.swift
//  NumberPuzzle
//
//  Created by Ronnie Li on 10/29/19.
//  Copyright © 2019 Ronnie Li. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @State var mode = "picture"
    @State var level = 3
    @State var offset1 = CGSize.init(width: -480, height: 0)
    @State var offset2 = CGSize.init(width: -490, height: 0)
    
    var body: some View {
        
        NavigationView {
            ZStack{
                Color.pink
                Rectangle()
                    .foregroundColor(Color.yellow)
                    .frame(width: 600)
                    .offset(x: self.offset1.width)
                    .onTapGesture(perform: {withAnimation(.spring()){
                        self.offset1 = self.offset1 == CGSize.init(width: -480, height: 0) ? CGSize.init(width: 50, height: 0) : CGSize.init(width: -480, height: 0)
                        }})
                Rectangle()
                    .foregroundColor(Color.blue)
                    .frame(width: 600)
                    .offset(x: self.offset2.width)
                    .onTapGesture(perform: {withAnimation(.spring()){
                        self.offset2 = self.offset2 == CGSize.init(width: -490, height: 0) ? CGSize.init(width: 50, height: 0) : CGSize.init(width: -490, height: 0)
                        
                        }})
                VStack(spacing: 10) {
                    Image("puzzle")
                        .resizable()
                        .frame(width: 350, height: 220)
                        .cornerRadius(14)
                        .shadow(radius: 2)
                        .padding(.bottom, 20)
                    NavigationLink(destination: PuzzleView(mode: self.$mode, level: self.$level, grid: randomize(level: self.level))){
                        StyleButton(text: "Start")
                    }
                    NavigationLink(destination: SettingsView(level: self.$level, mode: self.$mode)){
                        StyleButton(text: "Settings")
                    }
                    NavigationLink(destination: HelpsView()){
                        StyleButton(text: "Helps")
                    }
                }
            }.navigationBarTitle(Text("Sliding Puzzle"))
        }.padding(.top)
    }
}



func getNums(level: Int) -> [Int] {
    var numsArray = [Int]()
    for i in 1 ... level*level {
        if i == level*level {
            numsArray.append(0)
        }else{
            numsArray.append(i)
        }
    }
    return numsArray
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(offset1: CGSize.init(width: 2, height: 0), offset2: CGSize.init(width: 2, height: 0))
    }
}
