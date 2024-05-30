//
//  Line.swift
//  Sliders2
//
//  Created by Nick Turner on 5/17/24.
//

import SwiftUI
import Combine




struct Line: View {
    
    @State var waist: Double = 0
    @State var rise: Double = 0
    @State var seat: Double = 0
    @State var length: Double = 0
    @State var opening: Double = 0
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                
                //FrontPanel(waistAdjust: waist, riseAdjust: rise, seatAdjust: seat, lengthAdjust: length, openingAdjust: opening)
                //    .stroke(lineWidth: 5)
                //    .frame(width: 100)
                //Spacer()
                BackPanel(waistAdjust: waist, riseAdjust: rise, seatAdjust: seat, lengthAdjust: length, openingAdjust: opening)
                    .stroke(lineWidth: 5)
                    .frame(width: 100)
                Spacer()
            }
            
            Spacer()
            
            Text("Waist")
            Slider(value: $waist, in: -50...50)
            
            HStack {
                Text("Rise")
                Slider(value: $rise, in: -50...50)
                Text("Seat")
                Slider(value: $seat, in: -50...50)
            }
            HStack {
                Text("Length")
                Slider(value: $length, in: -50...50)
                Text("Opening")
                Slider(value: $opening, in: -50...50)
            }
                        
            Button("Reset") {
                self.waist = 0
                self.rise = 0
                self.seat = 0
                self.length = 0
                self.opening = 0
            }
        }
        .padding()
    }
    


    
}

#Preview {
    Line()
}

let Waist: Double = 450
let Rise: Double = 150
let Seat: Double = 600
let Length: Double = 475
let Opening: Double = 50

struct FrontPanel: Shape {
    
    let waistAdjust: Double
    let riseAdjust: Double
    let seatAdjust: Double
    let lengthAdjust: Double
    let openingAdjust: Double
    
    
    func path(in rect: CGRect) -> Path {
        
        
        Path { path in
            path.move(to: CGPoint(x: rect.midX+7.5-(Seat*0.125-7.5), y: rect.minY))
            path.addLine(to: CGPoint(x: rect.midX+7.5-(Seat*0.125-7.5)+Waist*0.25+15, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.midX+15+(Seat*0.125), y: rect.minY+Rise+riseAdjust))
            path.addLine(to: CGPoint(x: rect.maxX/1.1+openingAdjust, y: rect.maxY+lengthAdjust))
            path.addLine(to: CGPoint(x: rect.maxX/4.5-openingAdjust, y: rect.maxY+lengthAdjust))
            //path.addLine(to: CGPoint(x: rect.midX-(Seat*0.1875), y: rect.minY+Rise+riseAdjust))
            path.addQuadCurve(
                to: CGPoint(x: rect.midX-(Seat*0.1875), y: rect.minY+Rise+riseAdjust),
                control: CGPoint(x: rect.maxX/4-openingAdjust, y: rect.maxY+lengthAdjust))
            path.addQuadCurve(
                to: CGPoint(x: rect.midX-(Seat*0.125-7.5), y: (rect.minY+Rise+riseAdjust)*0.75),
                control: CGPoint(x: rect.midX-(Seat*0.125-7.5), y: rect.minY+Rise+riseAdjust)
            )
            path.closeSubpath()
            
        }
    }
}

struct BackPanel: Shape {
    
    let waistAdjust: Double
    let riseAdjust: Double
    let seatAdjust: Double
    let lengthAdjust: Double
    let openingAdjust: Double
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX+7.5-(Seat*0.125-7.5), y: rect.minY))
            path.addLine(to: CGPoint(x: rect.midX+7.5-(Seat*0.125-7.5)+Waist*0.25+15, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.midX+15+(Seat*0.125), y: rect.minY+Rise+riseAdjust))
            path.addLine(to: CGPoint(x: rect.maxX/1.1+openingAdjust, y: rect.maxY+lengthAdjust))
            path.addLine(to: CGPoint(x: rect.maxX/4.5-openingAdjust, y: rect.maxY+lengthAdjust))
            //path.addLine(to: CGPoint(x: rect.midX-(Seat*0.1875), y: rect.minY+Rise+riseAdjust))
            path.addQuadCurve(
                to: CGPoint(x: rect.midX-Seat*0.1875+Seat*0.1875*0.25, y: rect.minY+Rise+riseAdjust),
                control: CGPoint(x: rect.maxX/4-openingAdjust, y: rect.maxY+lengthAdjust))
            path.addQuadCurve(
                to: CGPoint(x: rect.midX-(Seat*0.125-7.5), y: (rect.minY+Rise+riseAdjust)*0.75),
                control: CGPoint(x: rect.midX-(Seat*0.125-7.5), y: rect.minY+Rise+riseAdjust)
            )
            path.closeSubpath()
            
        }
    }
}
