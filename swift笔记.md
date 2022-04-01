# swift笔记

## 语法

###### 变量常量，命名，类型

```swift
let b //常量
var a //变量

//命名非常随意，什么都可以

//变量/常量类型可以直接：加在后面
let a:double = 7.0
//类型可以强制转换
let widthLabel = label + String(width)

//struct中使用变量
@state var pressed = false 
```



###### 字符串

```swift
//在字符串中插入变量/常量，\()
let fruitSummary = "I have \(apples + oranges) pieces of fruit."

//多行文字，用"""表示
let quotation = """
I said "I have \(apples) apples."
And then I said "I have \(apples + oranges) pieces of fruit."
"""
```



###### 数组/字典

```

```



###### 修饰器



## 控件

###### button

```

```

###### 弹出的button组

```swift
import SwiftUI

struct ContentView: View {
    @State private var showingOptions = false
        @State private var selection = "None"

        var body: some View {
            VStack {
                Text(selection)

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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

```

![截屏2022-03-23 下午5.28.42](/Users/zyk/Desktop/截屏2022-03-23 下午5.28.42.png)











## 静态UI

### 颜色

###### 背景颜色

```swift
ZStack{
	Color.black.ignoresSafeArea()
  ……
}
```

###### 图形、字体颜色+透明度

```swift
.foregroundColor(Color.init(red: 120/256, green: 112/256, blue: 231/256).opacity(0.6))
.background(Color.init(red: 120/256, green: 112/256, blue: 231/256))
```





### 文字

###### 字体大小

```swift
.font()
```

###### 修饰

```
.bold()//加粗
.italic()//斜体
.underline(true,color:.black)//下划线
.fontWeight(.heavy)//加粗
```



### 形状

###### 使用形状

```

```



###### 修饰

```swift
//加渐变
LinearGradient(colors: [color1,color2], startPoint:
.bottomLeading, endPoint: .topTrailing)
.resizable())
//规定大小
.frame(width: 300, height: 200)
//套蒙版
.mask(Image(systemName: "cloud.fill")
//圆角
.cornerRadius(20)
.padding()


      
```



### 排版

###### 排列方式

```swift
VStack//竖排
HStack//横排
ZStack//叠加
```

###### 行间距

```swift
.lineSpacing(20)
```

###### 对齐方式

```
//多行对齐
.multilineTextAlignment(.center)
//单行对齐
.frame(width: 130, height: 130, alignment: .center)
```

###### 边距

```swift
.padding(.horizontal,1)
.padding(.vertical,1)
.padding(.top,1)
.padding(.bottom,1)
```

###### 字符之间间距/字距

```
.kerning(10)
```

### 布局

###### grid

lazygrid

###### List

```swift
//列表，这样写最多10个
List{
	Text()
	Button()
}

//这样写可以有10个以上
List{
  ForEach(0...9,id:\.self){ i in
  	Text("\(i)")
  }
}

//给list加上标题
List{
	Section(header: Text("head")){
		Text("1")
		Text("2")
	}
}

//同样是加标题，这样写省略section
NavigationView{
	List{
		Text("a")
		Text("b")
	}.navigationTitle("这是标题")
}
```

###### Form

```
Form{
	Text()
	Button()
}
//表格
```

###### tabview

###### sheetview



## 动态UI

### 跳转

```swift
//使用navigation进行跳转
NavigationView{
	VStack{
  	Text("body")
  	NavigationLink("come to homepage"){
  		homepage
    }.foregroundColor(color1)
  }
}
//跳转的页面
//自带back
var homepage:some View{
  List{
    Section(header: Text("这是标题")){
      Text("aaa")
      Text("bbb")
    }
  }
}
```



###### popover

### 手势

```
//直接置顶
Image("")
.resizable()
.aspectRatio(contentMode:.fit)
.frame(maxWidth:150,maxHeight:.ifinity,alignment:top)


//每次取反
@State var ishidden=false
Toggle("feixingmoshi", isOn:$ishidden)

//版本，注意不同版本兼容

//颜色选择器
@State var mycolor = Color(red:, green:, blue:)
ColorPicker("Start Color",selection:$mycolor)

//是否隐藏上方栏
.statusBar(hidden: true)

//时间选择器
DatePicker()
```



### 开发

###### userdefault





```swift
if(TodayReminders[index].Chosen == false)
{
  Image(systemName: "circle").font(.system(size: 25)).foregroundColor(Color(red: 193/256, green: 193/256, blue: 195/256)).onTapGesture {
    TodayReminders[index].Chosen.toggle()
  }
}
else{
  Image(systemName: "circle.inset.filled").font(.system(size: 25)).foregroundColor(.blue).onTapGesture {
    TodayReminders[index].Chosen
    .toggle()
  }
}
VStack(alignment: .leading){
  Text(TodayReminders[index].ItemName).foregroundColor(TodayReminders[index].Chosen ? .gray : .black)
  Text(TodayReminders[index].Catagory).foregroundColor(.gray).font(.system(size: 15))
}
```





```swift
struct ContentView: View{//主页面
	var body: some View{
    VStack{
      HStack{//searchbar 模块，使用hstack{image text}，加上roundedrectangle形状的background
        Image()
        Text()
      }
      today_schedule//并排的today、schedule两个模块
      all//all模块
      list//下方的lists模块
    }.toolbar{//底部工具栏
      Button("new reminder")//左下方new reminder的按钮，使用hstack{image text}的排版
      Button("add list")//右下方的add list按钮
    }
    .sheet(newreminder_page)//开启新建reminder的页面
    .sheet(addlist_page)//开启新建list的页面
  }
  
  
  var list:some View{//主页面list组件
    List{
      Foreach(list){//遍历所有的list
        navigation(destination:reminders_page){//每个list都跳转到reminders_page
          HStack{//横排
            Image
            Text(name)//list的name
            Text(number)//list中reminder的个数
          }
        }
    	}
      .onDelete { deletelist(at :$0) }//edit按钮的功能——删除该list
      .onMove { movelist(from: $0, to: $1) }//edit按钮的功能——移动list
    }.toolbar{editbutton}//右上方的edit按钮
  }
  
  
  var today_schedule:some View{//主页面today_schedule组件
    HStack{
      NavigationLink(destination:scheduled_page){
        ZStack{//scheduled
          Rectangle()
          Image()
          Text()
        }
        ZStack{//today
          Rectangle()
          Image()
          Text()
        }
      }
    }
  }
  
  var all:some View{//主页面all组件
    NavigationLink(destination:all_page){
      ZStack{//all
          Rectangle()
          Image()
          Text()
        }
    }
  }
  
}



struct newreminder_page:View{//这是添加reminder的页面
  var body: some View{//主页面
    VStack{
      Form{//使用Form-section模式
        Section{
          TextField()//title
          TextField()//note
        }
        Section{//details
          NavigationLink(destination:details){//跳转到details页面
            Text("Details")//如果已经选择了details的详细内容，会显示详细的内容小字
          }
        }
        Section{//list
          NavigationLink(destination:Lists){
            HStack{
              Text("List")
              Circle()
              Text()//所选择的list
            }
          }
        }
      }
    }
  }
  
  
  var 
  
}
```

