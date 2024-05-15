//
//  SwiftUIView.swift
//  Lines
//
//  Created by Nick Turner on 5/15/24.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        Path { path in
            var width: CGFloat = 100.0
                        let height = width
                        path.move(
                            to: CGPoint(
                                x: width * 0.95,
                                y: height * 0.20
                            )
                        )
            HexagonParameters.segments.forEach { segment in
                            path.addLine(
                                to: CGPoint(
                                    x: width * segment.line.x,
                                    y: height * segment.line.y
                                )
                            )
                        }

                }
                .fill(.black)
    }
}

#Preview {
    SwiftUIView()
}
