//
//  Line.swift
//  Sliders2
//
//  Created by Nick Turner on 5/17/24.
//

import SwiftUI
import Combine
struct Adjustments {
    static var Waist = Double()
}
var adjust: Double = 0
struct Line: View {
    
    @State var waist: Double = 0
    
    func setAdjust(){
        Adjustments.Waist = waist
    }
  
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                
                FrontPanel()
                    .stroke(lineWidth: 5)
                    .frame(width: 150)
                Spacer()
                BackPanel()
                    .stroke(lineWidth: 5)
                    .frame(width: 150)
                Spacer()
            }
            
            Spacer()
            
            Text("Waist")
            Slider(value: $waist, in: -50...50)
            
            Button("Reset") {
                self.waist = 0
                
            }
        }
        .padding()
    }
    


    
}

#Preview {
    Line()
}

struct FrontPanel: Shape {
    
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.maxX/3.5, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX/1.2, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY/3))
            path.addLine(to: CGPoint(x: rect.maxX/1.1, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX/4.5, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY/3))
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX/4, y: rect.maxY/3-55),
                control: CGPoint(x: rect.maxX/4, y: rect.maxY/3)
            )
            path.closeSubpath()
            
        }
    }
}

struct BackPanel: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            
            path.move(to: CGPoint(x: rect.maxX/1.8, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX/20, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY/3))
            path.addLine(to: CGPoint(x: rect.maxX/6, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX/1.15, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY/3))
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX/1.5, y: rect.maxY/3-55),
                control: CGPoint(x: rect.maxX/1.4, y: rect.maxY/3)
            )
            path.closeSubpath()
            
        }
    }
}
