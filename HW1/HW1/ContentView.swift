//
//  ContentView.swift
//  HW1
//
//  Created by 朱雨珂 on 2022/3/14.
//




import SwiftUI


struct ContentView: View {
    //homepage
    let scwidth = UIScreen.main.bounds.width
    let scheight = UIScreen.main.bounds.height
    
    @State private var myrectangles = ["Scheduled","Today","All"]
    @State private var standardcolors = [Color(.red),Color(.blue),Color(red: 0.356, green: 0.385, blue: 0.415)]//today all schedule的颜色
    
    //下方两个按钮
    @State var add_list = false
    @State var new_reminder = false
    @State var pop = false
    
    
    @State var lists :[list_info] = [
        list_info(list_color: Color(red: -0.011, green: 0.473, blue: 0.978), list_name: "Reminders", list_num: 1,chosen: false,details:[ detail_info(date:Date(),time: Date(), location:"Current",priority:"High",title:"test",note:"testnote")]),
        list_info(list_color: Color(red: 0.998, green: 0.585, blue: -0.01), list_name: "Life", list_num: 3,chosen: false,details:[ detail_info(date:Date(),time: Date(), location:"Getting in the car",priority:"High",title:"life",note:"lifenote"),detail_info(date:Date(),time: Date(), location:"Getting out of the car",priority:"Medium",title:"1111",note:"111111111"),detail_info(date:Date(),time: Date(), location:"Current",priority:"Low",title:"heihei",note:"heiheihei")]),
        list_info(list_color: Color(red: 1.001, green: 0.799, blue: 0.006), list_name: "Wtf", list_num: 3,chosen: false,details:[ detail_info(date:Date(),time: Date(), location:"Getting in the car",priority:"None",title:"wtf",note:"wtfnote"),detail_info(date:Date(),time: Date(), location:"Getting in the car",priority:"None",title:"wtf",note:"wtfnote"),detail_info(date:Date(),time: Date(), location:"Getting in the car",priority:"None",title:"wtf",note:"wtfnote")])]

    @State var now_list_show=2
    @State var now_list = 0
    @State var all_num = 0
    
