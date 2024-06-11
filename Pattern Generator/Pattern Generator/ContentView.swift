//
//  ContentView.swift
//  Pattern Generator
//
//  Created by Nick Turner on 6/11/24.
//

//
//  Line.swift
//  Sliders2
//
//  Created by Nick Turner on 5/17/24.
//

import SwiftUI
import Combine




struct ContentView: View {
    @State var panel = false
    @State var waist: Double = 0
    @State var rise: Double = 0
    @State var seat: Double = 0
    @State var length: Double = 0
    @State var opening: Double = 0
    var body: some View {
        ShareLink("Export PDF", item: render())
        VStack {
            Spacer()
            HStack {
                Spacer()
                if  panel == false {
                    FrontPanel(waistAdjust: waist, riseAdjust: rise, seatAdjust: seat, lengthAdjust: length, openingAdjust: opening)
                        .stroke(lineWidth: 5)
                        .frame(width: 100)
                } else {
                    BackPanel(waistAdjust: waist, riseAdjust: rise, seatAdjust: seat, lengthAdjust: length, openingAdjust: opening)
                        .stroke(lineWidth: 5)
                        .frame(width: 100)
                }
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
                        
            HStack {
                Spacer()
                Toggle(isOn: $panel) {
                    Text("Show Back")
                }
               
                Button("Reset") {
                    self.waist = 0
                    self.rise = 0
                    self.seat = 0
                    self.length = 0
                    self.opening = 0
                }
                Spacer()
            }
        }
        .padding()
    }
    @MainActor func render() -> URL {
        // 1: Render Hello World with some modifiers
        let renderer = ImageRenderer(content:FrontPanel(waistAdjust: waist, riseAdjust: rise, seatAdjust: seat, lengthAdjust: length, openingAdjust: opening)
            .stroke(lineWidth: 5)
            .frame(width: 100)
            .frame(height: 300))
        
        // 2: Save it to our documents directory
        let url = URL.documentsDirectory.appending(path: "output.pdf")
        
        // 3: Start the rendering process
        renderer.render { size, context in
            // 4: Tell SwiftUI our PDF should be the same size as the views we're rendering
            var box = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            
            // 5: Create the CGContext for our PDF pages
            guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else {
                return
            }
            
            // 6: Start a new PDF page
            pdf.beginPDFPage(nil)
            
            // 7: Render the SwiftUI view data onto the page
            context(pdf)
            
            // 8: End the page and close the file
            pdf.endPDFPage()
            pdf.closePDF()
        }
        
        return url
    }

    
}

#Preview {
    ContentView()
}

let Waist: Double = 450
let Rise: Double = 150
let Seat: Double = 600
let Length: Double = 475
let Opening: Double = 150

struct FrontPanel: Shape {
    
    let waistAdjust: Double
    let riseAdjust: Double
    let seatAdjust: Double
    let lengthAdjust: Double
    let openingAdjust: Double
    
    
    func path(in rect: CGRect) -> Path {
        
        
        Path { path in
            path.move(to: CGPoint(x: rect.midX+7.5-(Seat*0.125-7.5)-waistAdjust, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.midX+7.5-(Seat*0.125-7.5)+Waist*0.25+15+waistAdjust, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.midX+15+(Seat*0.125) + seatAdjust, y: rect.minY+Rise+riseAdjust))
            path.addLine(to: CGPoint(x: rect.midX+Opening/2+openingAdjust, y: rect.maxY+lengthAdjust))
            path.addLine(to: CGPoint(x: rect.midX-Opening/2-openingAdjust, y: rect.maxY+lengthAdjust))
            //path.addLine(to: CGPoint(x: rect.midX-(Seat*0.1875), y: rect.minY+Rise+riseAdjust))
            path.addQuadCurve(
                to: CGPoint(x: rect.midX-(Seat*0.1875) - seatAdjust, y: rect.minY+Rise+riseAdjust),
                control: CGPoint(x: rect.midX-Opening/2-openingAdjust, y: rect.maxY+lengthAdjust))
            path.addQuadCurve(
                to: CGPoint(x: rect.midX-(Seat*0.125-7.5)-waistAdjust, y: (rect.minY+Rise+riseAdjust)*0.75),
                control: CGPoint(x: rect.midX-(Seat*0.125-7.5)-waistAdjust, y: rect.minY+Rise+riseAdjust)
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
            path.move(to: CGPoint(x: rect.midX+15-(Seat*0.125-7.5) + (Seat*0.125-7.5) * 0.25 - waistAdjust, y: rect.minY-7.5))
            path.addLine(to: CGPoint(x: rect.midX+15-(Seat*0.125-7.5) + (Seat*0.125-7.5) * 0.25+Waist*0.25+26 + waistAdjust, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.midX-(Seat*0.125-7.5) + (Seat*0.125-7.5) * 0.25 + (Seat * 0.25+18) + seatAdjust, y: rect.minY+Rise+riseAdjust))
            path.addLine(to: CGPoint(x: rect.midX+Opening/2+openingAdjust+11, y: rect.maxY+lengthAdjust))
            path.addLine(to: CGPoint(x: rect.midX-Opening/2-openingAdjust-11, y: rect.maxY+lengthAdjust))
            //path.addLine(to: CGPoint(x: rect.midX-(Seat*0.1875), y: rect.minY+Rise+riseAdjust))
            path.addQuadCurve(
                to: CGPoint(x: rect.midX-(Seat*0.216) - seatAdjust, y: rect.minY+Rise+riseAdjust+3.75),
                control: CGPoint(x: rect.midX-Opening/2-openingAdjust-11, y: rect.maxY+lengthAdjust))
            path.addQuadCurve(
                to: CGPoint(x: rect.midX-(Seat*0.125-7.5) + (Seat*0.125-7.5) * 0.25 - waistAdjust, y: (rect.minY+Rise+riseAdjust)*0.75*0.5),
                control: CGPoint(x: rect.midX-(Seat*0.125-7.5) - waistAdjust, y: rect.minY+Rise+riseAdjust)
            )
            path.closeSubpath()
            
        }
    }
}

