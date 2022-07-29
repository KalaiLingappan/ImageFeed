//
//  DetailView.swift
//  ImageFeed
//
//  Created by Kalaiprabha L on 29/07/22.
//

import SwiftUI
import Combine

struct DetailView: View {
    @State var url: String
    var body: some View {
        AsyncImage(url: URL(string: url))
            .scaledToFill()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "google.com")
    }
}