    var body: some View {
        NavigationView{
            ZStack{
                Color(red: 0.949, green: 0.949, blue: 0.971).ignoresSafeArea()
                VStack{
                    HStack{
                        Image(systemName: "magnifyingglass").foregroundColor(.gray)
                        Text("Search").foregroundColor(.gray)
                        Spacer()
                    }
                    .padding(.horizontal,30)
                    .padding(.vertical,6)
                    .background(RoundedRectangle(cornerRadius: 7).fill(Color(red:0.9,green: 0.9,blue: 0.9)).frame(width: scwidth/1.14))
                    today_schedule
                    all
                    list
                        .frame(width:scwidth/1.03)
                }
                .offset(y:-scheight/15)
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        HStack{
                            Button(action: {new_reminder.toggle()}, label: {
                                HStack {
                                    Image(systemName: "plus.circle.fill").font(.system(size:20))
                                    Text("New Reminder").font(.system(size:17,weight:.semibold,design:.rounded))
                                }
                            })
                            Spacer()
                            Button(action: {add_list.toggle()}, label: {
                                Text("Add List")
                            })
                        }.sheet(isPresented: $add_list){addlist_page(cancel: $add_list,lists: $lists)}
                        .sheet(isPresented: $new_reminder){newreminder_page(cancel:$new_reminder,lists:$lists, now_list: $now_list)}
                    }
                }
            }
        }
    }

    var list:some View{
        List{
            Section(header: Text("My Lists")){
                ForEach(0..<lists.count){index in
                    
                    NavigationLink(destination: reminders_page){
                        //Button(action: {now_list_show=index}, label: {
                        HStack{
                            Image(systemName: "list.bullet.circle.fill").foregroundColor(lists[index].list_color).font(.largeTitle).offset(x:-scwidth/40)
                            Text(lists[index].list_name).offset(x:-scwidth/40).font(.subheadline)
                            Spacer()
                            Text(String(lists[index].list_num)).foregroundColor(.gray).fontWeight(.medium)
                        }
                    //})
                    }.onTapGesture(perform: {now_list_show=index})
                }.onDelete { deletelist(at :$0) }
                .onMove { movelist(from: $0, to: $1) }
            }
        }.toolbar { EditButton() }
        
    }
    
    func deletelist(at offset: IndexSet) {
        lists.remove(atOffsets: offset)
    }
    
    func movelist(from source: IndexSet, to destination: Int) {
        lists.move(fromOffsets: source, toOffset: destination)
    }
    
    var today_schedule:some View{
        HStack{
            NavigationLink(destination: scheduled_page){
                ZStack{
                    Rectangle().fill(.white)
                        .cornerRadius(20)
                        .frame(width: scwidth/2.5, height: scheight/10)
                        .padding(scwidth/35)
                    Image(systemName: "calendar.circle.fill")
                        .foregroundColor(.red)
                        .font(.largeTitle)
                        .offset(x:-scwidth/8,y:-scheight/55)
                    Text("Scheduled").font(.subheadline).foregroundColor(.gray).bold().offset(x:-scwidth/15,y:scheight/35)
                    Text("0").font(.title).bold()
                        .offset(x:scwidth/8,y:-scheight/50)
                }
            }.foregroundColor(.black)
            NavigationLink(destination: today_page){
                ZStack{
                    Rectangle()
                        .fill(.white)
                        .cornerRadius(20)
                        .frame(width: scwidth/2.5, height: scheight/10)
                        .padding(scwidth/35)
                    Image(systemName: "calendar.circle.fill")
                        .foregroundColor(.blue)
                        .font(.largeTitle)
                        .offset(x:-scwidth/8,y:-scheight/55)
                    Text("Today").font(.subheadline).foregroundColor(.gray).bold().offset(x:-scwidth/9,y:scheight/35)
                    Text("0").font(.title).bold()
                        .offset(x:scwidth/8,y:-scheight/50)
                }
            }.foregroundColor(.black)
        
        }
    }
    
    var all:some View{
        NavigationLink(destination: all_page){
            ZStack{
                Rectangle()
                    .fill(.white)
                    .cornerRadius(20)
                    .frame(width: scwidth/1.15, height: scheight/9)
                
                Image(systemName: "tray.circle.fill")
                    .foregroundColor(Color(red: 0.356, green: 0.385, blue: 0.415))
                    .font(.largeTitle)
                    .offset(x:-scwidth/2.8,y:-scheight/45)
                Text("All").font(.subheadline).foregroundColor(.gray).bold().offset(x:-scwidth/2.7,y:scheight/28)
                Text("0").font(.title).bold()
                    .offset(x:scwidth/2.7,y:-scheight/35)
            }
        }.foregroundColor(.black)
        
    }
    
    var all_page:some View{
        ScrollView([.vertical],showsIndicators: true) {
            //VStack{
                HStack{
                    Text("All").font(.system(size:35,weight:.bold,design:.rounded)).foregroundColor(Color(red: 0.356, green: 0.385, blue: 0.415)).padding(.horizontal,10)
                    Spacer()
                }
                
            //ForEach(0..<lists.count){i in
                Group{
                    HStack{
                        Text(lists[0].list_name).font(.system(size:20,weight:.bold,design:.rounded)).foregroundColor(lists[0].list_color).padding(.horizontal,15)
                        Spacer()
                    }
                    ForEach(lists[0].details){ detail in
                        HStack{
                            Spacer()
                            Button(action: {}, label: {
                                Circle().stroke(Color(red: 0.769, green: 0.768, blue: 0.782), lineWidth: 1.5).frame(width: 22, height: 22).padding(8)
                            })
                            VStack{
                                HStack{
                                    if (detail.priority=="High"){
                                        Text("!!!").foregroundColor(lists[0].list_color).font(.system(size: 16))
                                    }
                                    else if (detail.priority=="Medium"){
                                        Text("!!").foregroundColor(lists[0].list_color).font(.system(size: 16))
                                    }
                                    else if (detail.priority=="Low"){
                                        Text("!").foregroundColor(lists[0].list_color).font(.system(size: 16))
                                    }
                                    Text(detail.title).font(.system(size:17))
                                    Spacer()
                                }
                                HStack{
                                    Text(detail.note).font(.system(size:15)).foregroundColor(Color(red: 0.769, green: 0.768, blue: 0.782))
                                    Spacer()
                                }
                                HStack{
                                    Text("\(detail.date.formatted(date: .long, time: .omitted)),\(detail.time.formatted(date: .omitted, time: .shortened))").font(.system(size:15)).foregroundColor(Color(red: 0.769, green: 0.768, blue: 0.782))
                                    Spacer()
                                }
                                HStack{
                                    HStack{
                                    Image(systemName: "location.circle.fill").foregroundColor(.blue).font(.system(size:18))
                                    Text(detail.location).font(.system(size:14)).foregroundColor(.black)
                                    }
                                    .padding(.horizontal, 8)
                                    .padding(.vertical,1)
                                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(red: 0.929, green: 0.928, blue: 0.912)))
                                    Spacer()
                                }
                                Divider()
                            }
                        }
                    }
            
                    Image(systemName:"plus.circle.fill").font(.system(size:22)).foregroundColor(Color(red: 0.769, green: 0.768, blue: 0.782)).offset(x:-scwidth/2.29).padding(5)
                    Divider().frame(width: scwidth, height: 1).offset(x:-20).background(Color(red: 0.769, green: 0.768, blue: 0.782))
                
                }
                Group{
                    HStack{
                        Text(lists[1].list_name).font(.system(size:20,weight:.bold,design:.rounded)).foregroundColor(lists[1].list_color).padding(.horizontal,15)
                        Spacer()
                    }
                    ForEach(lists[1].details){ detail in
                        HStack{
                            Spacer()
                            Button(action: {}, label: {
                                Circle().stroke(Color(red: 0.769, green: 0.768, blue: 0.782), lineWidth: 1.5).frame(width: 22, height: 22).padding(8)
                            })
                            VStack{
                                HStack{
                                    if (detail.priority=="High"){
                                        Text("!!!").foregroundColor(lists[1].list_color).font(.system(size: 16))
                                    }
                                    else if (detail.priority=="Medium"){
                                        Text("!!").foregroundColor(lists[1].list_color).font(.system(size: 16))
                                    }
                                    else if (detail.priority=="Low"){
                                        Text("!").foregroundColor(lists[1].list_color).font(.system(size: 16))
                                    }
                                    Text(detail.title).font(.system(size:17))
                                    Spacer()
                                }
                                HStack{
                                    Text(detail.note).font(.system(size:15)).foregroundColor(Color(red: 0.769, green: 0.768, blue: 0.782)).multilineTextAlignment(.leading)
                                    Spacer()
                                }
                                HStack{
                                    Text("\(detail.date.formatted(date: .long, time: .omitted)),\(detail.time.formatted(date: .omitted, time: .shortened))").font(.system(size:15)).foregroundColor(Color(red: 0.769, green: 0.768, blue: 0.782))
                                    Spacer()
                                }
                                HStack{
                                    HStack{
                                    Image(systemName: "location.circle.fill").foregroundColor(.blue).font(.system(size:18))
                                    Text(detail.location).font(.system(size:14)).foregroundColor(.black)
                                    }
                                    .padding(.horizontal, 8)
                                    .padding(.vertical,1)
                                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(red: 0.929, green: 0.928, blue: 0.912)))
                                    Spacer()
                                }
                                Divider()
                            }
                        }
                    }
                        
            
                    Image(systemName:"plus.circle.fill").font(.system(size:22)).foregroundColor(Color(red: 0.769, green: 0.768, blue: 0.782)).offset(x:-scwidth/2.32).padding(5)
                    Divider().frame(width: scwidth, height: 1).offset(x:-20).background(Color(red: 0.769, green: 0.768, blue: 0.782))
                }
                
                Group{
                    HStack{
                        Text(lists[2].list_name).font(.system(size:20,weight:.bold,design:.rounded)).foregroundColor(lists[2].list_color).padding(.horizontal,15)
                        Spacer()
                    }
                    ForEach(lists[2].details){ detail in
                        HStack{
                            Spacer()
                            Button(action: {}, label: {
                                Circle().stroke(Color(red: 0.769, green: 0.768, blue: 0.782), lineWidth: 1.5).frame(width: 22, height: 22).padding(8)
                            })
                            VStack{
                                HStack{
                                    if (detail.priority=="High"){
                                        Text("!!!").foregroundColor(lists[2].list_color).font(.system(size: 16))
                                    }
                                    else if (detail.priority=="Medium"){
                                        Text("!!").foregroundColor(lists[2].list_color).font(.system(size: 16))
                                    }
                                    else if (detail.priority=="Low"){
                                        Text("!").foregroundColor(lists[2].list_color).font(.system(size: 16))
                                    }
                                    Text(detail.title).font(.system(size:17))
                                    Spacer()
                                }
                                HStack{
                                    Text(detail.note).font(.system(size:15)).foregroundColor(Color(red: 0.769, green: 0.768, blue: 0.782)).multilineTextAlignment(.leading)
                                    Spacer()
                                }
                                HStack{
                                    Text("\(detail.date.formatted(date: .long, time: .omitted)),\(detail.time.formatted(date: .omitted, time: .shortened))").font(.system(size:15)).foregroundColor(Color(red: 0.769, green: 0.768, blue: 0.782))
                                    Spacer()
                                }
                                HStack{
                                    HStack{
                                    Image(systemName: "location.circle.fill").foregroundColor(.blue).font(.system(size:18))
                                    Text(detail.location).font(.system(size:14)).foregroundColor(.black)
                                    }
                                    .padding(.horizontal, 8)
                                    .padding(.vertical,1)
                                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(red: 0.929, green: 0.928, blue: 0.912)))
                                    Spacer()
                                }
                                Divider()
                            }
                        }
                    }
                    Image(systemName:"plus.circle.fill").font(.system(size:22)).foregroundColor(Color(red: 0.769, green: 0.768, blue: 0.782)).offset(x:-scwidth/2.29).padding(5)
                    Divider().frame(width: scwidth, height: 1).offset(x:-20).background(Color(red: 0.769, green: 0.768, blue: 0.782))
                }
            //}
        }
        //.offset(x:20,y:-50)
        .toolbar{
            ToolbarItem(placement:.navigationBarTrailing){
                Menu(content: {
                    Button(action: {}, label: {
                        HStack{
                            Text("Select Reminders...")
                            Spacer()
                            Image(systemName: "checkmark.circle")
                        }
                    })
                    Button(action: {}, label: {
                        HStack{
                            Text("Show Completed")
                            Spacer()
                            Image(systemName: "eye")
                        }
                    })
                    Button(action: {}, label: {
                        HStack{
                            Text("Print")
                            Spacer()
                            Image(systemName: "printer")
                        }
                    })
                }, label: {
                    Image(systemName: "ellipsis.circle").font(.system(size:18)).foregroundColor(.blue)
                })
            }
        }
    }
    
    var scheduled_page:some View{
        ScrollView([.vertical],showsIndicators: true) {
            HStack{
                Text("Scheduled").font(.system(size:35,weight:.bold,design:.rounded)).foregroundColor(.red).padding(.horizontal,10)
                Spacer()
            }
//            ForEach(lists[1].details){ detail in
//                HStack{
//                    Text(detail.date.formatted(date: .long, time: .omitted)).font(.system(size:20,weight:.bold,design:.rounded)).foregroundColor(.black).padding(.horizontal,15)
//                    Spacer()
//                }
//                HStack{
//                    Spacer()
//                    Button(action: {}, label: {
//                        Circle().stroke(Color(red: 0.769, green: 0.768, blue: 0.782), lineWidth: 1.5).frame(width: 22, height: 22).padding(8)
//                    })
//                    VStack{
//                        HStack{
//                            if (detail.priority=="High"){
//                                Text("!!!").foregroundColor(lists[0].list_color).font(.system(size: 16))
//                            }
//                            else if (detail.priority=="Medium"){
//                                Text("!!").foregroundColor(lists[0].list_color).font(.system(size: 16))
//                            }
//                            else if (detail.priority=="Low"){
//                                Text("!").foregroundColor(lists[0].list_color).font(.system(size: 16))
//                            }
//                            Text(detail.title).font(.system(size:17))
//                            Spacer()
//                        }
//                        HStack{
//                            Text(detail.note).font(.system(size:15)).foregroundColor(Color(red: 0.769, green: 0.768, blue: 0.782))
//                            Spacer()
//                        }
//                        HStack{
//                            Text("\(detail.date.formatted(date: .long, time: .omitted)),\(detail.time.formatted(date: .omitted, time: .shortened))").font(.system(size:15)).foregroundColor(Color(red: 0.769, green: 0.768, blue: 0.782))
//                            Spacer()
//                        }
//                        HStack{
//                            HStack{
//                            Image(systemName: "location.circle.fill").foregroundColor(.blue).font(.system(size:18))
//                            Text(detail.location).font(.system(size:14)).foregroundColor(.black)
//                            }
//                            .padding(.horizontal, 8)
//                            .padding(.vertical,1)
//                            .background(RoundedRectangle(cornerRadius: 8).fill(Color(red: 0.929, green: 0.928, blue: 0.912)))
//                            Spacer()
//                        }
//                        Divider()
//
//                    }
//                }
//
//
//                Image(systemName:"plus.circle.fill").font(.system(size:22)).foregroundColor(Color(red: 0.769, green: 0.768, blue: 0.782)).offset(x:-scwidth/2.29).padding(5)
//                Divider().frame(width: scwidth, height: 1).offset(x:-20).background(Color(red: 0.769, green: 0.768, blue: 0.782))
//
//            }
//        }
//        .offset(y:-50)
//        .toolbar{
//            ToolbarItem(placement:.navigationBarTrailing){
//                Menu(content: {
//                    Button(action: {}, label: {
//                        HStack{
//                            Text("Select Reminders...")
//                            Spacer()
//                            Image(systemName: "checkmark.circle")
//                        }
//                    })
//                    Button(action: {}, label: {
//                        HStack{
//                            Text("Show Completed")
//                            Spacer()
//                            Image(systemName: "eye")
//                        }
//                    })
//                    Button(action: {}, label: {
//                        HStack{
//                            Text("Print")
//                            Spacer()
//                            Image(systemName: "printer")
//                        }
//                    })
//                }, label: {
//                    Image(systemName: "ellipsis.circle").font(.system(size:18)).foregroundColor(.blue)
//                })
//            }
        }
    }
    
    var reminders_page:some View{
        ScrollView([.vertical],showsIndicators: true) {
        VStack(alignment: .leading){
            HStack{
                Text(lists[now_list_show].list_name).font(.system(size:30,weight:.bold,design:.rounded)).foregroundColor(lists[now_list_show].list_color)
                Spacer()
            }
            ForEach(lists[now_list_show].details){ detail in
                HStack{
                    Spacer()
                    VStack{
                        Button(action: {}, label: {
                            Circle().stroke(Color(red: 0.769, green: 0.768, blue: 0.782), lineWidth: 1.5).frame(width: 22, height: 22)
                        })
                    }
                    VStack{
                        HStack{
                            if (detail.priority=="High"){
                                Text("!!!").foregroundColor(lists[now_list_show].list_color).font(.system(size: 16))
                            }
                            else if (detail.priority=="Medium"){
                                Text("!!").foregroundColor(lists[now_list_show].list_color).font(.system(size: 16))
                            }
                            else if (detail.priority=="Low"){
                                Text("!").foregroundColor(lists[now_list_show].list_color).font(.system(size: 16))
                            }
                            Text(detail.title).font(.system(size:17))
                            Spacer()
                        }
                        HStack{
                            Text(detail.note).font(.system(size:15)).foregroundColor(Color(red: 0.769, green: 0.768, blue: 0.782)).multilineTextAlignment(.leading)
                            Spacer()
                        }
                        HStack{
                            Text("\(detail.date.formatted(date: .long, time: .omitted)),\(detail.time.formatted(date: .omitted, time: .shortened))").font(.system(size:15)).foregroundColor(Color(red: 0.769, green: 0.768, blue: 0.782))
                            Spacer()
                        }
                        HStack{
                            HStack{
                            Image(systemName: "location.circle.fill").foregroundColor(.blue).font(.system(size:18))
                            Text(detail.location).font(.system(size:14)).foregroundColor(.black)
                            
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical,1)
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color(red: 0.929, green: 0.928, blue: 0.912)))
                            Spacer()
                        }

                        Divider()
                    }
                }
            }
        }.offset(x:20,y:-40)
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                HStack{
                    Button(action: {}, label: {
                        HStack {
                            Image(systemName: "plus.circle.fill").foregroundColor(lists[now_list_show].list_color).font(.system(size:20))
                            Text("New Reminder").foregroundColor(lists[now_list_show].list_color).font(.system(size:17,weight:.bold,design:.rounded))
                        }
                    })
                    Spacer()
                }
            }
        }
        .toolbar{
            ToolbarItem(placement:.navigationBarTrailing){
                Menu(content: {
                    Button(action: {}, label: {
                        HStack{
                            Text("Show List Info")
                            Spacer()
                            Image(systemName: "pencil")
                        }
                    })
                    Button(action: {}, label: {
                        HStack{
                            Text("Select Reminders...")
                            Spacer()
                            Image(systemName: "checkmark.circle")
                        }
                    })
                    Button(action: {}, label: {
                        HStack{
                            Text("Sort By")
                            Spacer()
                            Image(systemName: "arrow.up.arrow.down")
                        }
                    })
                    Button(action: {}, label: {
                        HStack{
                            Text("Show Completed")
                            Spacer()
                            Image(systemName: "eye")
                        }
                    })
                    Button(action: {}, label: {
                        HStack{
                            Text("Print")
                            Spacer()
                            Image(systemName: "printer")
                        }
                    })
                    Button(role: .destructive, action: {}) {
                        HStack{
                            Text("Delete List")
                            Spacer()
                            Image(systemName: "trash")
                        }
                    }
                }, label: {
                    Image(systemName: "ellipsis.circle").font(.system(size:18)).foregroundColor(.blue)
                })
            }
        }
    }
    
    var today_page:some View{
        ScrollView([.vertical],showsIndicators: true) {
            HStack{
                Text("Today").font(.system(size:30,weight:.bold,design:.rounded)).foregroundColor(lists[0].list_color).padding(.horizontal,15)
                Spacer()
            }
//            ForEach(lists[1].details){ detail in
//                HStack{
//                    Spacer()
//                    Button(action: {}, label: {
//                        Circle().stroke(Color(red: 0.769, green: 0.768, blue: 0.782), lineWidth: 1.5).frame(width: 22, height: 22).padding(8)
//                    })
//                    VStack{
//                        HStack{
//                            if (detail.priority=="High"){
//                                Text("!!!").foregroundColor(lists[1].list_color).font(.system(size: 16))
//                            }
//                            else if (detail.priority=="Medium"){
//                                Text("!!").foregroundColor(lists[1].list_color).font(.system(size: 16))
//                            }
//                            else if (detail.priority=="Low"){
//                                Text("!").foregroundColor(lists[1].list_color).font(.system(size: 16))
//                            }
//                            Text(detail.title).font(.system(size:17))
//                            Spacer()
//                        }
//                        HStack{
//                            Text(detail.note).font(.system(size:15)).foregroundColor(Color(red: 0.769, green: 0.768, blue: 0.782)).multilineTextAlignment(.leading)
//                            Spacer()
//                        }
//                        HStack{
//                            Text("\(detail.date.formatted(date: .long, time: .omitted)),\(detail.time.formatted(date: .omitted, time: .shortened))").font(.system(size:15)).foregroundColor(Color(red: 0.769, green: 0.768, blue: 0.782))
//                            Spacer()
//                        }
//                        HStack{
//                            HStack{
//                            Image(systemName: "location.circle.fill").foregroundColor(.blue).font(.system(size:18))
//                            Text(detail.location).font(.system(size:14)).foregroundColor(.black)
//                            }
//                            .padding(.horizontal, 8)
//                            .padding(.vertical,1)
//                            .background(RoundedRectangle(cornerRadius: 8).fill(Color(red: 0.929, green: 0.928, blue: 0.912)))
//                            Spacer()
//                        }
//                        Divider()
//                    }
//                }
//            }
//        }.offset(y:-50)
//        .toolbar {
//            ToolbarItem(placement: .bottomBar) {
//                HStack{
//                    Button(action: {}, label: {
//                        HStack {
//                            Image(systemName: "plus.circle.fill").foregroundColor(lists[0].list_color).font(.system(size:20))
//                            Text("New Reminder").foregroundColor(lists[0].list_color).font(.system(size:17,weight:.bold,design:.rounded))
//                        }
//                    })
//                    Spacer()
//                }
//            }
//        }
//        .toolbar{
//            ToolbarItem(placement:.navigationBarTrailing){
//                Menu(content: {
//                    Button(action: {}, label: {
//                        HStack{
//                            Text("Select Reminders...")
//                            Spacer()
//                            Image(systemName: "checkmark.circle")
//                        }
//                    })
//                    Button(action: {}, label: {
//                        HStack{
//                            Text("Sort By")
//                            Spacer()
//                            Image(systemName: "arrow.up.arrow.down")
//                        }
//                    })
//                    Button(action: {}, label: {
//                        HStack{
//                            Text("Print")
//                            Spacer()
//                            Image(systemName: "printer")
//                        }
//                    })
//                }, label: {
//                    Image(systemName: "ellipsis.circle").font(.system(size:18)).foregroundColor(.blue)
//                })
//            }
        }

    }
        
}

