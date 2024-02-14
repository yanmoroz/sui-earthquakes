//
//  QuakesView.swift
//  Earthquakes
//
//  Created by Yan Moroz on 14.02.2024.
//

import SwiftUI


struct QuakesView: View {
    @AppStorage("lastUpdated")
    var lastUpdated = Date.distantFuture.timeIntervalSince1970
    
    @EnvironmentObject var provider: QuakesProvider
    @State private var editMode: EditMode = .inactive
    @State private var selectMode: SelectButton.SelectMode = .inactive
    @State private var isLoading = false
    @State private var selection: Set<String> = []
    @State private var error: QuakeError?
    @State private var hasError = false
    
    var body: some View {
        NavigationView {
            List(selection: $selection) {
                ForEach(provider.quakes) { quake in
                    QuakeRow(quake: quake)
                }
                .onDelete(perform: deleteQuakes)
            }
            .listStyle(.inset)
            .navigationTitle(title)
            .toolbar(content: toolbarContent)
            .environment(\.editMode, $editMode)
            .refreshable {
                await fetchQuakes()
            }
            .alert(isPresented: $hasError, error: error) {
                
            }
        }
        .task {
            await fetchQuakes()
        }
    }
}

extension QuakesView {
    
    @ToolbarContentBuilder
    func toolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            if editMode == .active {
                SelectButton(mode: $selectMode) {
                    if selectMode.isActive {
                        selection = Set(provider.quakes.map { $0.code })
                    } else {
                        selection = []
                    }
                }
            }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
            EditButton(editMode: $editMode) {
                selection.removeAll()
                editMode = .inactive
                selectMode = .inactive
            }
        }
        ToolbarItemGroup(placement: .bottomBar) {
            RefreshButton {
                Task {
                    await fetchQuakes()
                }
            }
            Spacer()
            ToolbarStatus(
                isLoading: isLoading,
                lastUpdated: lastUpdated,
                quakesCount: provider.quakes.count
            )
            Spacer()
            if editMode == .active {
                DeleteButton {
                    deleteQuakes(for: selection)
                }
                .disabled(isLoading || selection.isEmpty)
            }
        }
    }
}


extension QuakesView {
    var title: String {
        if selectMode.isActive || selection.isEmpty {
            return "Earthquakes"
        } else {
            return "\(selection.count) Selected"
        }
    }
    
    func deleteQuakes(at offsets: IndexSet) {
        provider.quakes.remove(atOffsets: offsets)
    }
    
    func deleteQuakes(for codes: Set<String>) {
        var offsetsToDelete: IndexSet = []
        for (index, element) in provider.quakes.enumerated() {
            if codes.contains(element.code) {
                offsetsToDelete.insert(index)
            }
        }
        deleteQuakes(at: offsetsToDelete)
        selection.removeAll()
    }
    
    func fetchQuakes() async {
        isLoading = true
        do {
            try await provider.fetchQuakes()
            lastUpdated = Date().timeIntervalSince1970
        } catch {
            self.error = error as? QuakeError ?? .unexpectedError(error: error)
            self.hasError = true
        }
        isLoading = false
    }
}

#Preview {
    QuakesView()
        .environmentObject(
            QuakesProvider(
                client: QuakeClient(
                    downloader: TestDownloader()
                )
            )
        )
}
