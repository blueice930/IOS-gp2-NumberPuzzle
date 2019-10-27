import SwiftUI

struct ContentView: View {
    @State var nums = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0]
    var body: some View {
        VStack{
            ForEach(0..<4, id: \.self) { i in
                HStack (spacing: 0){
                    ForEach(0..<4, id: \.self) { j in
                        Button(action: {
                            withAnimation(.linear){
                                self.move(index: i*4+j)
                            }
                        }){
                            Text(self.nums[i*4+j] != 0 ? "\(self.nums[i*4+j])" : "")
                                .font(.headline)
                                .frame(width: 100, height: 100)
                                .border(Color.red, width: 2)
                                .padding(0)
                        }
                    }
                }
            }
        }
    }
    
    func move(index i: Int){
        let a = [i-1, i+1, i-4, i+4]
        
        for j in a{
            if j >= 0 && j <= 15 {
                if nums[j] == 0 {
                    switch_postion(num: i, blank: j)
                }
            }
        }
    }
    
    func switch_postion(num i: Int, blank j: Int) {
        nums[j] = nums[i]
        nums[i] = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
