//
//  RecipeDetailView.swift
//  pituku-ios-tes-2
//
//  Created by Bamantara S on 10/11/23.
//

import SwiftUI

//
//  RecipeDetailView.swift
//  pituku-ios-tes-2.
//
//  Created by Bamantara S on 10/11/23.
//

import SwiftUI

struct RecipeDetailView: View {
    var recipe : Data
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack(alignment: .center) {
                Spacer()
                Text("Detail Article")
                    .font(.system(size: 28, weight: .bold))
                Spacer()
            }
            Text(recipe.title)
                .font(.system(size: 22, weight: .bold))
                .multilineTextAlignment(.leading)
            
            VStack( alignment: .leading, spacing: 8) {
                Text("Description :")
                    .font(.system(size: 16, weight: .semibold))
                Text(recipe.description)
                    .font(.system(size: 14, weight: .medium))
                    .multilineTextAlignment(.leading)
            }
            Spacer()
        }
        .padding(.horizontal, 16)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe: Data(id: "", title: "", description: "", cover: "", createdAt: ""))

    }
}

