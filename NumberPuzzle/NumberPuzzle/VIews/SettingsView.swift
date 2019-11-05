import SwiftUI

struct SettingsView: View {
    @Binding var level: Int
    @Binding var mode: String
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.4),
                                                       Color.red.opacity(0.4), Color.orange.opacity(0.5), Color.purple.opacity(0.2)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Text("Select Mode")
                    .font(.title)
                    .foregroundColor(Color.white)
                    .shadow(radius: 3)
                Divider()
                Picker(selection: $mode, label: Text("")) {
                    Text("Picture Mode").tag("picture")
                    Text("Number Mode").tag("number")
                }.pickerStyle(SegmentedPickerStyle())
                    .animation(.easeInOut)
                    .shadow(radius: 5)
                    .frame(width: 350)
                Spacer()
                Text("Select Level")
                    .font(.title)
                    .foregroundColor(Color.white)
                    .shadow(radius: 3)
                Divider()
                Picker(selection: $level, label: Text("")){
                    ForEach(3 ... 6, id: \.self) { i in
                        Text(String(i))
                    }
                }.animation(.easeInOut)
                    .shadow(radius: 5)
                    .frame(width: 350)
                Spacer()
            }
        }.navigationBarTitle(Text("Settings"))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(level: .constant(3), mode: .constant("picture"))
    }
}
