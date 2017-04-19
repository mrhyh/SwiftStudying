//
//  ViewController.swift
//  SwiftButton
//
//  Created by ylgwhyh on 16/10/12.
//  Copyright © 2016年 com.ylgwhyh.SwiftButton. All rights reserved.
//

import UIKit


//协议和扩展
protocol ExampleProtocol {
    var simpleDescription: String { get }
    
    //协议的Mutating方法要求，允许在该方法内修改值类型
    mutating func adjust()
}


extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
}

extension Double: ExampleProtocol {
    internal var simpleDescription: String {
        return "\(abs(self))";
    }

    mutating  func adjust() {
        self += 1
    }
    
    var absoluteValue:String {
        return "The number absolute is  \(abs(self))"
    }
}

class ViewController: UIViewController {

    @IBAction func studyButton(_ sender: UIButton) {
        print("I am studying Swift...")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: TODO Test
        
        
        var testSBVC : SBVC = SBVC()
        
        testSBVC.calculation()
        print(testSBVC.calculation())
        print("测试=====\(testSBVC.Flat!)");
        
        
        self.testBaseData() //
        self.testGenericity()
        self.testBaseDataType() //基本数据类型
        self.basicOpeaators() //基本运算符
        self.collectionType() //集合类型
        print(7.simpleDescription)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func basicOpeaators() {
        
        // 区间运算符(Range Operators)
        for index in 1...5 {
            print("\(index) * 5 = \(index * 5)")
        }
        // 1 * 5 = 5
        // 2 * 5 = 10
        // 3 * 5 = 15
        // 4 * 5 = 20
        // 5 * 5 = 25
        
        //半开区间运算符
        
        let names = ["Anna", "Alex", "Brian", "Jack"]
        let count = names.count
        for i in 0..<count {
            print("第 \(i + 1) 个人叫 \(names[i])") }
        // 第 1 个人叫 Anna 
        // 第 2 个人叫 Alex 
        // 第 3 个人叫 Brian 
        // 第 4 个人叫 Jack

        // MARK: 字符串和字符(Strings and Characters)
        
        var emptyString = "" // 空字符串字面量 var anotherEmptyString = String() // 初始化方法

        // 字符串可变性
        var variableString = "Horse"
        variableString += " and carriage"
        // variableString 现在为 "Horse and carriage"
        let constantString = "Highlander"
        //constantString += " and another Highlander" //这样就会报错
        // 这会报告一个编译错误 (compile-time error) - 常量字符串不可以被修改。
        
        //使用字符 您可通过 for-in 循环来遍历字符串中的 characters 属性来获取每一个字符的值:
        for character in "Dog!?".characters {
            print(character)
        }
        // D
        // o
        // g
        // !
        // ?
    
        
        // Character数组
        let catCharacters: [Character] = ["C", "a", "t", "!", "?"]
        let catString = String(catCharacters)
        print(catString)
        // 打印输出:"Cat!?"
        
        // 连接字符串和字符
        let string1 = "hello"
        let string2 = " there"
        var welcomde = string1 + string2 // welcome 现在等于 "hello there"
        
        var instruction = "look over"
        instruction += string2
        // instruction 现在等于 "look over there"
        
        // var字符串是不可以append的
        let exclamationMark: Character = "!"
        welcomde.append(exclamationMark)
        // welcome 现在等于 "hello there!"
        

       // 字符串插值
        let multiplier = 3
        let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)" // message 是 "3 times 2.5 is 7.5"
        
        let unusualMenagerie = "Koala ?, Snail ?, Penguin ?, Dromedary ?"
        print("unusualMenagerie has \(unusualMenagerie.characters.count) characters") // 打印输出 "unusualMenagerie has 40 characters"
        
        
        
        let greeting = "Guten Tag!"
        greeting[greeting.startIndex]
        // G
        greeting[greeting.index(before: greeting.endIndex)]
        // !
        greeting[greeting.index(after: greeting.startIndex)]
        // u
        let index = greeting.index(greeting.startIndex, offsetBy: 7)
        greeting[index]
        // a
        
       // 试图获取越界索引对应的 Character ,将引发一个运行时错误。
//        greeting[greeting.endIndex] // error
//        greeting.index(after: endIndex) // error
        //使用 characters 属性的 indices 属性会创建一个包含全部索引的范围(Range),用来在一个字符串中访问单 个字符。
        for index in greeting.characters.indices {
            print("\(greeting[index]) ", terminator: "")
        }
        // 打印输出 "G u t e n T a g ! "
        
        
        // 插入和删除
        var welcome = "hello"
        welcome.insert("!", at: welcome.endIndex) // welcome 变量现在等于 "hello!"
        welcome.insert(contentsOf:" there".characters, at: welcome.index(before: welcome.endIndex)) // welcome 变量现在等于 "hello there!"

        welcome.remove(at: welcome.index(before: welcome.endIndex)) // welcome 现在等于 "hello there"
        let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
        welcome.removeSubrange(range)
        // welcome 现在等于 "hello"

        print()
        
    }
    
// MARK: 集合类型
    
