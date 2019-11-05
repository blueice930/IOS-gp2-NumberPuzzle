import SwiftUI
import Foundation

struct PuzzleView: View {
    @Binding var mode: String
    @Binding var level: Int
    @State var grid : [Int]
    @State var showSolution = false
    
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                if checkSuccess() {
                    Text("Congratulations!")
                        .foregroundColor(Color.black)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .shadow(radius: 3)
                }
                VStack(spacing: 0) {
                    ForEach(0..<self.level, id: \.self) { i in
                        HStack (spacing: 0){
                            ForEach(0..<self.level, id: \.self) { j in
                                Button(action: {
                                    withAnimation(.linear){
                                        self.move(index: i*self.level+j)
                                    }
                                }){
                                    if self.mode == "number"{
                                        Text("\(self.getNum(row: i, col: j, level: self.level))")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .frame(width: 45, height: 45)
                                            .foregroundColor(Color.white)
                                            .background(self.getColor(value: self.grid[i*self.level+j]))
                                            .cornerRadius(12)
                                            .shadow(radius: 2)
                                            .padding(1)
                                    }
                                    else if self.mode == "picture" {
                                        Image("l\(self.level)-\(self.getNum(row: i, col: j, level: self.level))")
                                            .renderingMode(.original)
                                            .resizable()
                                            .frame(width: self.level>=5 ? 50 : 90, height: self.level>=5 ? 50 : 90)
                                            .padding(2)
                                    }
                                }
                            }
                        }
                    }
                }.padding(.top, 1)
                
                HStack() {
                    Button(action: {self.newGame()}){
                        Text("New Game")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.yellow)
                            .shadow(radius: 2)
                    }.padding(5)
                    .background(RoundedRectangle(cornerRadius: 14).foregroundColor(Color.black.opacity(0.8)))
                    Spacer()
                    Button(action: {self.showSolution = true}){
                        Text("Get Hint")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.yellow)
                            .shadow(radius: 2)
                    }.padding(5)
                        .background(RoundedRectangle(cornerRadius: 14).foregroundColor(Color.black.opacity(0.8)))
                }.frame(width: 350)
                    .padding()
                Spacer()
                
            }
        }.navigationBarTitle(Text("Game"))
            .navigationBarItems(trailing: Button(action: {self.autoMove()}){
                HStack {
                    Image(systemName: "flame")
                    Text("Cheat")
                }.foregroundColor(Color.pink)
            })
            .sheet(isPresented: $showSolution, content: {SolutionView(steps: self.getAnsCopy())})
    }
    
    func newGame() {
        self.grid = randomize(level: self.level)
    }
    
    func getAnsCopy() -> [Int] {
        var a = grid
        return getAns(grid: &a)
    }
    
    func autoMove() {
        let ans = getAnsCopy()
        for i in ans {
            self.move(index: i)
        }
    }
    
    func move(index i: Int){
        let a = [i-1, i+1, i-self.level, i+self.level]
        
        for j in a {
            if j >= 0 && j < self.level*self.level {
                if grid[j] == 0 {
                    switch_postion(num: i, blank: j)
                }
            }
        }
    }
    
    func checkSuccess() -> Bool {
        let length = level*level
        var ansGrid = [Int](1..<length)
        ansGrid.append(0)
        return grid == ansGrid
    }
    
    func switch_postion(num i: Int, blank j: Int) {
        grid[j] = grid[i]
        grid[i] = 0
    }
    
    func getNum(row i: Int, col j: Int, level: Int) -> String {
        if grid[i*self.level+j] != 0 {
            return "\(grid[i*level+j])"
        }else if checkSuccess() && self.mode == "picture" {
            return "\(level*level)"
        }else {
            return ""
        }
    }
    
    func getColor(value v: Int) -> Color {
        let colors = [Color.pink, Color.orange, Color.green, Color.blue, Color.purple, Color.yellow]
        if v == 0 {
            return Color.gray
        }
        for j in 1...level - 1 {
            if v >= level*(j-1) + j && (v <= level*j || v%level == j ){
                return colors[j-1]
            }
        }
        return Color.gray
    }
    
}

struct PuzzleView_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleView(mode: .constant("picture"), level: .constant(3), grid: [1,2,3,4,5,6,7,8,0])
    }
}