struct newreminder_page:View{
    @Binding var cancel:Bool//整体显示
    @State var title = ""
    @State var notes = ""
    @State var showingOptions = false
    let scwidth = UIScreen.main.bounds.width
    let scheight = UIScreen.main.bounds.height
    
    @Binding var lists:[list_info]
    @Binding var now_list:Int
    
   
    @State var date = Date()
    @State var time = Date()
    @State var location = "Current"
    @State var priorities = ["None","Low","Medium","High"]
    @State var prio_chosen = [true,false,false,false]
    @State var priority = "None"

    
    var body: some View{
        NavigationView{
            ZStack{
                Color(red: 0.949, green: 0.949, blue: 0.971).ignoresSafeArea()
                VStack{
                    Form {
                        Section{
                            TextField("Title", text: $title)
                            TextField("Notes", text: $notes)
                        }
                        Section{
                            NavigationLink(destination:details){
                                if(firstTime&&firstDate&&firstLocation){
                                    HStack{
                                        Text("Details")
                                        Spacer()
                                    }
                                }
                                else{
                                    VStack{
                                        HStack{
                                            Text("Details")
                                            Spacer()
                                        }
                                        HStack{
                                            if(!firstDate){
                                                Text(date.formatted( date:.long, time:.omitted)).foregroundColor(.gray).font(.system(size: 10))
                                            }
                                            if(!firstTime){
                                                Text("at").foregroundColor(.gray).font(.system(size: 10))
                                                Text(time.formatted( date:.omitted, time:.shortened)).foregroundColor(.gray).font(.system(size: 10))
                                            }
                                            if(!firstLocation){
                                                if(location=="Getting out of the car" || location=="Getting in the car"){
                                                    Image(systemName: "car.fill").foregroundColor(.gray).font(.system(size: 8))
                                                }
                                                Text(location).foregroundColor(.gray).font(.system(size: 10))
                                            }
                                            Spacer()
                                        }
                                    }
                                }
                            }
                        }.padding(5)
                        Section{
                            NavigationLink(destination:Lists){
                                HStack{
                                    Text("List")
                                    Spacer()
                                    Circle().fill(lists[now_list].list_color).frame(width: 8, height: 8)
                                    Text(lists[now_list].list_name).foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }.navigationTitle("New Reminder").navigationBarTitleDisplayMode(.inline)
                .offset(y:-scheight/30)
                
                .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Cancel"){
                                if (title != "" || notes != ""){showingOptions.toggle()}
                                else{cancel.toggle()}}
                                                .font(.system(size: 18))
                                .confirmationDialog(" ", isPresented: $showingOptions) {
                                    Button(role:.destructive, action: { cancel.toggle() }, label:{ Text("Discard Changes").foregroundColor(.red)})
                                    Button("Cancel", role: .cancel) { }
                                    }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Add"){
                                cancel.toggle()
                                lists[now_list].details.append(detail_info(date:date,time:time,location:location,priority:priority,title:title,note:notes))
                                lists[now_list].list_num=lists[now_list].list_num+1
                            }.font(.system(size: 18)).disabled((title=="" && notes==""))
                        }
                }
            }
        }
    }
    
