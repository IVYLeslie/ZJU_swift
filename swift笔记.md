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
