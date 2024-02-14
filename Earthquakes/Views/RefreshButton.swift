//
//  RefreshButton.swift
//  Earthquakes
//
//  Created by Yan Moroz on 15.02.2024.
//

import SwiftUI

struct RefreshButton: View {
    var action: () -> Void = {}
    var body: some View {
        Button(action: action) {
            Label("Refresh", systemImage: "arrow.clockwise")
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    RefreshButton()
}
