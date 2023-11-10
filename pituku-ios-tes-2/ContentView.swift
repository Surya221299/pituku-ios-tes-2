//
//  ContentView.swift
//  pituku-ios-tes-2.
//
//  Created by Bamantara S on 09/11/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ListView()
    }
}

// Main View

struct ListView: View {
    @ObservedObject var viewModel = RecipeViewModel()
    
    var body: some View {
        
            NavigationView {
                ScrollView(.vertical, showsIndicators: false) {
                //            List(viewModel.recipes, id: \.self) { recipe in
                    Image("pitukulogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180, height: 75)
                VStack(alignment: .leading)  {
                    
                    ForEach(viewModel.recipes, id: \.self) { recipe in
                        NavigationLink (destination: RecipeDetailView(recipe: recipe)) {
                            
                            HStack {
//                                AsyncImage(url: URL(string: recipe.cover.trimmingCharacters(in: .whitespaces))) { image in
//                                    image
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fit)
//                                } placeholder: {
//                                    Rectangle()
//
//                                }

//                                WebImage(url: URL(string: recipe.cover))
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 80, height: 80)
                                
                                Text(recipe.title)
                                    .font(.system(size: 15, weight: .bold))
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(2)
                                    .foregroundColor(.black)
                                    .padding(.vertical, 4)
                                Spacer()
                                Text("Detail >")
                                    .font(.system(size: 14, weight: .bold))
                            }
                        }
                        Divider()
                    }
                    
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

// Sub View



// Model server

struct ServerResponse: Decodable {
    let status, message : String
    let data: [Data]
    let totalItems, totalPages, currentPage: Int
}

// Model data

struct Data: Decodable, Identifiable, Hashable {
    let id: String
    let title, description, cover, createdAt : String
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// API Link

class RecipeService {
    func getRecipes(_ completion: @escaping (Result<[Data], Error>) -> ()) {
        let url = URL(string: "https://api.pituku.id/api/articles")!
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                return completion(.failure(error))
            }
            
            guard let data = data else {
                return completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
            }
            
            do {
                let response = try JSONDecoder().decode(ServerResponse.self, from: data)
                completion(.success(response.data))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
}

// ViewModel

class RecipeViewModel: ObservableObject {
    
    @Published var recipes = [Data]()
    @Published var isLoading = false
    
    private let service = RecipeService()
    
    init() {
        loadData()
    }
    
    private func loadData() {
        isLoading = true
        service.getRecipes{ [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let recipes):
                    self?.recipes = recipes
                }
            }
        }
    }
    
    
}

