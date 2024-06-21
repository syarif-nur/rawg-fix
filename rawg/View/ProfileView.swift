import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            Image("aboutme")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .padding()
            Text("Syarif Nur")
                .font(.title)
                .foregroundColor(.primary)
                .padding(.bottom, 10)
            Text("Mobile Software Engineer")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom, 20)
        }
    }
}
