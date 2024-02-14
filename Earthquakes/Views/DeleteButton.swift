//
//  DeleteButton.swift
//  Earthquakes
//
//  Created by Yan Moroz on 15.02.2024.
//

import SwiftUI

struct DeleteButton: View {
    var action: () -> Void = {}
    var body: some View {
        Button(action: action) {
            Label("Delete", systemImage: "trash")
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    DeleteButton()
}
