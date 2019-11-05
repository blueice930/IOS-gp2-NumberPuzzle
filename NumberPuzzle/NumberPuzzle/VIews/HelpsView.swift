import SwiftUI

struct HelpsView: View {
    
    var body: some View {
        ZStack {
            Image("helps-bg")
            .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Solving Strategy")
                    .foregroundColor(Color.white)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .shadow(radius: 2)
                    .background(RoundedRectangle(cornerRadius: 14).foregroundColor(Color.black).opacity(0.6).frame(width: 300, height: 60))
                Divider()
                ScrollView(.vertical) {
                    VStack {
                        Text(getText())
                            .fontWeight(.bold)
                            .font(.body)
                            .padding()
                            .foregroundColor(Color.white)
                            .shadow(radius: 2)
                        .background(RoundedRectangle(cornerRadius: 14).foregroundColor(Color.black).opacity(0.6))
                    }
                }
                .frame(width: 350)
            }
        }
    }
    
    func getText() -> String {
        return """
        STEP 1 – Solve the upper corner\n\n
        
        Position all the top pieces from left to right:\n\n
        
        1.1 Move the 1st piece to the top left corner.\n\n
        
        1.2 Move the 2nd piece to the top corner just close to the 1st piece\n\n
        
        1.3 If required move the 3rd, 4th pieces and so on until there is only 2 missing (applicable for puzzles bigger than 4×4)\n\n
        
        1.4 Make sure that the last piece of the row is not on the top row itself. If yes, move it out! (Anywhere far away from it)\n\n
        
        
        1.5 Move the before last piece of the row to the top right corner (for a 3 columns puzzle, the 2nd piece, for a 4 columns puzzle the 3rd piece, etc.).\n\n
        
        
        1.6 Position the last piece of the row just below it (right corner, 2nd position from the top)\n\n
        
        1.7 Move the before last piece to its correct place and the last piece just behind it\n\n
        
        
        
        STEP 2 – Solve the left corner\n\n
        
        Position all the left pieces from top to bottom. Please note that the first piece is already be on its correct position:\n\n
        
        2.1 Move the 2nd piece of the column just below the 1st piece\n\n
        
        
        
        2.2 If required move the 3rd, 4th pieces and so on until there is only 2 missing (applicable for puzzles bigger than 4×4)\n\n
        
        2.3 Make sure that the last piece of the column is not on the left column itself. If yes, move it out! (Anywhere far away from it)\n\n
        
        
        
        2.4 Move the before last piece of the column to the bottom left corner (for a 3 columns puzzle, the 4th piece, for a 4 columns puzzle the 9th piece, etc.).\n\n
        
        2.5 Move the last piece of the column just to the right of it (bottom corner, 2nd position from the left).\n\n
        
        2.6 Move the before last piece to its correct place and the last piece just behind it.\n\n
        
        STEP 3 – Repeat steps 1 and 2\n\n
        Consider the top and left corners as frozen (you are not allowed to touch these pieces anymore!). Go back to step 1 assuming that you are now solving a smaller puzzle. Examples:\n\n
        
        If you froze the top and left corners of a 4×4 puzzle, you will now have to solve a 3×3 puzzle.\n\n
        If you froze the top and left corners of a 5×5 puzzle, you will now have to solve a 4×4 puzzle.\n\n
        And so on…\n\n
        If you are solving a 3×3 puzzle you will execute step 1 only and jump to step 4
        
        """
    }
}

struct HelpsView_Previews: PreviewProvider {
    static var previews: some View {
        HelpsView()
    }
}
