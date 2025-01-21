//
//  MainView.swift
//  Financial_recoder
//
//  Created by dididadida on 2025/1/20.
//
import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            // Top section with images and labels
            UsercardsView()
            ButtonsView()
            
            // Cumulative Deposit Section
            BarView(title: "﻿累積金額")
                .padding(.bottom,10)
            
            // Available Amount Section
            BarView(title: "﻿﻿可用金額")
                .padding(.bottom,10)
            // Cumulative Expense Section
            BarView(title: "﻿累積﻿消費")
        }
        .padding(.top,10)
        .padding(.bottom,10)
        .padding([.leading, .trailing], 20)
    }
}

struct UsercardsView: View {
    var body: some View {
        HStack {
            usercard(imageName: "person.circle", amount: 100,size: 50,frontsize: 24)
            Spacer()
            // VS Image
            Image(systemName:"flag.2.crossed.fill")
                .symbolRenderingMode(.multicolor)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundStyle(.teal)
            Spacer()
            usercard(imageName: "person.circle", amount: 100,size:50,frontsize: 24)
        }
        .padding([.leading, .trailing], 20)
    }
}


struct usercard:View{
    let imageName: String
    let amount: Float
    let size:CGFloat
    let frontsize:CGFloat
    
    var body: some View {
        VStack {
            userPicture(imageName:imageName,size: size)
           Text("$\(String(format: "%.2f", amount))")
                .font(.system(size: frontsize))
        }
    }
}

struct ButtonsView: View {
    var body: some View {
        HStack {
            Button(action: {
                // 第一個按鈕的操作
            }) {
                Text("﻿收入")
                    .frame(maxWidth: .infinity,maxHeight: 10)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(45)
            }
            
            Button(action: {
                // 第二個按鈕的操作
            }) {
                Text("﻿支出﻿")
                    .frame(maxWidth: .infinity,maxHeight: 10)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(45)
            }
        }
        .padding(.bottom,15)
        .frame(maxWidth: .infinity) // 讓按鈕填滿可用的水平空間
    }
}

struct userPicture:View {
    let imageName: String
    let size:CGFloat
    var body: some View {
        ZStack {
            Image(systemName: imageName)
                .resizable()
                .frame(width: size, height: size)
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
            
            
            Image(systemName: "star.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size/2, height: size/2)
                .clipShape(Circle())
                .offset(x: size-size/1.8, y: size-size/1.8)
            
        }
    }
}

struct BarView : View{
    let title:String
    var body:some View{
        VStack(alignment: .leading) {
            Text(title)
                .font(
                    .system(size: 15)
                )
            HStack{
                userPicture(imageName:"person.circle", size: 20)
                
                BarComponent(value: 0.75)
            }
            Text("$\(String(format: "%.2f", 100.00))")
                .font(.system(size: 12))
            HStack{
                userPicture(imageName:"person.circle", size: 20)
                
                BarComponent(value: 0.75)
            }
            Text("$\(String(format: "%.2f", 100.00))")
                .font(.system(size: 12))
        }
        .padding([.bottom,.top],10)
        .padding([.leading, .trailing], 20)
        .background(
            RoundedRectangle(cornerRadius: 25)
            .stroke(Color.gray, lineWidth: 2)
        )
        
        
    }
}


struct BarComponent : View{
    let value:Float
    
    var body:some View {
        HStack {        
            ProgressView(value: value)
                .progressViewStyle(BarProgressStyle())
                .frame(height: 10)
            Spacer()
            Text("$ ﻿目標存款")
                .font(.subheadline)
        }
    }
}

struct BarProgressStyle: ProgressViewStyle {
    
    var color: Color = .green
    var height: Double = 10.0
    var labelFontStyle: Font = .body
    
    func makeBody(configuration: Configuration) -> some View {
        
        let progress = configuration.fractionCompleted ?? 0.0
        
        GeometryReader { geometry in
            
            VStack(alignment: .leading) {
                
                configuration.label
                    .font(labelFontStyle)
                
                RoundedRectangle(cornerRadius: 3.0)
                    .fill(Color(uiColor: .systemGray5))
                    .frame(height: height)
                    .frame(width: geometry.size.width)
                    .overlay(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 3.0)
                            .fill(color)
                            .frame(width: geometry.size.width * progress)
                            .overlay {
                                if let currentValueLabel = configuration.currentValueLabel {
                                    
                                    currentValueLabel
                                        .font(.headline)
                                        .foregroundColor(.white)
                                }
                            }
                    }
                
            }
            
        }
    }
}
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