    func collectionType () {
        //数组(Arrays)
        
        var someInts = [Int]()
        print("someInts is of type [Int] with \(someInts.count) items.") // 打印 "someInts is of type [Int] with 0 items."
        someInts.append(3)
        // someInts 现在包含一个 Int 值
        someInts = []
        // someInts 现在是空数组,但是仍然是 [Int] 类型的。
        
        var threeDoubles = Array(repeating: 0.0, count: 3)
        // threeDoubles 是一种 [Double] 数组,等价于 [0.0, 0.0, 0.0]
        
        var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
        // anotherThreeDoubles 被推断为 [Double],等价于 [2.5, 2.5, 2.5]
        var sixDoubles = threeDoubles + anotherThreeDoubles
        // sixDoubles 被推断为 [Double],等价于 [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]
        
        var shoppingList: [String] = ["Eggs", "Milk"] // shoppingList 已经被构造并且拥有两个初始项。
		var shoppingList2 = ["Eggs", "Milk"]
        
        
        if shoppingList.isEmpty {
            print("The shopping list is empty.")
        } else {
            print("The shopping list is not empty.")
        }
        // 打印 "The shopping list is not empty."(shoppinglist 不是空的)
        
        // 添加
        shoppingList.append("Flour")
        // shoppingList 现在有3个数据项,有人在摊煎饼
        
        // (+=赋值)
        shoppingList += ["Baking Powder"]
        // shoppingList 现在有四项了
        shoppingList += ["Chocolate Spread", "Cheese", "Butter"] // shoppingList 现在有七项了
        
        // 取值
        var firstItem = shoppingList[0] // 第一项是 "Eggs"
        
        // 修改值
        shoppingList[0] = "Six eggs"
        // 其中的第一项现在是 "Six eggs" 而不是 "Eggs"
        // 同时修改多个值
        shoppingList[4...6] = ["Bananas", "Apples"] // shoppingList 现在有6项

        // 插入值
        
        shoppingList.insert("Maple Syrup", at: 0) // shoppingList 现在有7项
        // "Maple Syrup" 现在是这个列表中的第一项
        
        // 移除
        let mapleSyrup = shoppingList.remove(at: 0)
        // 索引值为0的数据项被移除
        // shoppingList 现在只有6项,而且不包括 Maple Syrup
        // mapleSyrup 常量的值等于被移除数据项的值 "Maple Syrup"
        
        
        let apples = shoppingList.removeLast()
        // 数组的最后一项被移除了
        // shoppingList 现在只有5项,不包括 Apples
        // apples 常量的值现在等于 "Apples" 字符串
        
// 数组的遍历
        for item in shoppingList {
            print(item)
        }
        // Six eggs
        // Milk
        // Flour
        // Baking Powder
        // Bananas
        
        // 遍历并输出索引值
        for (index, value) in shoppingList.enumerated() {
            print("Item \(String(index + 1)): \(value)")
        }
        // Item 1: Six eggs
        // Item 2: Milk
        // Item 3: Flour
        // Item 4: Baking Powder
        // Item 5: Bananas
        
//  集合(Sets)   合(Set)用来存储 相同类型 并且没有确定顺序的值。当集合元素顺序不重要时或者希望确保每个元素只出现一次 时可以使用集合而不是数组。
        
        //  合类型的哈希值
        var letters = Set<Character>()
        print("letters is of type Set<Character> with \(letters.count) items.") // 打印 "letters is of type Set<Character> with 0 items."

        letters.insert("a")
        // letters 现在含有1个 Character 类型的值
        letters = []
        // letters 现在是一个空的 Set, 但是它依然是 Set<Character> 类型

        var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"] // favoriteGenres 被构造成含有三个初始值的 合
        
        // 一个 Set 类型不能从数组字面量中被单独推断出来,因此 Set 类型必须显式声明，除非已知数据类型全部一样。
        //var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]
        
//访问和修改一个集合
        print("I have \(favoriteGenres.count) favorite music genres.") // 打印 "I have 3 favorite music genres."
        if favoriteGenres.isEmpty {
            print("As far as music goes, I'm not picky.")
        } else {
            print("I have particular music preferences.")
        }
        // 打印 "I have particular music preferences."
        
        // 插入
        favoriteGenres.insert("Jazz")
        // favoriteGenres 现在包含4个元素
        
        // 移除
        if let removedGenre = favoriteGenres.remove("Rock") {
            print("\(removedGenre)? I'm over it.")
        } else {
            print("I never much cared for that.")
        }
        // 打印 "Rock? I'm over it."
        
        // 判断是否包含
        if favoriteGenres.contains("Funk") {
            print("I get up on the good foot.")
        } else {
            print("It's too funky in here.")
        }
        // 打印 "It's too funky in here."
// 遍历一个集合
        for genre in favoriteGenres {
            print("\(genre)")
        }
        // Classical
        // Jazz
        // Hip hop
        
        // 返回有序集合
        for genre in favoriteGenres.sorted() {
            print("(genre)")
        }
        // prints "Classical"
        // prints "Hip hop"
        // prints "Jazz

// 基本集合操作
        
        /*
        • 使用 intersection(_:) 方法根据两个 合中都包含的值创建的一个新的 合。
        • 使用 symmetricDifference(_:) 方法根据在一个 合中但不在两个 合中的值创建一个新的 合。
        • 使用 union(_:) 方法根据两个 合的值创建一个新的 合。
        • 使用 subtracting(_:) 方法根据不在该 合中的值创建一个新的 合。
        */
        
        
        let oddDigits: Set = [1, 3, 5, 7, 9]
        let evenDigits: Set = [0, 2, 4, 6, 8]
        let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
        oddDigits.union(evenDigits).sorted()
        // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        oddDigits.intersection(evenDigits).sorted()
        // []
        oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
        // [1, 9]
        oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()
        // [1, 2, 9]
        
// 集合成员关系和相等
        /*
        • 使用“是否相等”运算符( == )来判断两个 合是否包含全部相同的值。
        • 使用 isSubset(of:) 方法来判断一个 合中的值是否也被包含在另外一个 合中。
        • 使用 isSuperset(of:) 方法来判断一个 合中包含另一个 合中所有的值。
        • 使用 isStrictSubset(of:) 或者 isStrictSuperset(of:) 方法来判断一个 合是否是另外一个 合的子 合或 者父 合并且两个 合并不相等。
        • 使用 isDisjoint(with:) 方法来判断两个 合是否不含有相同的值(是否没有交 )。
        */
        
        let houseAnimals: Set = ["?", "?"]
        let farmAnimals: Set = ["?", "?", "?", "?", "?"]
        let cityAnimals: Set = ["?", "?"]
        houseAnimals.isSubset(of: farmAnimals)
        // true
        farmAnimals.isSuperset(of: houseAnimals)
        // true
        farmAnimals.isDisjoint(with: cityAnimals)
        // true
        
        print()
    }
    
// MARK: 整数
    func testBaseDataType () {
   	    let minValue = UInt8.min // minValue 为 0,是 UInt8 类型
        let maxValue = UInt8.max // maxValue 为 255,是 UInt8 类型
        
        //数值型字面量
        let decimalInteger = 17
        let binaryInteger = 0b10001   // 二进制的17
        let octalInteger = 0o21       // 八进制的17
        let hexadecimalInteger = 0x11 // 十六进制的17
        
        
        //数值类字面量可以包括额外的格式来增强可读性。整数和浮点数都可以添加额外的零并且包含下划线,并不会影响字面量:
        let paddedDouble = 000123.456
        let oneMillion = 1_000_000
        let justOverOneMillion = 1_000_000.000_000_1
        
        
        //整数转换
        //let cannotBeNegative: UInt8 = -1
        // UInt8 类型不能存储负数,所以会报错
        //let tooBig: Int8 = Int8.max + 1
        // Int8 类型不能存储超过最大值的数,所以会报错
        
        //类型转换
        let twoThousand: UInt16 = 2_000
        let one: UInt8 = 1
        let twoThousandAndOne = twoThousand + UInt16(one)
        
        //整数和浮点数转换
        let three = 3
        let pointOneFourOneFiveNine = 0.14159
        let pi = Double(three) + pointOneFourOneFiveNine // pi 等于 3.14159,所以被推测为 Double 类型
        
        let integerPi = Int(pi) // integerPi 等于 3,所以被推测为 Int 类型
        
        //类型别名
        typealias AudioSample = UInt16
        var maxAmplitudeFound = AudioSample.min // maxAmplitudeFound 现在是 0
        //本例中, AudioSample 被定义为 UInt16 的一个别名。因为它是别名, AudioSample.min 实际上是 UInt16.mi n ,所以会给 maxAmplitudeFound 赋一个初值 0 。
        
        //布尔值
        let orangesAreOrange = true
        let turnipsAreDelicious = false
        
        // MARK: 元组
        //元组(tuples)把多个值组合成一个复合值。元组内的值可以是任意类型,并不要求是相同类型。
        let http404Error = (404, "Not Found")
        // http404Error 的类型是 (Int, String),值是 (404, "Not Found")
        
        let (statusCode, statusMessage) = http404Error
        print("The status code is \(statusCode)")
        // 输出 "The status code is 404"
        print("The status message is \(statusMessage)") // 输出 "The status message is Not Found"
        
        // 如果你只需要一部分元组值,分解的时候可以把要忽略的部分用下划线( _ )标记:
        let (justTheStatusCode, _) = http404Error
        print("The status code is \(justTheStatusCode)") // 输出 "The status code is 404"
        
        // 此外,你还可以通过下标来访问元组中的单个元素,下标从零开始:
        print("The status code is \(http404Error.0)")
        // 输出 "The status code is 404"
        print("The status message is \(http404Error.1)") // 输出 "The status message is Not Found"
        
        
        let http200Status = (statusCode: 200, description: "OK")  //给元组中的元素命名后,你可以通过名字来获取这些元素的值:
        print("The status code is \(http200Status.statusCode)")
        // 输出 "The status code is 200"
        print("The status message is \(http200Status.description)") // 输出 "The status message is OK"
        
        
        //可选类型
        // 使用可选类型(optionals)来处理值可能缺失的情况。可选类型表示: • 有值,等于 x 或者 • 没有值
        //下面的例子使用这种构造器来尝试将一个 String 转换成 Int :
        let possibleNumber = "123"
        let convertedNumber = Int(possibleNumber)
        // convertedNumber 被推测为类型 "Int?", 或者类型 "optional Int"
        
        
        
        //nil
        //你可以给可选变量赋值为 nil 来表示它没有值:
        var serverResponseCode: Int? = 404
        // serverResponseCode 包含一个可选的 Int 值 404 
        serverResponseCode = nil
        // serverResponseCode 现在不包含值
        
        
        //注意:nil 不能用于非可选的常量和变量。如果你的代码中有常量或者变量需要处理值缺失的情况,请把它们声明成对应的可选类型。如果你声明一个可选常量或者变量但是没有赋值,它们会自动被设置为 nil :
        var surveyAnswer: String?
        // surveyAnswer 被自动设置为 nil
        //注意:Swift 的 nil 和 Objective-C 中的 nil 并不一样。在 Objective-C 中, nil 是一个指向不存在对象的指 针。在 Swift 中, nil 不是指针——它是一个确定的值,用来表示值缺失。任何类型的可选状态都可以被设 置为 nil ,不只是对象类型
        
        //强制解析
        
        if convertedNumber != nil {
            print("convertedNumber contains some integer value.")
        }
        // 输出 "convertedNumber contains some integer value."
        //当你确定可选类型确实包含值之后,你可以在可选的名字后面加一个感叹号( ! )来获取值。这个惊叹号表 示“我知道这个可选有值,请使用它。”这被称为可选值的强制解析(forced unwrapping):
        if convertedNumber != nil {
            print("convertedNumber has an integer value of \(convertedNumber!).")
        }
        // 输出 "convertedNumber has an integer value of 123."
        
        // MARK: 可选绑定
//        if let constantName = someOptional {
//            statements
//        }
        //你可以像上面这样使用可选绑定来重写 possibleNumber 这个例子 (页 0):
        if let actualNumber = Int(possibleNumber) {
            print("\'\(possibleNumber)\' has an integer value of \(actualNumber)")
        } else {
            print("\'\(possibleNumber)\' could not be converted to an integer")
        }
        // 输出 "'123' has an integer value of 123"
        
        if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
        // 输出 "4 < 42 < 100"
        if let firstNumber = Int("4") {
            if let secondNumber = Int("42") {
                if firstNumber < secondNumber && secondNumber < 100 {
                    print("\(firstNumber) < \(secondNumber) < 100")
                } }
        }
        // 输出 "4 < 42 < 100"
        
        //隐式解析可选类型
        
        //一个隐式解析可选类型其实就是一个普通的可选类型,但是可以被当做非可选类型来使用,并不需要每次都使用 解析来获取可选值。下面的例子展示了可选类型 String 和隐式解析可选类型 String 之间的区别:
        let possibleString: String? = "An optional string."
        let forcedString: String = possibleString! // 需要感叹号来获取值
        let assumedString: String! = "An implicitly unwrapped optional string."
        let implicitString: String = assumedString // 不需要感叹号
        //你可以把隐式解析可选类型当做一个可以自动解析的可选类型。你要做的只是声明的时候把感叹号放到类型的结尾,而不是每次取值的可选名字的结尾。注意:如果你在隐式解析可选类型没有值的时候尝试取值,会触发运行时错误。和你在没有值的普通可选类型后面加一个惊叹号一样。你仍然可以把隐式解析可选类型当做普通可选类型来判断它是否包含值:
        if assumedString != nil {
            print(assumedString)
        }
        // 输出 "An implicitly unwrapped optional string."
        //你也可以在可选绑定中使用隐式解析可选类型来检查并解析它的值:
       if let definiteString = assumedString {
            print(definiteString)
        }
        // 输出 "An implicitly unwrapped optional string."
        //注意:如果一个变量之后可能变成 nil 的话请不要使用隐式解析可选类型。如果你需要在变量的生命周期中判断是否 是 nil 的话,请使用普通可选类型。
        
        
        //错误处理
        func canThrowAnError() throws { // 这个函数有可能抛出错误
        }
        
        do {
            try canThrowAnError() // 没有错误消息抛出
        } catch {
            // 有一个错误消息抛出
        }
        
        /*
        //这里有一个错误处理如何用来应对不同错误条件的例子。
        func makeASandwich() throws {
            // ...
        }
        do {
            try makeASandwich()
            eatASandwich()
        } catch SandwichError.outOfCleanDishes {
            washDishes()
        } catch SandwichError.missingIngredients(let ingredients) {
            buyGroceries(ingredients)
        }
 		*/
        
        //断言
        //使用断言进行调试
        let age = -3
        //assert(age >= 0, "A person's age cannot be less than zero") // 因为 age < 0,所以断言会触发
        //如果不需要断言信息,可以省略,就像这样: assert(age >= 0)
        
        // 比较字符串
        
        let quotation = "We're a lot alike, you and I."
        let sameQuotation = "We're a lot alike, you and I."
        if quotation == sameQuotation {
            print("These two strings are considered equal")
        }
        // 打印输出 "These two strings are considered equal"
        
        
        //前缀/后缀相等
        
        let romeoAndJuliet = [
            "Act 1 Scene 1: Verona, A public place",
            "Act 1 Scene 2: Capulet's mansion",
            "Act 1 Scene 3: A room in Capulet's mansion",
            "Act 1 Scene 4: A street outside Capulet's mansion",
            "Act 1 Scene 5: The Great Hall in Capulet's mansion",
            "Act 2 Scene 1: Outside Capulet's mansion",
            "Act 2 Scene 2: Capulet's orchard",
            "Act 2 Scene 3: Outside Friar Lawrence's cell",
            "Act 2 Scene 4: A street in Verona",
            "Act 2 Scene 5: Capulet's mansion",
            "Act 2 Scene 6: Friar Lawrence's cell"
        ]
        

        //您可以调用 hasPrefix(_:) 方法来计算话剧中第一幕的场景数:
        var act1SceneCount = 0
        for scene in romeoAndJuliet {
            if scene.hasPrefix("Act 1 ") {
                act1SceneCount += 1
            } }
        print("There are \(act1SceneCount) scenes in Act 1") // 打印输出 "There are 5 scenes in Act 1"
        //相似地,您可以用 hasSuffix(_:) 方法来计算发生在不同地方的场景数:
        var mansionCount = 0
        var cellCount = 0
        for scene in romeoAndJuliet {
            if scene.hasSuffix("Capulet's mansion") {
                mansionCount += 1
            } else if scene.hasSuffix("Friar Lawrence's cell") {
                cellCount += 1
            } }
        print("\(mansionCount) mansion scenes; \(cellCount) cell scenes") // 打印输出 "6 mansion scenes; 2 cell scenes"

        //hasPrefix(_:) 和 hasSuffix(_:) 方法都是在每个字符串中逐字符比较其可扩展的字符群 是否标准相等,详细,在比较字符串时也是。
        print()
        
    }
    
// MARK: 泛型
    
