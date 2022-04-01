//
//  test.swift
//  HW1
//
//  Created by 朱雨珂 on 2022/3/23.
//

import SwiftUI
struct test: View{
    var body: some View{
        VStack {
                    

                    Button("Show Options") {
                        showingOptions = true
                    }
                    .actionSheet(isPresented: $showingOptions) {
                        ActionSheet(
                            title: Text("Select a color"),
                            buttons: [
                                .default(Text("Red")) {
                                    selection = "Red"
                                },

                                .default(Text("Green")) {
                                    selection = "Green"
                                },

                                .default(Text("Blue")) {
                                    selection = "Blue"
                                },
                            ]
                        )
                    }
                }
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}