    //@State var tmpdate = DateFormatter()
    
    @State var showingDate = true
    @State var showingTime = true
    @State var showingLocation = false
    @State var editingDate = false
    @State var editingTime = false
    @State var firstDate = true
    @State var firstTime = true
    @State var firstLocation = true
    @State var location_chosen = location_item(text: "Current", content: "Current", image: "location.circle.fill", color: Color(.gray))
    var location_items:[location_item]=[
        location_item(text: "Current", content: "Current", image: "location.circle.fill", color: Color(.gray)),
        location_item(text: "Getting in", content: "Getting in the car", image: "car.circle.fill", color: Color(red: -0.011, green: 0.473, blue: 0.978)),
        location_item(text: "Getting out", content: "Getting out of the car", image: "car.circle.fill", color: Color(red: -0.011, green: 0.473, blue: 0.978)),
        location_item(text: "Custom", content: "Custom", image: "ellipsis.circle.fill", color: Color(.gray))]
    
    
    var details:some View{
            
            Form {
                Section {
                    withAnimation(.spring()){
                    Button(action: {
                        if(editingDate){
                            showingDate.toggle()
                            firstDate=false
                        }
                    }, label: {
                        
                        Toggle(isOn:$editingDate){
                            if(!editingDate){
                                HStack{
                                    Image("mycalander").resizable().frame(width: 32, height: 32)
                                    Text("Date").foregroundColor(.black)
                                }
                            }
                            else{
                                HStack{
                                    Image("mycalander").resizable().frame(width: 32, height: 32)
                                    
                                    VStack{
                                        HStack{
                                            Text("Date").multilineTextAlignment(.leading).foregroundColor(.black)
                                            Spacer()
                                        }
                                        HStack{
                                            Text(date.formatted( date:.long, time:.omitted)).foregroundColor(.blue).font(.system(size: 10))
                                            Spacer()
                                        }
                                    
                                    }
                                }
                            }
                        }
                    
                    })
                    }
                    if ((editingDate&&firstDate)||(!firstDate&&showingDate&&editingDate)) {
                        withAnimation(.easeInOut(duration: 1.5)){
                        DatePicker("pick the date", selection: $date,displayedComponents: [.date]).datePickerStyle(GraphicalDatePickerStyle())
                        }
                    }
                    
                    
                    Button(action: {
                        if(editingTime){
                            showingTime.toggle()
                            firstTime=false
                        }
                    }, label: {Toggle(isOn:$editingTime){
                        if(!editingTime){
                            HStack{
                                Image("myclock").resizable().frame(width: 32, height: 32)
                                Text("Time").foregroundColor(.black)
                            }
                        }
                        else{
                            HStack{
                                Image("myclock").resizable().frame(width: 32, height: 32)
                                VStack{
                                    HStack{
                                        Text("Time").multilineTextAlignment(.leading).foregroundColor(.black)
                                        Spacer()
                                    }
                                    HStack{
                                        Text(time.formatted( date:.omitted, time:.shortened)).foregroundColor(.blue).font(.system(size: 10))
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }})

                    if ((editingTime&&firstTime)||(!firstTime&&showingTime&&editingTime)) {
                        DatePicker("pick the time", selection: $time,displayedComponents: [.hourAndMinute]).datePickerStyle(WheelDatePickerStyle())
                    }
                }.padding(5)
                
                Section{
                    VStack{
                        Toggle(isOn:$showingLocation){
                            HStack{
                                Image(systemName: "location.square.fill").font(.system(size: 25)).foregroundColor(.blue)
                                Text("Location")
                            }
                        }
                        if showingLocation{
                            HStack{
                                ForEach(location_items,id: \.self){item in
                                    VStack{
                                        Image(systemName: item.image).foregroundColor(item.color).font(.system(size: 44)).padding(1)
                                        if(location_chosen==item){
                                            Text(item.text)
                                                .font(.system(size: 12))
                                                .bold()
                                                .foregroundColor(.white)
                                                .padding(.horizontal,5)
                                                .background(RoundedRectangle(cornerRadius: 6).fill(.blue))
                                        }
                                        else{
                                            Text(item.text).font(.system(size: 12)).foregroundColor(.black)
                                        }
                                    }.onTapGesture(perform: {
                                        location=item.content
                                        location_chosen=item
                                        firstLocation=false
                                    })
                                }
                            }
                        }
                    }
                    if showingLocation{
                        HStack{
                            Text(location).foregroundColor(.gray)
                            Spacer()
                            Image(systemName: "info.circle").foregroundColor(.blue).font(.system(size: 15))
                        }
                    }
                    
                }.padding(5)
                Section{
                    NavigationLink(destination:priority_page){
                        HStack{
                            Text("Priority")
                            Spacer()
                            Text(priority).foregroundColor(.gray)
                        }
                    }
                }
            }.navigationTitle("Details").navigationBarTitleDisplayMode(.inline)
        
    }

    var priority_page :some View{
        Form{
            ForEach(priorities,id: \.self){item in
                Button(action: {priority=item}, label: {
                    HStack{
                        Text(item).offset(x:-scwidth/40).font(.subheadline).foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        if(priority==item){
                            Image(systemName: "checkmark").foregroundColor(.blue).font(.system(size: 13).bold())
                        }
                    }
                })
            }
        }.navigationTitle("Priority").navigationBarTitleDisplayMode(.inline)
    }
    
    var Lists:some View{
        ZStack{
            Color(.white).ignoresSafeArea()
            VStack{
                Text("Reminder will be created in \"\(lists[now_list].list_name)\" ." ).font(.system(size:16, weight:.bold, design: .rounded))
                ForEach(0..<lists.count){index in
                    Button(action: {
                        now_list=index
                        for i in 0..<lists.count{
                            lists[i].chosen=false
                        }
                        lists[index].chosen=true
                    }, label: {
                        VStack{
                            HStack{
                                Image(systemName: "list.bullet.circle.fill").foregroundColor(lists[index].list_color).font(.system(size:26)).offset(x:-scwidth/40)
                                Text(lists[index].list_name).offset(x:-scwidth/40).font(.subheadline).foregroundColor(.black)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                                if(lists[index].chosen==true){
                                    Image(systemName: "checkmark").foregroundColor(.blue).font(.system(size: 13).bold())
                                }
                            }
                            .padding(.vertical,4)
                            .frame(width: scwidth/1.15)
                            Divider().offset(x:scwidth/6)
                        }
                    })
                }
            }.offset(y:-scheight/3.5)
        }.navigationTitle("List").navigationBarTitleDisplayMode(.inline)
    }
}

struct addlist_page: View{
    @Binding var cancel :Bool
    @Binding var lists:[list_info]
    let scwidth = UIScreen.main.bounds.width
    let scheight = UIScreen.main.bounds.height
    @State private var listname=""
    @State private var showingOptions = false
    @State var listcolor = Color(red: -0.011, green: 0.473, blue: 0.978)
    //@State private var isEditing = true
    var choosecolor = [
        Color(red: 1.001, green: 0.23, blue: 0.186),
        Color(red: 0.998, green: 0.585, blue: -0.01),
        Color(red: 1.001, green: 0.799, blue: 0.006),
        Color(red: 0.097, green: 0.782, blue: 0.349),
        Color(red: -0.011, green: 0.473, blue: 0.978),
        Color(red: 0.751, green: 0.466, blue: 0.858),
        Color(red: 0.614, green: 0.52, blue: 0.387)]
    
    @State var chosen=[false,false,false,false,true,false,false]
    
    let columns = [GridItem(.adaptive(minimum: 45))]
    //@State var done_disabled = true
    
    
    var body: some View{
        NavigationView{
            ZStack{
                Color(red: 0.949, green: 0.949, blue: 0.971).ignoresSafeArea()
                
                VStack{
                    ZStack{
                        Rectangle()
                            .fill(.white)
                            .cornerRadius(20)
                            .frame(width: scwidth/1.1, height:scheight/4, alignment: .center)
                        Image(systemName: "list.bullet.circle.fill")
                            .shadow(radius: 4)
                            .font(.system(size: 78))
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.white, listcolor)
                            .offset(y:-scheight/23)
                        TextField("List Name", text: $listname)
                            .padding(50)
                            .background(Color(red: 0.894, green: 0.894, blue:0.903))
                            .foregroundColor(Color(red: 0.694, green: 0.694, blue: 0.711))
                            .font(.system(size: 20,weight: .bold, design: .rounded))
                            .mask(RoundedRectangle(cornerRadius: 15).frame(width: scwidth/1.25,height:50))
                            .offset(y:scheight/14)
                            .multilineTextAlignment(.center)
                            
                    }.position(x: scwidth/2, y:scheight/8)
                    ZStack{
                        Rectangle()
                            .fill(.white)
                            .cornerRadius(20)
                            .frame(width: scwidth/1.1, height:scheight/6)
                        LazyVGrid(columns: columns, spacing: scheight/50){
                            ForEach(0..<choosecolor.count){index in
                                Button(action: {
                                    listcolor=choosecolor[index]
                                    chosen=[false,false,false,false,false,false,false]
                                    chosen[index]=true
                                }){
                                    if(!chosen[index]){
                                        Circle().foregroundColor(choosecolor[index]).frame(width: 40, height: 40)
                                    }
                                    else{
                                        Image(systemName: "circle.inset.filled").symbolRenderingMode(.palette).foregroundStyle(choosecolor[index],Color(red: 0.850, green: 0.850, blue: 0.850)).font(.system(size: 40))
                                    }
                                }
                            }
                        }.padding(.horizontal,scheight/30)
                    }.position(x: scwidth/2,y:-scheight/15)
                }
                .navigationTitle("New List").navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    leading: Button("Cancel"){if (listname == ""){cancel.toggle()}
                        else{showingOptions.toggle()}}
                                        .font(.system(size: 18))
                        .confirmationDialog(" ", isPresented: $showingOptions) {
                            Button(role:.destructive, action: { cancel.toggle() }, label:{ Text("Discard Changes").foregroundColor(.red)})
                            
                            
                            Button("Cancel", role: .cancel) { }
                        } ,
                    trailing: Button("Done"){
                        cancel.toggle()
                        lists.append(list_info(list_color: listcolor, list_name: listname, list_num: 0, chosen:false,details:[]))
                    }.font(.system(size: 18)).disabled((listname=="")))
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
        }
    }
}