    func testGenericity() {
       
        // 在尖括号里写一个名字来创建一个泛型函数或者类型。
        func repeatItem<Item>(repeating item: Item, numberOfTimes: Int) -> [Item] {
            var result = [Item]()
            for _ in 0..<numberOfTimes {
                result.append(item)
            }
            return result
        }
        //repeatItem(repeating: "knock", numberOfTimes:4)
        
        // 重新实现 Swift 标准库中的可选类型\
        enum OptionalValue<Wrapped> {
            case None
            case Some(Wrapped)
        }
        var possibleInteger: OptionalValue<Int> = .None
        possibleInteger = .Some(100)
        
        
        func anyCommonElements<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> Bool
            where T.Iterator.Element: Equatable, T.Iterator.Element == U.Iterator.Element {
                for lhsItem in lhs {
                    for rhsItem in rhs {
                        if lhsItem == rhsItem {
                            return true
                        } }
                }
                return false
        }
        let anyCommonElementsResultBool = anyCommonElements([1, 2, 3], [3])
        
        
        // MARK: TODO 例题未完成
    }
    
    //测试基本数据类型
    func testBaseData() {
        var myVariable = 42
        myVariable = 50
        let myConstant = 42
        let testFloat:Float = 4.0
        
        let implicitInteger = 70
        let implicitDouble = 70.0
        let explicitDouble: Double = 70
        
        let label = "The width is"
        let width = 94
        let widthLabel = label + String(width)
        
        
        //数组和字典
        let apples = 3
        let oranges = 5
        let appleSummary = "I have \(apples) apples."
        let fruitSummary = "I have \(apples + oranges) pieces of fruit."
        let testName:Float = 26.0
        let myAge = "I am a \(testName) man."
        
        
        var shoppingList = ["catfish", "water", "tulips", "blue paint"]
        shoppingList[1] = "bottle of water"
        var occupations = [
            "Malcolm": "Captain",
            "Kaylee": "Mechanic",
            ]
        occupations["Jayne"] = "Public Relations"
        
        
        let emptyArray = [String]()
        let emptyDictionary = [String: Float]()
        
        //控制流
        let individualScores = [75, 43, 103, 87, 12]
        var teamScore = 0
        for score in individualScores {
            if score > 50 {
                teamScore += 3
            } else {
                teamScore += 1
            } }
        print(teamScore)
        
        var optionalString: String? = "Hello"
        print(optionalString == nil)
        //var optionalName: String? = "John Appleseed"
        var optionalName: String? = nil;
        var greeting = "Hello!"
        if (optionalName == nil) {
            greeting = "test"
        }
        if let name = optionalName {
            greeting = "Hello, \(name)"
        }
        
        let nickName: String? = nil
        let fullName: String = "John Appleseed"
        let informalGreeting = "Hi \(nickName ?? fullName)"

        //switch
        
        let vegetable = "red pepper"
        switch vegetable {
        case "celery":
            print("Add some raisins and make ants on a log.")
        case "cucumber", "watercress":
            print("That would make a good tea sandwich.")
        case let x where x.hasSuffix("pepper"):
            print("Is it a spicy \(x)?")
        default:
            print("Everything tastes good in soup.")
            
        }
        
        let interestingNumbers = [
            "Prime": [2, 3, 5, 7, 11, 13],
            "Fibonacci": [1, 1, 2, 3, 5, 8],
            "Square": [1, 4, 9, 16, 25],
            ]
        var largest = 0
        var largestKind:String = ""
        for (kind, numbers) in interestingNumbers {
            for number in numbers {
                if number > largest {
                    largest = number
                    largestKind = kind;
                }
            } }
        print(largest,largestKind)
        
        
        var n = 2
        while n < 100 {
            n=n*2
        }
        print(n)
        var m = 2
        repeat {
            m=m*2
        } while m < 100
        print(m)
        
        var total = 0
        for i in 0..<4 {
            total += i }
        print(total)
        
        //函数和闭包
        func greet(person: String, day: String) -> String {
            return "Hello \(person), today is \(day)."
        }
        print(greet(person:"Bob", day: "Tuesday"))
        
        
        func greet2(person: String, meal: String) -> String {
            return "Hello \(person), today is \(meal)."
        }

        print(greet2(person:"Bob", meal: "大米"))
        
        // _ 表示不使用参数标签。
        func greet3(_ person: String, on day: String) -> String {
            return "Hello \(person), today is \(day)."
        }
        print(greet3("John", on: "Wednesday"))
        
        
        
        //使用元组来让一个函数返回多个值。该元组的元素可以用名称或数字来表示。
        func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
            var min = scores[0]
            var max = scores[0]
            var sum = 0
            for score in scores {
                if score > max {
                    max = score
                } else if score < min {
                    min = score }
                sum += score }
            return (min, max, sum)
        }
        let statistics = calculateStatistics(scores:[5, 3, 100, 3, 9])
        print(statistics.sum)
        print(statistics.2)
        
