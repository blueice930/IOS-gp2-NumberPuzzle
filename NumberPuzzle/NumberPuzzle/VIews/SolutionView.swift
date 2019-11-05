import SwiftUI

struct SolutionView: View {
    @State var steps : [Int]

    var body: some View {
        ZStack {
            Color.yellow.edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 15) {
                Text("Move the following\nsquares in order:")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(10)
                Divider()
                ScrollView(.vertical) {
                    Text(getSteps(steps: steps))
                        .padding(15)
                }.frame(width: 350)
            }
        }
    }
    
    func getSteps(steps: [Int]) -> String {
        return steps.map({"\($0+1)"}).joined(separator: " -> ")
    }
}

struct SolutionView_Previews: PreviewProvider {
    static var previews: some View {
        SolutionView(steps: [1,2,3])
    }
}
