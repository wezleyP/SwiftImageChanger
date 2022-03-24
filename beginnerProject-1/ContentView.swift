//
//  ContentView.swift
//  beginnerProject-1
//
//  Created by Wesley Patterson on 3/23/22.
//

import SwiftUI

//Model

class PhotoModel: ObservableObject {
    
    @Published var image: Image?
    
    func fetchNewImage() {
        guard let url = URL(string: "https://random.imagecdn.app/500/500") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data,
          _, _ in
            guard let data = data else {return}
        
            DispatchQueue.main.async {
                guard let uiImage = UIImage(data: data) else {
                    return
                }
                self.image = Image(uiImage: uiImage)
            }
        }
        task.resume()
    }
}

struct ContentView: View {
    
    var viewModel = PhotoModel()
    
    @State var topText = ""
    
    var arr = ["Nice!", "Thats cool!", "Ok sick photo", "Thats huge!", "Oh brother...", "Thats kinda cool ig", "Sicko mode", "Pretty cool", "This is the best one for sure"]
    
    var body: some View {
        NavigationView {
            VStack {
               
                Text(topText)
                    .bold()
                    .frame(width: 300, height: 40)
                    .foregroundColor(Color.white)
            
                Spacer()
                
                if let image = viewModel.image {
                    ZStack {
                        image
                            .resizable()
                            .foregroundColor(Color.red)
                            .frame(width: 200, height: 200)
                    }
                    .frame(width: UIScreen.main.bounds.width / 1.2,
                           height: UIScreen.main.bounds.width / 1.2)
                    .background(Color.gray)
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 6, x: 3, y: 3)
                    
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .foregroundColor(Color.red)
                        .frame(width: 200, height: 200)
                }
                
                Spacer()
                Button(action: {
                    topText = arr.randomElement()!
                    viewModel.fetchNewImage()
                }, label: {
                    Text("Change Photo")
                        .bold()
                        .frame(width: 300, height: 40)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(6)
                        .shadow(color: .gray, radius: 5, x: 2, y: 2)
                })
                
            }
            .navigationTitle("Photos")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
