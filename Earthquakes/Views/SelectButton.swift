//
//  SelectButton.swift
//  Earthquakes
//
//  Created by Yan Moroz on 15.02.2024.
//

import SwiftUI

struct SelectButton: View {
    @Binding var mode: SelectMode
    var action: () -> Void = {}
    var body: some View {
        Button {
            withAnimation {
                mode.toggle()
                action()
            }
        } label: {
            Text(mode.isActive ? "Deselect All" : "Select All")
        }
    }
    
    enum SelectMode {
        case active, inactive

        var isActive: Bool {
            self == .active
        }

        mutating func toggle() {
            switch self {
            case .active:
                self = .inactive
            case .inactive:
                self = .active
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Group {
        SelectButton(mode: .constant(.active))
        SelectButton(mode: .constant(.inactive))
    }
}
