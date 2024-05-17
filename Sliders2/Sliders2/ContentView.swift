//
//  ContentView.swift
//  Sliders2
//
//  Created by Nick Turner on 5/17/24.
//

import SwiftUI

struct ContentView: View {
    @State var width: Double = 110
    @State var height: Double = 110
    var body: some View {
        VStack {
            Spacer()
            Rectangle()
                .frame(width: width, height: height)
            Spacer()
            Text("Width")
            Slider(value: $width, in: 10...200)
            Text("Height")
            Slider(value: $height, in: 10...200)
            Button("Reset") {
                self.height = 110
                self.width = 110
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