        //函数可以带有可变个数的参数,这些参数在函数内表现为数组的形式:
        func sumOf(numbers: Int...) -> Int {
            var sum = 0
            for number in numbers {
                sum += number
            }
            return sum }
        sumOf()
        sumOf(numbers: 42, 597, 12)
        
        
        //写一个计算参数平均值的函数。
        func average(numbers:Float...) -> Float {
            var sum:Float = 0.0
            for number in numbers {
                sum += number
            }
            return sum/Float(numbers.count)
        }
        print(average(numbers: 1,2,3))
        
        //函数可以嵌套
        func returnFifteen() -> Int {
            var y = 10
            func add() {
                y += 5
            }
            add()
            return y
        }
        returnFifteen()
        
        //没看懂
        //函数是第一等类型,这意味着函数可以作为另一个函数的返回值。
        func makeIncrementer() -> ((Int) -> Int) {
            func addOne(number: Int) -> Int {
                return 1 + number
            }
            return addOne
        }
        var increment = makeIncrementer()
        print(increment(7))
        
        //函数也可以当做参数传入另一个函数。
        func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
            for item in list {
                if condition(item) {
                    return true
                } }
            return false
        }
        func lessThanTen(number: Int) -> Bool {
            return number < 10
        }
        var numbers = [20, 19, 7, 12]
        hasAnyMatches(list: numbers, condition: lessThanTen)
        
        
        numbers.map({
            (number: Int) -> Int in
            let result = 3 * number
            return result
        })
        
        numbers.map({
            (number: Int) -> Int in
            if (number%2 == 0) {
                return 0
            }else {
                return 1
            }
        })
        
        //没看懂
        let sortedNumbers = numbers.sort { $0 > $1 }
        print(sortedNumbers)

        //对象和类
        class Shape {
            var numberOfSides = 0
            func simpleDescription() -> String {
                return "A shape with \(numberOfSides) sides."
            }
        }
        
        class Shape1 {
            var numberOfSides = 0
            func simpleDescription(string:String) -> String {
                return "A shape with \(numberOfSides) sides."
            }
        }
        
        var shape = Shape()
        shape.numberOfSides = 7
        var shapeDescription = shape.simpleDescription()
        
        //这个版本的 Shape 类缺少了一些重要的东西:一个构造函数来初始化类实例。使用 init 来创建一个构造器。
        class NamedShape {
            var numberOfSides: Int = 0
            var name: String
            init(name: String) {
                self.name = name
            }
            func simpleDescription() -> String {
                return "A shape with \(numberOfSides) sides."
            }
        }
        
        class Square: NamedShape {
            var sideLength: Double
            init(sideLength: Double, name: String) {
                self.sideLength = sideLength
                super.init(name: name)
                numberOfSides = 4
            }
            func area() ->  Double {
                return sideLength * sideLength
            }
            override func simpleDescription() -> String {
                return "A square with sides of length \(sideLength)."
            }
        }
        
        let test = Square(sideLength: 5.2, name: "my test square")
        print(test.area())
        print(test.simpleDescription())

        
        class Circle:NamedShape {
            var radius:Double
            init(name: String, radius:Double) {
                
                self.radius = radius
                super.init(name: name)
            }
            
            func area() -> Double {
                return radius * radius
            }
            
            override func simpleDescription() -> String {
                return "A square with sides of length \(radius)."
            }
        }
        
        let testCircle = Circle(name:"my test area", radius:10)
        print(testCircle.area())
        print(testCircle.simpleDescription())
        
        class EquilateralTriangle: NamedShape {
            var sideLength: Double = 0.0
            init(sideLength: Double, name: String) {
                self.sideLength = sideLength
                super.init(name: name)
                numberOfSides = 3
            }
            
            var perimeter: Double {
                get {
                    return 3.0 * sideLength
                }
                set { //在 perimeter 的 setter 中,新值的名字是 newValue 。你可以在 set 之后显式的设置一个名字。
                    sideLength = newValue / 3.0
                } }
            override func simpleDescription() -> String {
                return "An equilateral triagle with sides of length \(sideLength)."
            } }
        var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
        print(triangle.perimeter)
        triangle.perimeter = 9.9
        print(triangle.sideLength)
        
        class TriangleAndSquare {
            var triangle: EquilateralTriangle {
                willSet {
                    square.sideLength = newValue.sideLength
                } }
            var square: Square {
                willSet {
                    triangle.sideLength = newValue.sideLength
                }
            }
            init(size: Double, name: String) {
                square = Square(sideLength: size, name: name)
                triangle = EquilateralTriangle(sideLength: size, name: name)
            }
        }
        var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
        print(triangleAndSquare.square.sideLength)
        print(triangleAndSquare.triangle.sideLength)
        triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
        print(triangleAndSquare.triangle.sideLength)
        
        
        let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")
        let sideLength = optionalSquare?.sideLength
        
        //枚举和结构体
        enum Rank: Int {
            case Ace = 1
            case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
            case Jack, Queen, King
            func simpleDescription() -> String {
                switch self {
                case .Ace:
                    return "ace"
                case .Jack:
                    return "jack"
                case .Queen:
                    return "queen"
                case .King:
                    return "king"
                default:
                    return String(self.rawValue)
                }
            } }
        let ace = Rank.Ace
        //使用 rawValue 属性来访问一个枚举成员的原始值。
        let aceRawValue = ace.rawValue
        
        if let convertedRank = Rank(rawValue: 3) {
            let threeDescription = convertedRank.simpleDescription()
            print()
        }
        
        
        enum Suit {
            case Spades, Hearts, Diamonds, Clubs
            func simpleDescription() -> String {
                switch self {
                case .Spades:
                    return "spades"
                case .Hearts:
                    return "hearts"
                case .Diamonds:
                    return "diamonds"
                case .Clubs:
                    return "clubs"
                }
            }
            
            func color() -> String {
                switch self {
                case .Spades,.Clubs:
                    return "black"
                case .Hearts, .Diamonds:
                    return "red"
                default:
                    return ""
                }
            }
        }
        let hearts = Suit.Hearts
        let heartsDescription = hearts.simpleDescription()
        
        let colors = Suit.Hearts
        let colorsDescription = colors.color()
        

        
        enum ServerResponse {
            case Failure(String)
            case Test(String)
            case Result(String, String)
        }
        let success = ServerResponse.Result("6:00 am", "8:09 pm")
        let failure = ServerResponse.Failure("Out of cheese.")
        let testEnum = ServerResponse.Test("Test")
        switch success {
        case let .Failure(message):
            print("Failure...  \(message)")
        case let .Test(threee):
            print("Test ... \(test)")
        case let .Result(sunrise, sunset):
            let serverResponse = "Sunrise is at \(sunrise) and sunset is at \(sunset)."
            print()
        }
        
        
        //使用 struct 来创建一个结构体。结构体和类有很多相同的地方,比如方法和构造器。它们之间最大的一个区别就 是结构体是传值,类是传引用。
        struct Card {
            var rank: Rank
            var suit: Suit
            func simpleDescription() -> String {
                return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
            } }
        let threeOfSpades = Card(rank: .Three, suit: .Spades)
        let threeOfSpadesDescription = threeOfSpades.simpleDescription()
        
        
        
        //协议和扩展
        //类、枚举和结构体都可以实现协议。
        //协议在最上面
        class SimpleClass: ExampleProtocol {
            var simpleDescription: String = "A very simple class."
            var anotherProperty: Int = 69105
            func adjust() {
                simpleDescription += "  Now 100% adjusted."
            }
        }
        var a = SimpleClass()
        a.adjust()
        let aDescription = a.simpleDescription
        
        struct SimpleStructure: ExampleProtocol {
            var simpleDescription: String = "A simple structure"
            mutating func adjust() {
                simpleDescription += " (adjusted)"
            }
        }
        var b = SimpleStructure()
        b.adjust()
        let bDescription = b.simpleDescription
        
        enum SimpleEnum : Int {
            case Off, On
            //var simpleDescription: String = "A simple enum"
            mutating func adjust() {
                switch self {
                case .Off:
                    self = .On
                default:
                    self = .Off
                }
            }
        }
        var c = SimpleEnum.Off
        c.adjust() ////此时lightSwitch变成了OnOffSwitch.On
        switch c {
        case .On:
            print("开关On")
        case .Off:
            print("开关Off")
        default:
            print("default")
        }
        
        //扩展在最上面
		print(7.simpleDescription)
        print((-8.00).simpleDescription)
        
        
        let protocolValue: ExampleProtocol = a
        print(protocolValue.simpleDescription)
        //print(protocolValue.anotherProperty) // 去掉注释可以看到错误
        
        //错误处理
        
        enum PrinterError: Error {
            case OutOfPaper
            case NoToner
            case OnFire
        }
        
        func send(job: Int, toPrinter printerName: String) throws -> String {
            if printerName == "Never Has Toner" {
                throw PrinterError.NoToner
            }
            return "Job sent"
        }
        
        //有多种方式可以用来进行错误处理。一种方式是使用 do-catch 。在 do 代码块中,使用 try 来标记可以抛出错误 的代码。在 catch 代码块中,除非你另外命名,否则错误会自动命名为 error 。
        do {
            let printerResponse = try send(job: 1040, toPrinter: "Never Has Toner")
            print(printerResponse)
        } catch {
            print(error)
        }
        
        //可以使用多个 catch 块来处理特定的错误。参照 switch 中的 case 风格来写 catch 。
        do {
            let printerResponse = try send(job: 1440, toPrinter: "Gutenberg")
            print(printerResponse)
        } catch PrinterError.OnFire {
            print("I'll just put this over here, with the rest of the fire.")
        } catch let printerError as PrinterError {
            print("Printer error: \(printerError).")
        } catch {
            print(error)
        }
        
        
        //另一种处理错误的方式使用 try? 将结果转换为可选的。如果函数抛出错误,该错误会被抛弃并且结果为 ni l 。否则的话,结果会是一个包含函数返回值的可选值。
        let printerSuccess = try? send(job: 1884, toPrinter: "Mergenthaler")
        let printerFailure = try? send(job: 1885, toPrinter: "Never Has Toner")
        
        
        //使用 defer 代码块来表示在函数返回前,函数中最后执行的代码。无论函数是否会抛出错误,这段代码都将执 行。使用 defer ,可以把函数调用之初就要执行的代码和函数调用结束时的扫尾代码写在一起,虽然这两者的执 行时机截然不同。
        var fridgeIsOpen = false
        let fridgeContent = ["milk", "eggs", "leftovers"]
        func fridgeContains(_ food: String) -> Bool {
            fridgeIsOpen = true
            defer {
                fridgeIsOpen = false
            }
            let result = fridgeContent.contains(food)
            return result
        }
        fridgeContains("banana")
        print(fridgeIsOpen)
        
        
       // MARK:泛型
        //泛型
        print()
        
    }

}

