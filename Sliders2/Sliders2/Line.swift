//
//  Line.swift
//  Sliders2
//
//  Created by Nick Turner on 5/17/24.
//

import SwiftUI

struct Line: View {
    @State var width: Double = 110
    @State var height: Double = 110
    var body: some View {
        VStack {
            Spacer()
            Path { path in
                path.move(to: CGPoint(x: 200, y: height*3))
                path.addLine(to: CGPoint(x: width/2, y: 300))
                path.addLine(to: CGPoint(x: width, y: height))
                path.addQuadCurve(to: CGPoint(x: width, y: height+50), control: CGPoint(x: height/2, y: width*2))
            }
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
    Line()
}
