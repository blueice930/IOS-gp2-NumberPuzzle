import SwiftUI

struct StyleButton: View {
    @State var text: String
    var body: some View {
        VStack {
            Text(text)
                .foregroundColor(Color.white)
                .fontWeight(.bold)
                .font(.title)
        }.frame(width: 180, height: 50)
            .background(Color.gray)
        .cornerRadius(14)
        .shadow(radius: 4)
    }
}

struct StyleButton_Previews: PreviewProvider {
    static var previews: some View {
        StyleButton(text: "Start")
    }
}
