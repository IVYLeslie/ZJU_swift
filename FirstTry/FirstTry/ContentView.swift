//
//  ContentView.swift
//  FirstTry
//
//  Created by 朱雨珂 on 2022/3/3.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        //Color.black.ignoresSafeArea()
        ZStack{
            Color.black.ignoresSafeArea()
            VStack(spacing:0){
                
                Image("tmp").resizable()
                    //.aspectRatio(2, contentMode:.fit)
                    .padding(.bottom,60)
                    
                    //.shadow(color:.gray,radius:10,x:10,y:10)
                    .frame(width: 130, height: 130, alignment: .center)
                Text("Welcome to")
                    .font(.largeTitle.weight(.heavy))
                    .padding(.horizontal,10)
                    .foregroundColor(.white)
                Text("Gradients Game")
                    .font(.largeTitle.bold())
                    .padding(.horizontal,10)
                    .foregroundColor(Color.init(red: 120/256, green: 112/256, blue: 231/256))
                text1
                text2
                text3
                Button("continue                                                       ", action:{print("yes")})
                    .buttonStyle(.bordered)
                    .background(Color.init(red: 120/256, green: 112/256, blue: 231/256))
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .cornerRadius(100)
                    .padding(.top,40)
                    .frame(width: .infinity, height:.infinity, alignment: .bottom)
                
            }
        }
    }

    var text1:some View{
        HStack{
            Image(systemName: "slider.horizontal.below.rectangle").padding(10).font(.largeTitle).foregroundColor(Color.init(red: 120/256, green: 112/256, blue: 231/256))
            VStack{
                
                Text("Match").bold().frame(width: 270, alignment:.topLeading).font(.system(size: 15)).foregroundColor(.white)
                
                Text("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA").font(.caption2).foregroundColor(Color.white.opacity(0.6))
            }
        }.padding(.top,20)
    }
    
    var text2:some View{
        HStack{
            Image(systemName: "minus.forwardslash.plus").padding(10).font(.largeTitle).foregroundColor(Color.init(red: 120/256, green: 112/256, blue: 231/256))
            VStack{
                Text("Precise").bold().frame(width: 270, alignment:.topLeading).font(.system(size: 15)).foregroundColor(.white)
                Text("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA").font(.caption2).foregroundColor(Color.white.opacity(0.6))
            }
        }.padding(.top,10)
    }
    var text3:some View{
        HStack{
            Image(systemName: "checkmark.square").padding(10).font(.largeTitle).foregroundColor(Color.init(red: 120/256, green: 112/256, blue: 231/256))
            VStack{
                Text("Score").bold()
                    .frame(width: 270, alignment:.topLeading)
                    .font(.system(size:15))
                    .foregroundColor(.white)
                Text("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA").font(.caption2).foregroundColor(Color.white.opacity(0.6))
                
            }
        }.padding(.bottom,40).padding(.top,10)
    }
    
    
    
    var head2:some View{
        Text("Gradients Game")
            .font(.largeTitle.bold())
            .padding(.horizontal,10)
            //.padding(.vertical,10)
            .foregroundColor(Color.init(red: 120/256, green: 112/256, blue: 231/256))
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
            
        
    }
}
