//
//  EditButton.swift
//  Earthquakes
//
//  Created by Yan Moroz on 15.02.2024.
//

import SwiftUI

struct EditButton: View {
    @Binding var editMode: EditMode
    var action: () -> Void = {}
    var body: some View {
        Button {
            withAnimation {
                if editMode == .active {
                    action()
                    editMode = .inactive
                } else {
                    editMode = .active
                }
            }
        } label: {
            if editMode == .active {
                Text("Cancel").bold()
            } else {
                Text("Edit")
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Group {
        EditButton(editMode: .constant(.inactive))
        EditButton(editMode: .constant(.active))
        EditButton(editMode: .constant(.transient))
    }
}
