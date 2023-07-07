//
//  SearchFieldView.swift
//  GitHub
//
//  Created by Nick Pavlov on 7/7/23.
//

import SwiftUI

struct SearchFieldView: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Enter the user name", text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .padding(.trailing, 48)
                .background(Color(.systemGroupedBackground))
                .cornerRadius(15)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.secondary)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }
                )
        }
        .padding()
    }
}

struct SearchFieldView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFieldView(text: .constant(""))
    }
}
