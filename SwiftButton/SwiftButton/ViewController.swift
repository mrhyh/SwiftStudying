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
        self.testBaseDataType()//基本数据类型
        self.basicOpeaators()  //基本运算符
        self.collectionType()  //集合类型
        self.controlFlow()     //控制流
        self.functions()       //函数
        self.Closures()        //闭包
        self.enumerations()    //枚举
        self.classAndStruct()  //类和结构体
        self.properties()      //属性
        self.methods()         //方法(Methods)
        self.subscriptTest()   //下标
        self.inherit()         //继承
        self.structure()       //构造过程
        
        
        
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
        
        
        
// MARK: 字典
        var namesOfIntegers = [Int: String]()
        // namesOfIntegers 是一个空的 [Int: String] 字典
        
        namesOfIntegers[16] = "sixteen"
        // namesOfIntegers 现在包含一个键值对
        namesOfIntegers = [:]
        // namesOfIntegers 又成为了一个 [Int: String] 类型的空字典
        
        var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
        var airports2 = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
        print("The dictionary of airports contains (airports.count) items.")
        // 打印 "The dictionary of airports contains 2 items."(这个字典有两个数据项)
        
        
        // 使用布尔属性 isEmpty 作为一个缩写形式去检查 count 属性是否为 0 :
        if airports.isEmpty {
            print("The airports dictionary is empty.")
        } else {
            print("The airports dictionary is not empty.")
        }
        // 打印 "The airports dictionary is not empty."
        
        airports["LHR"] = "London"
        // airports 字典现在有三个数据项
        airports["LHR"] = "London Heathrow"
        // "LHR"对应的值 被改为 "London Heathrow

        
        
        if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
            print("The old value for DUB was \(oldValue).")
        }
        // 输出 "The old value for DUB was Dublin."
        
        //作为另一种下标方法，字典的updateValue(_:forKey:)方法可以设置或者更新特定键对应的值。就像上面所示的下标示例，updateValue(_:forKey:)方法在这个键不存在对应值的时候会设置新值或者在存在时更新已存在的值。和上面的下标方法不同的，updateValue(_:forKey:)这个方法返回更新值之前的原值。这样使得我们可以检查更新是否成功。
        
        //updateValue(_:forKey:)方法会返回对应值的类型的可选值。举例来说：对于存储String值的字典，这个函数会返回一个String?或者“可选 String”类型的值。
        
        //如果有值存在于更新前，则这个可选值包含了旧值，否则它将会是nil。
        
        if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
            print("The old value for DUB was \(oldValue).")
        }
        // 输出 "The old value for DUB was Dublin."
        
        
        
        //我们也可以使用下标语法来在字典中检索特定键对应的值。因为有可能请求的键没有对应的值存在，字典的下标访问会返回对应值的类型的可选值。如果这个字典包含请求键所对应的值，下标会返回一个包含这个存在值的可选值，否则将返回nil。
        if let airportName = airports["DUB"] {
            print("The name of the airport is \(airportName).")
        } else {
            print("That airport is not in the airports dictionary.")
        }
        // 打印 "The name of the airport is Dublin Airport."
        
        
        
        //我们还可以使用下标语法来通过给某个键的对应值赋值为nil来从字典里移除一个键值对：
        
        airports["APL"] = "Apple Internation"
        // "Apple Internation" 不是真的 APL 机场, 删除它
        airports["APL"] = nil
        // APL 现在被移除了
        //此外，removeValue(forKey:)方法也可以用来在字典中移除键值对。这个方法在键值对存在的情况下会移除该键值对并且返回被移除的值或者在没有值的情况下返回nil：
        
        if let removedValue = airports.removeValue(forKey: "DUB") {
            print("The removed airport's name is \(removedValue).")
        } else {
            print("The airports dictionary does not contain a value for DUB.")
        }
        // prints "The removed airport's name is Dublin Airport."
        
// MARK: 字典遍历

        for (airportCode, airportName) in airports {
            print("\(airportCode): \(airportName)")
        }
        // YYZ: Toronto Pearson
        // LHR: London Heathrow
        
        // 通过访问keys或者values属性，我们也可以遍历字典的键或者值：
        for airportCode in airports.keys {
            print("Airport code: \(airportCode)")
        }
        // Airport code: YYZ
        // Airport code: LHR
        
        for airportName in airports.values {
            print("Airport name: \(airportName)")
        }
        // Airport name: Toronto Pearson
        // Airport name: London Heathrow
        
        
        // 如果我们只是需要使用某个字典的键集合或者值集合来作为某个接受Array实例的 API 的参数，可以直接使用keys或者values属性构造一个新数组：
        
        let airportCodes = [String](airports.keys)
        // airportCodes 是 ["YYZ", "LHR"]
        
        let airportNames = [String](airports.values)
        // airportNames 是 ["Toronto Pearson", "London Heathrow"]
        
// MARK: 排序 Swift 的字典类型是无序集合类型。为了以特定的顺序遍历字典的键或值，可以对字典的keys或values属性使用sorted()方法。
        print()
    }
    
// MARK: 控制流
    
    func controlFlow() {
        
// MARK: For
        let names = ["Anna", "Alex", "Brian", "Jack"]
        for name in names {
            print("Hello, \(name)!")
        }
        // Hello, Anna!
        // Hello, Alex!
        // Hello, Brian!
        // Hello, Jack!
        
        for index in 1...5 {
            print("\(index) times 5 is \(index * 5)")
        }
        // 1 times 5 is 5
        // 2 times 5 is 10
        // 3 times 5 is 15
        // 4 times 5 is 20
        // 5 times 5 is 25
        
        
        
        
        // 这个例子计算 base 这个数的 power 次幂（本例中，是 3 的 10 次幂），从 1（ 3 的 0 次幂）开始做 3 的乘法， 进行 10 次，使用 1 到 10 的闭区间循环。这个计算并不需要知道每一次循环中计数器具体的值，只需要执行了正确的循环次数即可。下划线符号 _ （替代循环中的变量）能够忽略当前值，并且不提供循环遍历时对值的访问。
        let base = 3
        let power = 10
        var answer = 1
        for _ in 1...power {
            answer *= base
        }
        print("\(base) to the power of \(power) is \(answer)")
        // 输出 "3 to the power of 10 is 59049"
        
        //在某些情况下，你可能不想使用闭区间，包括两个端点。在一个手表上每分钟绘制一个刻度线。要绘制 60 个刻度，从 0 分钟开始。使用半开区间运算符（..<）来包含下限，但不包括上限。有关区间的更多信息，请参阅区间运算符。
        
        let minutes = 60
        for tickMark in 0..<minutes {
            // 每1分钟呈现一个刻度线（60次）
        }
        
        //一些用户可能在其UI中可能需要较少的刻度。他们可以每5分钟作为一个刻度。使用 stride(from:to:by:) 函数跳过不需要的标记。
        
        let minuteInterval = 5
        for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
            // 每5分钟呈现一个刻度线 (0, 5, 10, 15 ... 45, 50, 55)
        }
        
        //可以在闭区间使用 stride(from:through:by:) 起到同样作用：
        let hours = 12
        let hourInterval = 3
        for tickMark in stride(from: 3, through: hours, by: hourInterval) {
            // 每3小时呈现一个刻度线 (3, 6, 9, 12)
        }

// MARK: While 循环
        
        // while循环从计算一个条件开始。如果条件为true，会重复运行一段语句，直到条件变为false。
        /*
        let finalSquare = 25
        var board = [Int](repeating: 0, count: finalSquare + 1)
        
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
        
        var square = 0
        var diceRoll = 0
        while square < finalSquare {
            // 掷骰子
            diceRoll += 1
            if diceRoll == 7 { diceRoll = 1 }
            // 根据点数移动
            square += diceRoll
            if square < board.count {
                // 如果玩家还在棋盘上，顺着梯子爬上去或者顺着蛇滑下去
                square += board[square]
            }
        }
        print("Game over!")
        */
        
        // while循环的另外一种形式是repeat-while，它和while的区别是在判断循环条件之前，先执行一次循环的代码块。然后重复循环直到条件为false。
        
        /*
        let finalSquare = 25
        var board = [Int](repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
        var square = 0
        var diceRoll = 0
        
        repeat {
            // 顺着梯子爬上去或者顺着蛇滑下去
            square += board[square]
            // 掷骰子
            diceRoll += 1
            if diceRoll == 7 { diceRoll = 1 }
            // 根据点数移动
            square += diceRoll
        } while square < finalSquare
        print("Game over!")
 		*/
 
// MARK: If
        
        var temperatureInFahrenheit = 90
        if temperatureInFahrenheit <= 32 {
            print("It's very cold. Consider wearing a scarf.")
        } else if temperatureInFahrenheit >= 86 {
            print("It's really warm. Don't forget to wear sunscreen.")
        } else {
            print("It's not that cold. Wear a t-shirt.")
        }
        // 输出 "It's really warm. Don't forget to wear sunscreen."
        
// MARK: Switch 
        let someCharacter: Character = "z"
        switch someCharacter {
        case "a":
            print("The first letter of the alphabet")
        case "z":
            print("The last letter of the alphabet")
        default:
            print("Some other character")
        }
        // 输出 "The last letter of the alphabet"
        
        let anotherCharacter: Character = "a"
        switch anotherCharacter {
        case "a", "A":
            print("The letter A")
        default:
            print("Not the letter A")
        }
        // 输出 "The letter A
        
// MARK: 区间匹配
        
        //case 分支的模式也可以是一个值的区间。下面的例子展示了如何使用区间匹配来输出任意数字对应的自然语言格式：
        
        let approximateCount = 62
        let countedThings = "moons orbiting Saturn"
        var naturalCount: String
        switch approximateCount {
        case 0:
            naturalCount = "no"
        case 1..<5:
            naturalCount = "a few"
        case 5..<12:
            naturalCount = "several"
        case 12..<100:
            naturalCount = "dozens of"
        case 100..<1000:
            naturalCount = "hundreds of"
        default:
            naturalCount = "many"
        }
        print("There are \(naturalCount) \(countedThings).")
        // 输出 "There are dozens of moons orbiting Saturn."
        
// MARK: 元组匹配
        //我们可以使用元组在同一个switch语句中测试多个值。元组中的元素可以是值，也可以是区间。另外，使用下划线（_）来匹配所有可能的值。
        //下面的例子展示了如何使用一个(Int, Int)类型的元组来分类下图中的点(x, y)：
        

        let somePoint = (1, 1)
        switch somePoint {
        case (0, 0):
            print("(0, 0) is at the origin")
        case (_, 0):
            print("(\(somePoint.0), 0) is on the x-axis")
        case (0, _):
            print("(0, \(somePoint.1)) is on the y-axis")
        case (-2...2, -2...2):
            print("(\(somePoint.0), \(somePoint.1)) is inside the box")
        default:
            print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
        }
        // 输出 "(1, 1) is inside the box"
        
// MARK: 值绑定（Value Bindings）
        
        // case 分支允许将匹配的值绑定到一个临时的常量或变量，并且在case分支体内使用 —— 这种行为被称为值绑定（value binding），因为匹配的值在case分支体内，与临时的常量或变量绑定。
        
        //下面的例子展示了如何在一个(Int, Int)类型的元组中使用值绑定来分类下图中的点(x, y)：
        let anotherPoint = (2, 0)
        switch anotherPoint {
        case (let x, 0):
            print("on the x-axis with an x value of \(x)")
        case (0, let y):
            print("on the y-axis with a y value of \(y)")
        case let (x, y):
            print("somewhere else at (\(x), \(y))")
        }
        // 输出 "on the x-axis with an x value of 2"
        
        
// MARK: Where 额外条件
        
        //case 分支的模式可以使用where语句来判断额外的条件。
        
        //下面的例子把下图中的点(x, y)进行了分类：
        
        let yetAnotherPoint = (1, -1)
        switch yetAnotherPoint {
        case let (x, y) where x == y:
            print("(\(x), \(y)) is on the line x == y")
        case let (x, y) where x == -y:
            print("(\(x), \(y)) is on the line x == -y")
        case let (x, y):
            print("(\(x), \(y)) is just some arbitrary point")
        }
        // 输出 "(1, -1) is on the line x == -y"
        
        
// MARK: 复合匹配
        
        let someCharacter1: Character = "e"
        switch someCharacter1 {
        case "a", "e", "i", "o", "u":
            print("\(someCharacter1) is a vowel")
        case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
             "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
            print("\(someCharacter1) is a consonant")
        default:
            print("\(someCharacter1) is not a vowel or a consonant")
        }
        // 输出 "e is a vowel"
        
        let stillAnotherPoint = (9, 0)
        switch stillAnotherPoint {
        case (let distance, 0), (0, let distance):
            print("On an axis, \(distance) from the origin")
        default:
            print("Not on an axis")
        }
        // 输出 "On an axis, 9 from the origin"
        
// MARK: 控制转移语句
        /*
        控制转移语句改变你代码的执行顺序，通过它可以实现代码的跳转。Swift 有五种控制转移语句：
        
        continue
        break
        fallthrough
        return
        throw
            我们将会在下面讨论continue、break和fallthrough语句。return语句将会在函数章节讨论，throw语句会在错误抛出章节讨论。
        */
        
        // continue
        let puzzleInput = "great minds think alike"
        var puzzleOutput = ""
        for character in puzzleInput.characters {
            switch character {
            case "a", "e", "i", "o", "u", " ":
                continue
            default:
                puzzleOutput.append(character)
            }
        }
        print(puzzleOutput)
        // 输出 "grtmndsthnklk"
        
        
        //下面的例子通过switch来判断一个Character值是否代表下面四种语言之一。为了简洁，多个值被包含在了同一个分支情况中。
        
        let numberSymbol: Character = "三"  // 简体中文里的数字 3
        var possibleIntegerValue: Int?
        switch numberSymbol {
        case "1", "١", "一", "๑":
            possibleIntegerValue = 1
        case "2", "٢", "二", "๒":
            possibleIntegerValue = 2
        case "3", "٣", "三", "๓":
            possibleIntegerValue = 3
        case "4", "٤", "四", "๔":
            possibleIntegerValue = 4
        default:
            break
        }
        if let integerValue = possibleIntegerValue {
            print("The integer value of \(numberSymbol) is \(integerValue).")
        } else {
            print("An integer value could not be found for \(numberSymbol).")
        }
        // 输出 "The integer value of 三 is 3."
        
        
// MARK: 贯穿
        
        //Swift 中的switch不会从上一个 case 分支落入到下一个 case 分支中。相反，只要第一个匹配到的 case 分支完成了它需要执行的语句，整个switch代码块完成了它的执行。相比之下，C 语言要求你显式地插入break语句到每个 case 分支的末尾来阻止自动落入到下一个 case 分支中。Swift 的这种避免默认落入到下一个分支中的特性意味着它的switch 功能要比 C 语言的更加清晰和可预测，可以避免无意识地执行多个 case 分支从而引发的错误。
        
        //如果你确实需要 C 风格的贯穿的特性，你可以在每个需要该特性的 case 分支中使用fallthrough关键字。下面的例子使用fallthrough来创建一个数字的描述语句。
        
        let integerToDescribe = 5
        var description = "The number \(integerToDescribe) is"
        switch integerToDescribe {
        case 2, 3, 5, 7, 11, 13, 17, 19:
            description += " a prime number, and also"
            fallthrough
        default:
            description += " an integer."
        }
        print(description)
        // 输出 "The number 5 is a prime number, and also an integer."
        
        
// MARK: 带标签的语句
        
        let finalSquare = 25
        var board = [Int](repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
        var square = 0
        var diceRoll = 0
        //这个版本的游戏使用while循环和switch语句来实现游戏的逻辑。while循环有一个标签名gameLoop，来表明它是游戏的主循环。
        
        //该while循环体的条件判断语句是while square !=finalSquare，这表明你必须刚好落在方格25中。
        
        gameLoop: while square != finalSquare {
            diceRoll += 1
            if diceRoll == 7 { diceRoll = 1 }
            switch square + diceRoll {
            case finalSquare:
                // 骰子数刚好使玩家移动到最终的方格里，游戏结束。
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                // 骰子数将会使玩家的移动超出最后的方格，那么这种移动是不合法的，玩家需要重新掷骰子
                continue gameLoop
            default:
                // 合法移动，做正常的处理
                square += diceRoll
                square += board[square]
            }
        }
        print("Game over!")
        //每次循环迭代开始时掷骰子。与之前玩家掷完骰子就立即移动不同，这里使用了switch语句来考虑每次移动可能产生的结果，从而决定玩家本次是否能够移动。
        
        //如果骰子数刚好使玩家移动到最终的方格里，游戏结束。break gameLoop语句跳转控制去执行while循环体后的第一行代码，意味着游戏结束。
         //   如果骰子数将会使玩家的移动超出最后的方格，那么这种移动是不合法的，玩家需要重新掷骰子。continue gameLoop语句结束本次while循环，开始下一次循环。
           // 在剩余的所有情况中，骰子数产生的都是合法的移动。玩家向前移动 diceRoll 个方格，然后游戏逻辑再处理玩家当前是否处于蛇头或者梯子的底部。接着本次循环//结束，控制跳转到while循环体的条件判断语句处，再决定是否需要继续执行下次循环。
        //注意：如果上述的break语句没有使用gameLoop标签，那么它将会中断switch语句而不是while循环。使用gameLoop标签清晰的表明了break想要中断的是哪个代码块。 同时请注意，当调用continue gameLoop去跳转到下一次循环迭代时，这里使用gameLoop标签并不是严格必须的。因为在这个游戏中，只有一个循环体，所以continue语句会影响到哪个循环体是没有歧义的。然而，continue语句使用gameLoop标签也是没有危害的。这样做符合标签的使用规则，同时参照旁边的break gameLoop，能够使游戏的逻辑更加清晰和易于理解。
        
        
// MARK: 提前退出
        //像if语句一样，guard的执行取决于一个表达式的布尔值。我们可以使用guard语句来要求条件必须为真时，以执行guard语句后的代码。不同于if语句，一个guard语句总是有一个else从句，如果条件不为真则执行else从句中的代码。
        
        func greet(person: [String: String]) {
            guard let name = person["name"] else {
                return
            }
            print("Hello \(name)")
            guard let location = person["location"] else {
                print("I hope the weather is nice near you.")
                return
            }
            print("I hope the weather is nice in \(location).")
        }
        greet(person: ["name": "John"])
        // 输出 "Hello John!"
        // 输出 "I hope the weather is nice near you."
        greet(person: ["name": "Jane", "location": "Cupertino"])
        // 输出 "Hello Jane!"
        // 输出 "I hope the weather is nice in Cupertino."
        //如果guard语句的条件被满足，则继续执行guard语句大括号后的代码。将变量或者常量的可选绑定作为guard语句的条件，都可以保护guard语句后面的代码。
        
       // 如果条件不被满足，在else分支上的代码就会被执行。这个分支必须转移控制以退出guard语句出现的代码段。它可以用控制转移语句如return,break,continue或者throw做这件事，或者调用一个不返回的方法或函数，例如fatalError()。
        
        //相比于可以实现同样功能的if语句，按需使用guard语句会提升我们代码的可读性。它可以使你的代码连贯的被执行而不需要将它包在else块中，它可以使你在紧邻条件判断的地方，处理违规的情况。
        
// MARK: 检测 API 可用性
        
        if #available(iOS 10, macOS 10.12, *) {
            // 在 iOS 使用 iOS 10 的 API, 在 macOS 使用 macOS 10.12 的 API
        } else {
            // 使用先前版本的 iOS 和 macOS 的 API
        }
        
        //以上可用性条件指定，在iOS中，if语句的代码块仅仅在 iOS 10 及更高的系统下运行；在 macOS中，仅在 macOS 10.12 及更高才会运行。最后一个参数，*，是必须的，用于指定在所有其它平台中，如果版本号高于你的设备指定的最低版本，if语句的代码块将会运行。
        
        //在它一般的形式中，可用性条件使用了一个平台名字和版本的列表。平台名字可以是iOS，macOS，watchOS和tvOS——请访问声明属性来获取完整列表。除了指定像 iOS 8的主板本号，我们可以指定像iOS 8.3 以及 macOS 10.10.3的子版本号。
        /*
        if #available(platform name version, ..., *) {
            APIs 可用，语句将执行
        } else {
            APIs 不可用，语句将不执行
        }
        */
        
        print()
    }

// MARK: 函数 示例代码看书
    /*
    函数定义与调用
    函数参数与返回值
    函数参数标签和参数名称
    函数类型
    嵌套函数
    */
    func functions() {
        
        /*
        func greet(person: String) -> String {
            let greeting = "Hello, " + person + "!"
            return greeting
        }
        
        print(greet(person: "Anna"))
        // 打印 "Hello, Anna!"
        print(greet(person: "Brian"))
        // 打印 "Hello, Brian!"
        */
        
        func sayHelloWorld() -> String {
            return "hello, world"
        }
        print(sayHelloWorld())
        // 打印 "hello, world"
        
        /*
        func greetAgain(person: String) -> String {
            return "Hello again, " + person + "!"
        }
        print(greetAgain(person: "Anna"))
        // 打印 "Hello again, Anna!"
 
        
        func greet(person: String, alreadyGreeted: Bool) -> String {
            if alreadyGreeted {
                return greetAgain(person: person)
            } else {
                return greet(person: person)
            }
        }
        print(greet(person: "Tim", alreadyGreeted: true))
        // 打印 "Hello again, Tim!"
        */
        
        
        // 无返回值函数
        func greet1(person: String) {
            print("Hello, \(person)!")
        }
        greet1(person: "Dave")
        // 打印 "Hello, Dave!"
        
        //多重返回值函数
        func minMax1(array: [Int]) -> (min: Int, max: Int) {
            var currentMin = array[0]
            var currentMax = array[0]
            for value in array[1..<array.count] {
                if value < currentMin {
                    currentMin = value
                } else if value > currentMax {
                    currentMax = value
                }
            }
            return (currentMin, currentMax)
        }
        let bounds = minMax1(array: [8, -6, 2, 109, 3, 71])
        print("min is \(bounds.min) and max is \(bounds.max)")
        // 打印 "min is -6 and max is 109"

// MAKR: 可选元组返回类型
        //如果函数返回的元组类型有可能整个元组都“没有值”，你可以使用可选的（ optional ） 元组返回类型反映整个元组可以是nil的事实。你可以通过在元组类型的右括号后放置一个问号来定义一个可选元组，例如 (Int, Int)? 或 (String, Int, Bool)?
        //注意 可选元组类型如 (Int, Int)? 与元组包含可选类型如 (Int?, Int?) 是不同的.可选的元组类型，整个元组是可选的，而不只是元组中的每个元素值。
        func minMax(array: [Int]) -> (min: Int, max: Int)? {
            if array.isEmpty { return nil }
            var currentMin = array[0]
            var currentMax = array[0]
            for value in array[1..<array.count] {
                if value < currentMin {
                    currentMin = value
                } else if value > currentMax {
                    currentMax = value
                }
            }
            return (currentMin, currentMax)
        }

        if let bounds = minMax(array: [8, -6, 2, 109, 3, 71]) {
            print("min is \(bounds.min) and max is \(bounds.max)")
        }
        // 打印 "min is -6 and max is 109"
        
// MARK: 函数参数标签和参数名称
        func someFunction(firstParameterName: Int, secondParameterName: Int) {
            // 在函数体内，firstParameterName 和 secondParameterName 代表参数中的第一个和第二个参数值
        }
        someFunction(firstParameterName: 1, secondParameterName: 2)
        
        
        func greet(person: String, from hometown: String) -> String {
            return "Hello \(person)!  Glad you could visit from \(hometown)."
        }
        print(greet(person: "Bill", from: "Cupertino"))
        // 打印 "Hello Bill!  Glad you could visit from Cupertino."
        
        print()
    }

// MARK: 闭包
    func Closures () {
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        func backward(_ s1: String, _ s2: String) -> Bool {
            return s1 > s2
        }
        var reversedNames = names.sorted(by: backward)
        // reversedNames 为 ["Ewa", "Daniella", "Chris", "Barry", "Alex"]
        
        reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 } )
        
        // 根据上下文推断类型
        reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )
        
        // 单表达式闭包隐式返回 单行表达式闭包可以通过省略 return 关键字来隐式返回单行表达式的结果，如上版本的例子可以改写为：
        reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
        
        // 参数名称缩写
        reversedNames = names.sorted(by: { $0 > $1 } )
        
        // 运算符方法
        reversedNames = names.sorted(by: >)
        
        // 尾随闭包
        func someFunctionThatTakesAClosure(closure: () -> Void) {
            // 函数体部分
        }
        
        // 以下是不使用尾随闭包进行函数调用
        someFunctionThatTakesAClosure(closure: {
            // 闭包主体部分
        })
        
        // 以下是使用尾随闭包进行函数调用
        someFunctionThatTakesAClosure() {
            // 闭包主体部分
        }
        
        //在闭包表达式语法一节中作为 sorted(by:) 方法参数的字符串排序闭包可以改写为：
        
        //reversedNames = names.sorted() { $0 > $1 }
        //如果闭包表达式是函数或方法的唯一参数，则当你使用尾随闭包时，你甚至可以把 () 省略掉：
        
        reversedNames = names.sorted { $0 > $1 }
        
        // 尾随闭包应用
        let digitNames = [
            0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
            5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
        ]
        let numbers = [16, 58, 510]
        
        let strings = numbers.map {
            (number) -> String in
            var number = number
            var output = ""
            repeat {
                output = digitNames[number % 10]! + output
                number /= 10
            } while number > 0
            return output
        }
        // strings 常量被推断为字符串类型数组，即 [String]
        // 其值为 ["OneSix", "FiveEight", "FiveOneZero"]
        
// MARK: 值捕获
        func makeIncrementer(forIncrement amount: Int) -> () -> Int {
            var runningTotal = 0
            func incrementer() -> Int {
                runningTotal += amount
                return runningTotal
            }
            return incrementer
        }
        
//        func incrementer() -> Int {
//            runningTotal += amount
//            return runningTotal
//        }
       
        let incrementByTen = makeIncrementer(forIncrement: 10)
        print(incrementByTen())
        // 返回的值为10
        print(incrementByTen())
        // 返回的值为20
        print(incrementByTen())
        // 返回的值为30
        
        //如果你创建了另一个 incrementer，它会有属于自己的引用，指向一个全新、独立的 runningTotal 变量：
        
        let incrementBySeven = makeIncrementer(forIncrement: 7)
        print(incrementBySeven())
        // 返回的值为7
        //再次调用原来的 incrementByTen 会继续增加它自己的 runningTotal 变量，该变量和 incrementBySeven 中捕获的变量没有任何联系：
        print(incrementByTen())
        
        // 返回的值为40
// MARK: 闭包是引用类型
        
        //上面的例子中，incrementBySeven 和 incrementByTen 都是常量，但是这些常量指向的闭包仍然可以增加其捕获的变量的值。这是因为函数和闭包都是引用类型。
        
        //无论你将函数或闭包赋值给一个常量还是变量，你实际上都是将常量或变量的值设置为对应函数或闭包的引用。上面的例子中，指向闭包的引用 incrementByTen 是一个常量，而并非闭包内容本身。
        
        //这也意味着如果你将闭包赋值给了两个不同的常量或变量，两个值都会指向同一个闭包：
        
        let alsoIncrementByTen = incrementByTen
        alsoIncrementByTen()
        // 返回的值为50
        
// MARK: 逃逸闭包
        //当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，我们称该闭包从函数中逃逸。当你定义接受闭包作为参数的函数时，你可以在参数名之前标注 @escaping，用来指明这个闭包是允许“逃逸”出这个函数的。
        //一种能使闭包“逃逸”出函数的方法是，将这个闭包保存在一个函数外部定义的变量中。举个例子，很多启动异步操作的函数接受一个闭包参数作为 completion handler。这类函数会在异步操作开始之后立刻返回，但是闭包直到异步操作结束后才会被调用。在这种情况下，闭包需要“逃逸”出函数，因为闭包需要在函数返回之后被调用。例如：
        
        var completionHandlers: [() -> Void] = []
        func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
            completionHandlers.append(completionHandler)
        }
        
        //someFunctionWithEscapingClosure(_:) 函数接受一个闭包作为参数，该闭包被添加到一个函数外定义的数组中。如果你不将这个参数标记为 @escaping，就会得到一个编译错误。
        
        //将一个闭包标记为 @escaping 意味着你必须在闭包中显式地引用 self。比如说，在下面的代码中，传递到 someFunctionWithEscapingClosure(_:) 中的闭包是一个逃逸闭包，这意味着它需要显式地引用 self。相对的，传递到 someFunctionWithNonescapingClosure(_:) 中的闭包是一个非逃逸闭包，这意味着它可以隐式引用 self。
        
        func someFunctionWithNonescapingClosure(closure: () -> Void) {
            closure()
        }
 		
        
        class SomeClass {
            var x = 10
            func doSomething() {
//                someFunctionWithEscapingClosure { self.x = 100 }
//                someFunctionWithNonescapingClosure { x = 200 }
            }
        }
        
        let instance = SomeClass()
        instance.doSomething()
        print(instance.x)
        // 打印出 "200"
        
        completionHandlers.first?()
        print(instance.x)
        // 打印出 "100"
        
        
// MARK:自动闭包
        //自动闭包是一种自动创建的闭包，用于包装传递给函数作为参数的表达式。这种闭包不接受任何参数，当它被调用的时候，会返回被包装在其中的表达式的值。这种便利语法让你能够省略闭包的花括号，用一个普通的表达式来代替显式的闭包。
        
        //我们经常会调用采用自动闭包的函数，但是很少去实现这样的函数。举个例子来说，assert(condition:message:file:line:) 函数接受自动闭包作为它的 condition 参数和 message 参数；它的 condition 参数仅会在 debug 模式下被求值，它的 message 参数仅当 condition 参数为 false 时被计算求值。
        
        //自动闭包让你能够延迟求值，因为直到你调用这个闭包，代码段才会被执行。延迟求值对于那些有副作用（Side Effect）和高计算成本的代码来说是很有益处的，因为它使得你能控制代码的执行时机。下面的代码展示了闭包如何延时求值。
        
        var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        print(customersInLine.count)
        // 打印出 "5"
        
        let customerProvider = { customersInLine.remove(at: 0) }
        print(customersInLine.count)
        // 打印出 "5"
        
        print("Now serving \(customerProvider())!")
        // Prints "Now serving Chris!"
        print(customersInLine.count)
        // 打印出 "4"
        //尽管在闭包的代码中，customersInLine 的第一个元素被移除了，不过在闭包被调用之前，这个元素是不会被移除的。如果这个闭包永远不被调用，那么在闭包里面的表达式将永远不会执行，那意味着列表中的元素永远不会被移除。请注意，customerProvider 的类型不是 String，而是 () -> String，一个没有参数且返回值为 String 的函数。
        
        //将闭包作为参数传递给函数时，你能获得同样的延时求值行为。
        
        // customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
        func serve(customer customerProvider: () -> String) {
            print("Now serving \(customerProvider())!")
        }
        serve(customer: { customersInLine.remove(at: 0) } )
        // 打印出 "Now serving Alex!"
        //上面的 serve(customer:) 函数接受一个返回顾客名字的显式的闭包。下面这个版本的 serve(customer:) 完成了相同的操作，不过它并没有接受一个显式的闭包，而是通过将参数标记为 @autoclosure 来接收一个自动闭包。现在你可以将该函数当作接受 String 类型参数（而非闭包）的函数来调用。customerProvider 参数将自动转化为一个闭包，因为该参数被标记了 @autoclosure 特性。
        
        // customersInLine is ["Ewa", "Barry", "Daniella"]
        /*
        func serve(customer customerProvider: @autoclosure () -> String) {
            print("Now serving \(customerProvider())!")
        }
        serve(customer: customersInLine.remove(at: 0))
        */
        
        // 打印 "Now serving Ewa!"
        //注意 过度使用 autoclosures 会让你的代码变得难以理解。上下文和函数名应该能够清晰地表明求值是被延迟执行的。
        //如果你想让一个自动闭包可以“逃逸”，则应该同时使用 @autoclosure 和 @escaping 属性。@escaping 属性的讲解见上面的逃逸闭包。
        
        // customersInLine i= ["Barry", "Daniella"]
        var customerProviders: [() -> String] = []
        func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
            customerProviders.append(customerProvider)
        }
        collectCustomerProviders(customersInLine.remove(at: 0))
        collectCustomerProviders(customersInLine.remove(at: 0))
        
        print("Collected \(customerProviders.count) closures.")
        // 打印 "Collected 2 closures."
        for customerProvider in customerProviders {
            print("Now serving \(customerProvider())!")
        }
        // 打印 "Now serving Barry!"
        // 打印 "Now serving Daniella!"
        //在上面的代码中，collectCustomerProviders(_:) 函数并没有调用传入的 customerProvider 闭包，而是将闭包追加到了 customerProviders 数组中。这个数组定义在函数作用域范围外，这意味着数组内的闭包能够在函数返回之后被调用。因此，customerProvider 参数必须允许“逃逸”出函数作用域。
        
        print()
    }
    
// MARK: 枚举（Enumerations）
    /*
     本页内容包含：
     
     枚举语法
     使用 Switch 语句匹配枚举值
     关联值
     原始值
     递归枚举
 	*/
    func enumerations() {
        //与 C 和 Objective-C 不同，Swift 的枚举成员在被创建时不会被赋予一个默认的整型值。在上面的CompassPoint例子中，north，south，east和west不会被隐式地赋值为0，1，2和3。相反，这些枚举成员本身就是完备的值，这些值的类型是已经明确定义好的CompassPoint类型。
        /*
        enum CompassPoint {
            case north
            case south
            case east
            case west
        }
        */
        enum CompassPoint: String {
            case north, south, east, west
        }

 
        //多个成员值可以出现在同一行上，用逗号隔开：
        /*
        enum Planet {
            case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
        }
        */
        
       // 每个枚举定义了一个全新的类型。像 Swift 中其他类型一样，它们的名字（例如CompassPoint和Planet）应该以一个大写字母开头。给枚举类型起一个单数名字而不是复数名字，以便于读起来更加容易理解：
        
        var directionToHead = CompassPoint.west
        //directionToHead的类型可以在它被CompassPoint的某个值初始化时推断出来。一旦directionToHead被声明为CompassPoint类型，你可以使用更简短的点语法将其设置为另一个CompassPoint的值：
        
        directionToHead = .east
        //当directionToHead的类型已知时，再次为其赋值可以省略枚举类型名。在使用具有显式类型的枚举值时，这种写法让代码具有更好的可读性。
        
        
        //使用 Switch 语句匹配枚举值
        //你可以使用switch语句匹配单个枚举值：
        
        directionToHead = .south
        switch directionToHead {
        case .north:
            print("Lots of planets have a north")
        case .south:
            print("Watch out for penguins")
        case .east:
            print("Where the sun rises")
        case .west:
            print("Where the skies are blue")
        }
        // 打印 "Watch out for penguins”
        
        /*
        let somePlanet = Planet.earth
        switch somePlanet {
        case .earth:
            print("Mostly harmless")
        default:
            print("Not a safe place for humans")
        }
        */
        // 打印 "Mostly harmless”
        
// MARK: 关联值
        //这便于库存跟踪系统用包含四个整型值的元组存储 UPC 码，以及用任意长度的字符串储存 QR 码。
        
       //在 Swift 中，使用如下方式定义表示两种商品条形码的枚举：
        
        enum Barcode {
            case upc(Int, Int, Int, Int)
            case qrCode(String)
        }
        //以上代码可以这么理解：
        
        //“定义一个名为Barcode的枚举类型，它的一个成员值是具有(Int，Int，Int，Int)类型关联值的upc，另一个成员值是具有String类型关联值的qrCode。”
        
        //这个定义不提供任何Int或String类型的关联值，它只是定义了，当Barcode常量和变量等于Barcode.upc或Barcode.qrCode时，可以存储的关联值的类型。
        
        //然后可以使用任意一种条形码类型创建新的条形码，例如：
        
        var productBarcode = Barcode.upc(8, 85909, 51226, 3)
        //上面的例子创建了一个名为productBarcode的变量，并将Barcode.upc赋值给它，关联的元组值为(8, 85909, 51226, 3)。
        
        //同一个商品可以被分配一个不同类型的条形码，例如：
        
        productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
        //这时，原始的Barcode.upc和其整数关联值被新的Barcode.qrCode和其字符串关联值所替代。Barcode类型的常量和变量可以存储一个.upc或者一个.qrCode（连同它们的关联值），但是在同一时间只能存储这两个值中的一个。
        
        //像先前那样，可以使用一个 switch 语句来检查不同的条形码类型。然而，这一次，关联值可以被提取出来作为 switch 语句的一部分。你可以在switch的 case 分支代码中提取每个关联值作为一个常量（用let前缀）或者作为一个变量（用var前缀）来使用：
        
        switch productBarcode {
        case .upc(let numberSystem, let manufacturer, let product, let check):
            print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
        case .qrCode(let productCode):
            print("QR code: \(productCode).")
        }
        // 打印 "QR code: ABCDEFGHIJKLMNOP."
        //如果一个枚举成员的所有关联值都被提取为常量，或者都被提取为变量，为了简洁，你可以只在成员名称前标注一个let或者var：
        
        switch productBarcode {
        case let .upc(numberSystem, manufacturer, product, check):
            print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
        case let .qrCode(productCode):
            print("QR code: \(productCode).")
        }
        // 输出 "QR code: ABCDEFGHIJKLMNOP."
        
        
// MARK: 原始值
        //在关联值小节的条形码例子中，演示了如何声明存储不同类型关联值的枚举成员。作为关联值的替代选择，枚举成员可以被默认值（称为原始值）预填充，这些原始值的类型必须相同。
        
        //这是一个使用 ASCII 码作为原始值的枚举：
        
        enum ASCIIControlCharacter: Character {
            case tab = "\t"
            case lineFeed = "\n"
            case carriageReturn = "\r"
        }
        //枚举类型ASCIIControlCharacter的原始值类型被定义为Character，并设置了一些比较常见的 ASCII 控制字符。Character的描述详见字符串和字符部分。
        
        //原始值可以是字符串，字符，或者任意整型值或浮点型值。每个原始值在枚举声明中必须是唯一的。
        
        //注意
        //原始值和关联值是不同的。原始值是在定义枚举时被预先填充的值，像上述三个 ASCII 码。对于一个特定的枚举成员，它的原始值始终不变。关联值是创建一个基于枚举成员的常量或变量时才设置的值，枚举成员的关联值可以变化。

        
// MARK:原始值的隐式赋值
        //
        //在使用原始值为整数或者字符串类型的枚举时，不需要显式地为每一个枚举成员设置原始值，Swift 将会自动为你赋值。
        
        //例如，当使用整数作为原始值时，隐式赋值的值依次递增1。如果第一个枚举成员没有设置原始值，其原始值将为0。
        
        //下面的枚举是对之前Planet这个枚举的一个细化，利用整型的原始值来表示每个行星在太阳系中的顺序：
        
        enum Planet: Int {
            case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
        }
        //在上面的例子中，Plant.mercury的显式原始值为1，Planet.venus的隐式原始值为2，依次类推。
        
        //当使用字符串作为枚举类型的原始值时，每个枚举成员的隐式原始值为该枚举成员的名称。
        
        //下面的例子是CompassPoint枚举的细化，使用字符串类型的原始值来表示各个方向的名称：
        
        /*
        enum CompassPoint: String {
            case north, south, east, west
        }
 		*/
        //上面例子中，CompassPoint.south拥有隐式原始值south，依次类推。
        
        //使用枚举成员的rawValue属性可以访问该枚举成员的原始值：
        
        let earthsOrder = Planet.earth.rawValue
        // earthsOrder 值为 3
        
        let sunsetDirection = CompassPoint.west.rawValue
        // sunsetDirection 值为 "west"
        
        
        
// MARK:        使用原始值初始化枚举实例
        
        //如果在定义枚举类型的时候使用了原始值，那么将会自动获得一个初始化方法，这个方法接收一个叫做rawValue的参数，参数类型即为原始值类型，返回值则是枚举成员或nil。你可以使用这个初始化方法来创建一个新的枚举实例。
        
       // 这个例子利用原始值7创建了枚举成员uranus：
        
        let possiblePlanet = Planet(rawValue: 7)
        // possiblePlanet 类型为 Planet? 值为 Planet.uranus
       /// 然而，并非所有Int值都可以找到一个匹配的行星。因此，原始值构造器总是返回一个可选的枚举成员。在上面的例子中，possiblePlanet是Planet?类型，或者说“可选的Planet”。
        
        //注意
        //原始值构造器是一个可失败构造器，因为并不是每一个原始值都有与之对应的枚举成员。更多信息请参见可失败构造器
       // 如果你试图寻找一个位置为11的行星，通过原始值构造器返回的可选Planet值将是nil：
        
        let positionToFind = 11
        if let somePlanet = Planet(rawValue: positionToFind) {
            switch somePlanet {
            case .earth:
                print("Mostly harmless")
            default:
                print("Not a safe place for humans")
            }
        } else {
            print("There isn't a planet at position \(positionToFind)")
        }
        // 输出 "There isn't a planet at position 11
        //这个例子使用了可选绑定（optional binding），试图通过原始值11来访问一个行星。if let somePlanet = Planet(rawValue: 11)语句创建了一个可选Planet，如果可选Planet的值存在，就会赋值给somePlanet。在这个例子中，无法检索到位置为11的行星，所以else分支被执行。
        
        
// MARK: 递归枚举
        //递归枚举是一种枚举类型，它有一个或多个枚举成员使用该枚举类型的实例作为关联值。使用递归枚举时，编译器会插入一个间接层。你可以在枚举成员前加上indirect来表示该成员可递归。
        
        //例如，下面的例子中，枚举类型存储了简单的算术表达式：
        /*
        enum ArithmeticExpression {
            case number(Int)
            indirect case addition(ArithmeticExpression, ArithmeticExpression)
            indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
        }
        */
        //你也可以在枚举类型开头加上indirect关键字来表明它的所有成员都是可递归的：
        
        indirect enum ArithmeticExpression {
            case number(Int)
            case addition(ArithmeticExpression, ArithmeticExpression)
            case multiplication(ArithmeticExpression, ArithmeticExpression)
        }
        //上面定义的枚举类型可以存储三种算术表达式：纯数字、两个表达式相加、两个表达式相乘。枚举成员addition和multiplication的关联值也是算术表达式——这些关联值使得嵌套表达式成为可能。例如，表达式(5 + 4) * 2，乘号右边是一个数字，左边则是另一个表达式。因为数据是嵌套的，因而用来存储数据的枚举类型也需要支持这种嵌套——这意味着枚举类型需要支持递归。下面的代码展示了使用ArithmeticExpression这个递归枚举创建表达式(5 + 4) * 2
        
        let five = ArithmeticExpression.number(5)
        let four = ArithmeticExpression.number(4)
        let sum = ArithmeticExpression.addition(five, four)
        let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
        //要操作具有递归性质的数据结构，使用递归函数是一种直截了当的方式。例如，下面是一个对算术表达式求值的函数：
        
        func evaluate(_ expression: ArithmeticExpression) -> Int {
            switch expression {
            case let .number(value):
                return value
            case let .addition(left, right):
                return evaluate(left) + evaluate(right)
            case let .multiplication(left, right):
                return evaluate(left) * evaluate(right)
            }
        }
        
        print(evaluate(product))
        // 打印 "18"
        //该函数如果遇到纯数字，就直接返回该数字的值。如果遇到的是加法或乘法运算，则分别计算左边表达式和右边表达式的值，然后相加或相乘。
        print()
    }
    
    
// MARK: 类和结构体
    func classAndStruct() {
        /*
         本页包含内容：
         
         类和结构体对比
         结构体和枚举是值类型
         类是引用类型
         类和结构体的选择
         字符串、数组、和字典类型的赋值与复制行为
         
        // 与其他编程语言所不同的是，Swift 并不要求你为自定义类和结构去创建独立的接口和实现文件。你所要做的是在一个单一文件中定义一个类或者结构体，系统将会自动生成面向其它代码的外部接口。
         
         Swift 中类和结构体有很多共同点。共同处在于：
         
         定义属性用于存储值
         定义方法用于提供功能
         定义下标操作使得可以通过下标语法来访问实例所包含的值
         定义构造器用于生成初始化值
         通过扩展以增加默认实现的功能
         实现协议以提供某种标准功能
         更多信息请参见属性，方法，下标，构造过程，扩展，和协议。
         
         与结构体相比，类还有如下的附加功能：
         
         继承允许一个类继承另一个类的特征
         类型转换允许在运行时检查和解释一个类实例的类型
         析构器允许一个类实例释放任何其所被分配的资源
         引用计数允许对一个类的多次引用
         */
        

        
        struct Resolution {
            var width = 0
            var height = 0
        }
        class VideoMode {
            var resolution = Resolution()
            var interlaced = false
            var frameRate = 0.0
            var name: String?
        }
        
        let someResolution = Resolution()
        let someVideoMode = VideoMode()
        
        print("The width of someResolution is \(someResolution.width)")
        // 打印 "The width of someResolution is 0"
        
        someVideoMode.resolution.width = 1280
        print("The width of someVideoMode is now \(someVideoMode.resolution.width)")
        // 打印 "The width of someVideoMode is now 1280"
        
        
        //构体类型的成员逐一构造器
        
        //所有结构体都有一个自动生成的成员逐一构造器，用于初始化新结构体实例中成员的属性。新实例中各个属性的初始值可以通过属性的名称传递到成员逐一构造器之中：
        
        let vga = Resolution(width:640, height: 480)
        //与结构体不同，类实例没有默认的成员逐一构造器
        
        
// MARK:  结构体和枚举是值类型
        //值类型被赋予给一个变量、常量或者被传递给一个函数的时候，其值会被拷贝(类似OC的深复制)。
        
        let hd = Resolution(width: 1920, height: 1080)
        var cinema = hd
        //在以上示例中，声明了一个名为hd的常量，其值为一个初始化为全高清视频分辨率（1920 像素宽，1080 像素高）的Resolution实例。
        
        //枚举也遵循相同的行为准则：
        
        enum CompassPoint {
            case North, South, East, West
        }
        var currentDirection = CompassPoint.West
        let rememberedDirection = currentDirection
        currentDirection = .East
        if rememberedDirection == .West {
            print("The remembered direction is still .West")
        }
        // 打印 "The remembered direction is still .West"
        
        
// MARK:        类是引用类型
        //与值类型不同，引用类型在被赋予到一个变量、常量或者被传递到一个函数时，其值不会被拷贝。因此，引用的是已存在的实例本身而不是其拷贝。
        
        //请看下面这个示例，其使用了之前定义的VideoMode类：
        
        let tenEighty = VideoMode()
        tenEighty.resolution = hd
        tenEighty.interlaced = true
        tenEighty.name = "1080i"
        tenEighty.frameRate = 25.0
        
        let alsoTenEighty = tenEighty
        alsoTenEighty.frameRate = 30.0
        
        print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
        // 打印 "The frameRate property of theEighty is now 30.0"
        
        //需要注意的是tenEighty和alsoTenEighty被声明为常量而不是变量。然而你依然可以改变tenEighty.frameRate和alsoTenEighty.frameRate，因为tenEighty和alsoTenEighty这两个常量的值并未改变。它们并不“存储”这个VideoMode实例，而仅仅是对VideoMode实例的引用。所以，改变的是被引用的VideoMode的frameRate属性，而不是引用VideoMode的常量的值。
        
// MARK:        恒等运算符
        /*
        因为类是引用类型，有可能有多个常量和变量在幕后同时引用同一个类实例。（对于结构体和枚举来说，这并不成立。因为它们作为值类型，在被赋予到常量、变量或者传递到函数时，其值总是会被拷贝。）
        
        如果能够判定两个常量或者变量是否引用同一个类实例将会很有帮助。为了达到这个目的，Swift 内建了两个恒等运算符：
        
        等价于（===）
        不等价于（!==）
        运用这两个运算符检测两个常量或者变量是否引用同一个实例：
        */
        if tenEighty === alsoTenEighty {
            print("tenEighty and alsoTenEighty refer to the same Resolution instance.")
        }
        //打印 "tenEighty and alsoTenEighty refer to the same Resolution instance."
        //请注意，“等价于”（用三个等号表示，===）与“等于”（用两个等号表示，==）的不同：
        
        //“等价于”表示两个类类型（class type）的常量或者变量引用同一个类实例。
        //“等于”表示两个实例的值“相等”或“相同”，判定时要遵照设计者定义的评判标准，因此相对于“相等”来说，这是一种更加合适的叫法。
        //当你在定义你的自定义类和结构体的时候，你有义务来决定判定两个实例“相等”的标准。在章节等价操作符中将会详细介绍实现自定义“等于”和“不等于”运算符的流程。
        
        
// MARK:        类和结构体的选择
        /*
        在你的代码中，你可以使用类和结构体来定义你的自定义数据类型。
        
        然而，结构体实例总是通过值传递，类实例总是通过引用传递。这意味两者适用不同的任务。当你在考虑一个工程项目的数据结构和功能的时候，你需要决定每个数据结构是定义成类还是结构体。
        
        按照通用的准则，当符合一条或多条以下条件时，请考虑构建结构体：
        
        该数据结构的主要目的是用来封装少量相关简单数据值。
        有理由预计该数据结构的实例在被赋值或传递时，封装的数据将会被拷贝而不是被引用。
        该数据结构中储存的值类型属性，也应该被拷贝，而不是被引用。
        该数据结构不需要去继承另一个既有类型的属性或者行为。
        举例来说，以下情境中适合使用结构体：
        
        几何形状的大小，封装一个width属性和height属性，两者均为Double类型。
        一定范围内的路径，封装一个start属性和length属性，两者均为Int类型。
        三维坐标系内一点，封装x，y和z属性，三者均为Double类型。
        在所有其它案例中，定义一个类，生成一个它的实例，并通过引用来管理和传递。实际中，这意味着绝大部分的自定义数据构造都应该是类，而非结构体。
        */
        print()
    }
    
// MARK: 属性(Properties)
    
    func properties() {
        /*
         存储属性
         计算属性
         属性观察器
         全局变量和局部变量
         类型属性
         */
        
        // MARK: 存储属性
        
        //下面的例子定义了一个名为 FixedLengthRange 的结构体，该结构体用于描述整数的范围，且这个范围值在被创建后不能被修改.
        
        struct FixedLengthRange {
            var firstValue: Int
            let length: Int
        }
        var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
        // 该区间表示整数0，1，2
        rangeOfThreeItems.firstValue = 6
        // 该区间现在表示整数6，7，8
        //FixedLengthRange 的实例包含一个名为 firstValue 的变量存储属性和一个名为 length 的常量存储属性。在上面的例子中，length 在创建实例的时候被初始化，因为它是一个常量存储属性，所以之后无法修改它的值。
        
        
// MARK:常量结构体的存储属性
        
        //如果创建了一个结构体的实例并将其赋值给一个常量，则无法修改该实例的任何属性，即使有属性被声明为变量也不行：
        
        let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
        // 该区间表示整数0，1，2，3
       // rangeOfFourItems.firstValue = 6 // 尽管 firstValue 是个变量属性，这里还是会报错
        //因为 rangeOfFourItems 被声明成了常量（用 let 关键字），即使 firstValue 是一个变量属性，也无法再修改它了。
        
        //这种行为是由于结构体（struct）属于值类型。当值类型的实例被声明为常量的时候，它的所有属性也就成了常量。
        
        //属于引用类型的类（class）则不一样。把一个引用类型的实例赋给一个常量后，仍然可以修改该实例的变量属性。
        
        
// MARK: 延迟存储属性
        /*
        延迟存储属性是指当第一次被调用的时候才会计算其初始值的属性。在属性声明前使用 lazy 来标示一个延迟存储属性。
        
        注意
        必须将延迟存储属性声明成变量（使用 var 关键字），因为属性的初始值可能在实例构造完成之后才会得到。而常量属性在构造过程完成之前必须要有初始值，因此无法声明成延迟属性。
        延迟属性很有用，当属性的值依赖于在实例的构造过程结束后才会知道影响值的外部因素时，或者当获得属性的初始值需要复杂或大量计算时，可以只在需要的时候计算它。
        
        下面的例子使用了延迟存储属性来避免复杂类中不必要的初始化。例子中定义了 DataImporter 和 DataManager 两个类，下面是部分代码：
        */
        
        class DataImporter {
            /*
             DataImporter 是一个负责将外部文件中的数据导入的类。
             这个类的初始化会消耗不少时间。
             */
            var fileName = "data.txt"
            // 这里会提供数据导入功能
        }
        
        class DataManager {
            lazy var importer = DataImporter()
            var data = [String]()
            // 这里会提供数据管理功能
        }
        
        let manager = DataManager()
        manager.data.append("Some data")
        manager.data.append("Some more data")
        // DataImporter 实例的 importer 属性还没有被创建
        //DataManager 类包含一个名为 data 的存储属性，初始值是一个空的字符串（String）数组。这里没有给出全部代码，只需知道 DataManager 类的目的是管理和提供对这个字符串数组的访问即可。
        
        //DataManager 的一个功能是从文件导入数据。该功能由 DataImporter 类提供，DataImporter 完成初始化需要消耗不少时间：因为它的实例在初始化时可能要打开文件，还要读取文件内容到内存。
        
        //DataManager 管理数据时也可能不从文件中导入数据。所以当 DataManager 的实例被创建时，没必要创建一个 DataImporter 的实例，更明智的做法是第一次用到 DataImporter 的时候才去创建它。
        
        //由于使用了 lazy ，importer 属性只有在第一次被访问的时候才被创建。比如访问它的属性 fileName 时：
        
        print(manager.importer.fileName)
        // DataImporter 实例的 importer 属性现在被创建了
        // 输出 "data.txt”
        //注意 如果一个被标记为 lazy 的属性在没有初始化时就同时被多个线程访问，则无法保证该属性只会被初始化一次。
        
        
// MARK:        计算属性
        //除存储属性外，类、结构体和枚举可以定义计算属性。计算属性不直接存储值，而是提供一个 getter 和一个可选的 setter，来间接获取和设置其他属性或变量的值。
        
        struct Point {
            var x = 0.0, y = 0.0
        }
        struct Size {
            var width = 0.0, height = 0.0
        }
        struct Rect {
            var origin = Point()
            var size = Size()
            var center: Point {
                get {
                    let centerX = origin.x + (size.width / 2)
                    let centerY = origin.y + (size.height / 2)
                    return Point(x: centerX, y: centerY)
                }
                set(newCenter) {
                    origin.x = newCenter.x - (size.width / 2)
                    origin.y = newCenter.y - (size.height / 2)
                }
            }
        }
        var square = Rect(origin: Point(x: 0.0, y: 0.0),
                          size: Size(width: 10.0, height: 10.0))
        let initialSquareCenter = square.center
        square.center = Point(x: 15.0, y: 15.0)
        print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
        // 打印 "square.origin is now at (10.0, 10.0)”
        
        
// MARK:        简化 setter 声明
        
        //如果计算属性的 setter 没有定义表示新值的参数名，则可以使用默认名称 newValue。下面是使用了简化 setter 声明的 Rect 结构体代码：
        
        struct AlternativeRect {
            var origin = Point()
            var size = Size()
            var center: Point {
                get {
                    let centerX = origin.x + (size.width / 2)
                    let centerY = origin.y + (size.height / 2)
                    return Point(x: centerX, y: centerY)
                }
                set {
                    origin.x = newValue.x - (size.width / 2)
                    origin.y = newValue.y - (size.height / 2)
                }
            }
        }
        
        
// MARK:        只读计算属性
        
        //只有 getter 没有 setter 的计算属性就是只读计算属性。只读计算属性总是返回一个值，可以通过点运算符访问，但不能设置新的值。
        
        //注意  必须使用 var 关键字定义计算属性，包括只读计算属性，因为它们的值不是固定的。let 关键字只用来声明常量属性，表示初始化后再也无法修改的值。
        //只读计算属性的声明可以去掉 get 关键字和花括号：
        
        struct Cuboid {
            var width = 0.0, height = 0.0, depth = 0.0
            var volume: Double {  // 这是一个只读计算属性
                return width * height * depth
            }
        }
        let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
        print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
        // 打印 "the volume of fourByFiveByTwo is 40.0"
        
        
// MARK:        属性观察器
        /*
        属性观察器监控和响应属性值的变化，每次属性被设置值的时候都会调用属性观察器，即使新值和当前值相同的时候也不例外。
        
        可以为除了延迟存储属性之外的其他存储属性添加属性观察器，也可以通过重写属性的方式为继承的属性（包括存储属性和计算属性）添加属性观察器。你不必为非重写的计算属性添加属性观察器，因为可以通过它的 setter 直接监控和响应值的变化。 属性重写请参考重写。
        
        可以为属性添加如下的一个或全部观察器：
        
        willSet 在新的值被设置之前调用
        didSet 在新的值被设置之后立即调用
        willSet 观察器会将新的属性值作为常量参数传入，在 willSet 的实现代码中可以为这个参数指定一个名称，如果不指定则参数仍然可用，这时使用默认名称 newValue 表示。
        
        同样，didSet 观察器会将旧的属性值作为参数传入，可以为该参数命名或者使用默认参数名 oldValue。如果在 didSet 方法中再次对该属性赋值，那么新值会覆盖旧的值。
        
        注意
        父类的属性在子类的构造器中被赋值时，它在父类中的 willSet 和 didSet 观察器会被调用，随后才会调用子类的观察器。在父类初始化方法调用之前，子类给属性赋值时，观察器不会被调用。 有关构造器代理的更多信息，请参考值类型的构造器代理和类的构造器代理规则。
        下面是一个 willSet 和 didSet 实际运用的例子，其中定义了一个名为 StepCounter 的类，用来统计一个人步行时的总步数。这个类可以跟计步器或其他日常锻炼的统计装置的输入数据配合使用。
        */
        class StepCounter {
            var totalSteps: Int = 0 {
                willSet(newTotalSteps) {
                    print("About to set totalSteps to \(newTotalSteps)")
                }
                didSet {
                    if totalSteps > oldValue  {
                        print("Added \(totalSteps - oldValue) steps")
                    }
                }
            }
        }
        let stepCounter = StepCounter()
        stepCounter.totalSteps = 200
        // About to set totalSteps to 200
        // Added 200 steps
        stepCounter.totalSteps = 360
        // About to set totalSteps to 360
        // Added 160 steps
        stepCounter.totalSteps = 896
        // About to set totalSteps to 896
        // Added 536 steps
        /*
        StepCounter 类定义了一个 Int 类型的属性 totalSteps，它是一个存储属性，包含 willSet 和 didSet 观察器。
        
        当 totalSteps 被设置新值的时候，它的 willSet 和 didSet 观察器都会被调用，即使新值和当前值完全相同时也会被调用。
        
        例子中的 willSet 观察器将表示新值的参数自定义为 newTotalSteps，这个观察器只是简单的将新的值输出。
        
        didSet 观察器在 totalSteps 的值改变后被调用，它把新值和旧值进行对比，如果总步数增加了，就输出一个消息表示增加了多少步。didSet 没有为旧值提供自定义名称，所以默认值 oldValue 表示旧值的参数名。
        
        注意
        
        如果将属性通过 in-out 方式传入函数，willSet 和 didSet 也会调用。这是因为 in-out 参数采用了拷入拷出模式：即在函数内部使用的是参数的 copy，函数结束后，又对参数重新赋值。关于 in-out 参数详细的介绍，请参考输入输出参数
        */
        
// MARK: 全局变量和局部变量
        /*
        计算属性和属性观察器所描述的功能也可以用于全局变量和局部变量。全局变量是在函数、方法、闭包或任何类型之外定义的变量。局部变量是在函数、方法或闭包内部定义的变量。
        
        前面章节提到的全局或局部变量都属于存储型变量，跟存储属性类似，它为特定类型的值提供存储空间，并允许读取和写入。
        
        另外，在全局或局部范围都可以定义计算型变量和为存储型变量定义观察器。计算型变量跟计算属性一样，返回一个计算结果而不是存储值，声明格式也完全一样。
        
        注意
        全局的常量或变量都是延迟计算的，跟延迟存储属性相似，不同的地方在于，全局的常量或变量不需要标记lazy修饰符。
        局部范围的常量或变量从不延迟计算。
        */
        
// MARK: 类型属性
        /*
         实例属性属于一个特定类型的实例，每创建一个实例，实例都拥有属于自己的一套属性值，实例之间的属性相互独立。
         
         也可以为类型本身定义属性，无论创建了多少个该类型的实例，这些属性都只有唯一一份。这种属性就是类型属性。
         
         类型属性用于定义某个类型所有实例共享的数据，比如所有实例都能用的一个常量（就像 C 语言中的静态常量），或者所有实例都能访问的一个变量（就像 C 语言中的静态变量）。
         
         存储型类型属性可以是变量或常量，计算型类型属性跟实例的计算型属性一样只能定义成变量属性。
         
         注意
         跟实例的存储型属性不同，必须给存储型类型属性指定默认值，因为类型本身没有构造器，也就无法在初始化过程中使用构造器给类型属性赋值。
         存储型类型属性是延迟初始化的，它们只有在第一次被访问的时候才会被初始化。即使它们被多个线程同时访问，系统也保证只会对其进行一次初始化，并且不需要对其使用 lazy 修饰符。
         */
        
// MARK: 类型属性语法
        
        //在 C 或 Objective-C 中，与某个类型关联的静态常量和静态变量，是作为全局（global）静态变量定义的。但是在 Swift 中，类型属性是作为类型定义的一部分写在类型最外层的花括号内，因此它的作用范围也就在类型支持的范围内。
        
        //使用关键字 static 来定义类型属性。在为类定义计算型类型属性时，可以改用关键字 class 来支持子类对父类的实现进行重写。下面的例子演示了存储型和计算型类型属性的语法：
        
        struct SomeStructure {
            static var storedTypeProperty = "Some value."
            static var computedTypeProperty: Int {
                return 1
            }
        }
        enum SomeEnumeration {
            static var storedTypeProperty = "Some value."
            static var computedTypeProperty: Int {
                return 6
            }
        }
        class SomeClass {
            static var storedTypeProperty = "Some value."
            static var computedTypeProperty: Int {
                return 27
            }
            class var overrideableComputedTypeProperty: Int { // 重写
                return 107
            }
        }
        //注意 例子中的计算型类型属性是只读的，但也可以定义可读可写的计算型类型属性，跟计算型实例属性的语法相同。
        
// MARK:        获取和设置类型属性的值
        
        //跟实例属性一样，类型属性也是通过点运算符来访问。但是，类型属性是通过类型本身来访问，而不是通过实例。比如：
        
        print(SomeStructure.storedTypeProperty)
        // 打印 "Some value."
        SomeStructure.storedTypeProperty = "Another value."
        print(SomeStructure.storedTypeProperty)
        // 打印 "Another value.”
        print(SomeEnumeration.computedTypeProperty)
        // 打印 "6"
        print(SomeClass.computedTypeProperty)
        // 打印 "27"
        
        struct AudioChannel {
            static let thresholdLevel = 10
            static var maxInputLevelForAllChannels = 0
            var currentLevel: Int = 0 {
                didSet {
                    if currentLevel > AudioChannel.thresholdLevel {
                        // 将当前音量限制在阈值之内
                        currentLevel = AudioChannel.thresholdLevel
                    }
                    if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                        // 存储当前音量作为新的最大输入音量
                        AudioChannel.maxInputLevelForAllChannels = currentLevel
                    }
                }
            }
        }
        
        var leftChannel = AudioChannel()
        var rightChannel = AudioChannel()
        
        leftChannel.currentLevel = 7
        print(leftChannel.currentLevel)
        // 输出 "7"
        print(AudioChannel.maxInputLevelForAllChannels)
        // 输出 "7"

        rightChannel.currentLevel = 11
        print(rightChannel.currentLevel)
        // 输出 "10"
        print(AudioChannel.maxInputLevelForAllChannels)
        // 输出 "10"
        
        print()
    }
    
// MARK:方法(Methods)
    /*
     实例方法
     类型方法
     */
    
    func methods() {
        
        /*
         结构体和枚举能够定义方法是 Swift 与 C/Objective-C 的主要区别之一。在 Objective-C 中，类是唯一能定义方法的类型。但在 Swift 中，你不仅能选择是否要定义一个类/结构体/枚举，还能灵活地在你创建的类型（类/结构体/枚举）上定义方法。
         */
        class Counter {
            var count = 0
            func increment() {
                count += 1
            }
            func increment(by amount: Int) {
                count += amount
            }
            func reset() {
                count = 0
            }
        }
        
        
        let counter = Counter()
        // 初始计数值是0
        counter.increment()
        // 计数值现在是1
        counter.increment(by: 5)
        // 计数值现在是6
        counter.reset()
        // 计数值现在是0
        
        
// MARK:        self 属性
        
        //类型的每一个实例都有一个隐含属性叫做self，self完全等同于该实例本身。你可以在一个实例的实例方法中使用这个隐含的self属性来引用当前实例。
        
        //上面例子中的increment方法还可以这样写：
        
        func increment() {
            var count = 0
            count += 1
        }
        //实际上，你不必在你的代码里面经常写self。不论何时，只要在一个方法中使用一个已知的属性或者方法名称，如果你没有明确地写self，Swift 假定你是指当前实例的属性或者方法。这种假定在上面的Counter中已经示范了：Counter中的三个实例方法中都使用的是count（而不是self.count）。
        
        //使用这条规则的主要场景是实例方法的某个参数名称与实例的某个属性名称相同的时候。在这种情况下，参数名称享有优先权，并且在引用属性时必须使用一种更严格的方式。这时你可以使用self属性来区分参数名称和属性名称。
        
        //下面的例子中，self消除方法参数x和实例属性x之间的歧义：
        
        /*
        struct Point {
            var x = 0.0, y = 0.0
            func isToTheRightOfX(x: Double) -> Bool {
                return self.x > x
            }
        }
        let somePoint = Point(x: 4.0, y: 5.0)
        if somePoint.isToTheRightOfX(x: 1.0) {
            print("This point is to the right of the line where x == 1.0")
        }
        */
        
        // 打印 "This point is to the right of the line where x == 1.0"
        //如果不使用self前缀，Swift 就认为两次使用的x都指的是名称为x的函数参数。
        
        
// MARK: 在实例方法中修改值类型
        
        //结构体和枚举是值类型。默认情况下，值类型的属性不能在它的实例方法中被修改。
        
        //但是，如果你确实需要在某个特定的方法中修改结构体或者枚举的属性，你可以为这个方法选择可变(mutating)行为，然后就可以从其方法内部改变它的属性；并且这个方法做的任何改变都会在方法执行结束时写回到原始结构中。方法还可以给它隐含的self属性赋予一个全新的实例，这个新实例在方法结束时会替换现存实例。
        
        //要使用可变方法，将关键字mutating 放到方法的func关键字之前就可以了：
        
 /*
        struct Point {
            var x = 0.0, y = 0.0
            mutating func moveByX(deltaX: Double, y deltaY: Double) {
                x += deltaX
                y += deltaY
            }
        }
        var somePoint = Point(x: 1.0, y: 1.0)
        somePoint.moveByX(deltaX: 2.0, y: 3.0)
        print("The point is now at (\(somePoint.x), \(somePoint.y))")
        // 打印 "The point is now at (3.0, 4.0)"
        //上面的Point结构体定义了一个可变方法 moveByX(_:y:) 来移动Point实例到给定的位置。该方法被调用时修改了这个点，而不是返回一个新的点。方法定义时加上了mutating关键字，从而允许修改属性。
        
        //注意，不能在结构体类型的常量（a constant of structure type）上调用可变方法，因为其属性不能被改变，即使属性是变量属性，详情参见常量结构体的存储属性：
        
        let fixedPoint = Point(x: 3.0, y: 3.0)
        //fixedPoint.moveByX(2.0, y: 3.0) // 这里将会报告一个错误
 */
        
// MARK: 在可变方法中给 self 赋值
        
        //可变方法能够赋给隐含属性self一个全新的实例。上面Point的例子可以用下面的方式改写：
        
        struct Point {
            var x = 0.0, y = 0.0
            mutating func moveBy(x deltaX: Double, y deltaY: Double) {
                self = Point(x: x + deltaX, y: y + deltaY)
            }
        }
        //新版的可变方法moveBy(x:y:)创建了一个新的结构体实例，它的 x 和 y 的值都被设定为目标值。调用这个版本的方法和调用上个版本的最终结果是一样的。
        
        //枚举的可变方法可以把self设置为同一枚举类型中不同的成员：
        
        enum TriStateSwitch {
            case Off, Low, High
            mutating func next() {
                switch self {
                case .Off:
                    self = .Low
                case .Low:
                    self = .High
                case .High:
                    self = .Off
                }
            }
        }
        var ovenLight = TriStateSwitch.Low
        ovenLight.next()
        // ovenLight 现在等于 .High
        ovenLight.next()
        // ovenLight 现在等于 .Off
        //上面的例子中定义了一个三态开关的枚举。每次调用next()方法时，开关在不同的电源状态（Off，Low，High）之间循环切换。
        
// MARK: 类型方法
        //实例方法是被某个类型的实例调用的方法。你也可以定义在类型本身上调用的方法，这种方法就叫做类型方法。在方法的func关键字之前加上关键字static，来指定类型方法。类还可以用关键字class来允许子类重写父类的方法实现。
        
        //注意 在 Objective-C 中，你只能为 Objective-C 的类类型（classes）定义类型方法（type-level methods）。在 Swift 中，你可以为所有的类、结构体和枚举定义类型方法。每一个类型方法都被它所支持的类型显式包含。
        //类型方法和实例方法一样用点语法调用。但是，你是在类型上调用这个方法，而不是在实例上调用。
        
        class SomeClass {
            class func someTypeMethod() {
                // 在这里实现类型方法
            }
        }
        SomeClass.someTypeMethod()
        
        
        struct LevelTracker {
            static var highestUnlockedLevel = 1
            var currentLevel = 1
            
            static func unlock(_ level: Int) {
                if level > highestUnlockedLevel { highestUnlockedLevel = level }
            }
            
            static func isUnlocked(_ level: Int) -> Bool {
                return level <= highestUnlockedLevel
            }
            
            @discardableResult // discardableResult Apply this attribute to a function or method declaration to suppress the compiler warning when the function or method that returns a value is called without using its result.
            mutating func advance(to level: Int) -> Bool {
                if LevelTracker.isUnlocked(level) {
                    currentLevel = level
                    return true
                } else {
                    return false
                }
            }
        }
        
        class Player {
            var tracker = LevelTracker()
            let playerName: String
            func complete(level: Int) {
                LevelTracker.unlock(level + 1)
                tracker.advance(to: level + 1)
            }
            init(name: String) {
                playerName = name
            }
        }
        
        var player = Player(name: "Argyrios")
        player.complete(level: 1)
        print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
        // 打印 "highest unlocked level is now 2"
        
        
        player = Player(name: "Beto")
        if player.tracker.advance(to: 6) {
            print("player is now on level 6")
        } else {
            print("level 6 has not yet been unlocked")
        }
        // 打印 "level 6 has not yet been unlocked"
        
        print()
    }

// MARK: 下标
    
    subscript(index: Int) -> Int {
        get {
            // 返回一个适当的 Int 类型的值
            return 0
        }
        
        set(newValue) {
            // 执行适当的赋值操作
        }
    }
    
    func subscriptTest() {
        /*
         下标语法
         下标用法
         下标选项
         */
        //下标语法
        //下标允许你通过在实例名称后面的方括号中传入一个或者多个索引值来对实例进行存取。语法类似于实例方法语法和计算型属性语法的混合。与定义实例方法类似，定义下标使用subscript关键字，指定一个或多个输入参数和返回类型；与实例方法不同的是，下标可以设定为读写或只读。这种行为由 getter 和 setter 实现，有点类似计算型属性：
        

        
//        subscript(index: Int) -> Int {
//            // 返回一个适当的 Int 类型的值
//        }

        struct TimesTable {
            let multiplier: Int
            subscript(index: Int) -> Int {
                return multiplier * index
            }
        }
        let threeTimesTable = TimesTable(multiplier: 3)
        print("six times three is \(threeTimesTable[6])")
        // 打印 "six times three is 18"
        
        
// MARK: 下标用法
        
        var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
        numberOfLegs["bird"] = 2
        
        //上例定义一个名为numberOfLegs的变量，并用一个包含三对键值的字典字面量初始化它。numberOfLegs字典的类型被推断为[String: Int]。字典创建完成后，该例子通过下标将String类型的键bird和Int类型的值2添加到字典中。
        
        /*
        struct Matrix {
            let rows: Int, columns: Int
            var grid: [Double]
            init(rows: Int, columns: Int) {
                self.rows = rows
                self.columns = columns
                grid = Array(repeating: 0.0, count: rows * columns)
            }
            func indexIsValidForRow(row: Int, column: Int) -> Bool {
                return row >= 0 && row < rows && column >= 0 && column < columns
            }
            subscript(row: Int, column: Int) -> Double {
                get {
                    assert(indexIsValidForRow(row: row, column: column), "Index out of range")
                    return grid[(row * columns) + column]
                }
                set {
                    assert(indexIsValidForRow(row: row, column: column), "Index out of range")
                    grid[(row * columns) + column] = newValue
                }
            }
        }

        var matrix = Matrix(rows: 2, columns: 2)
        matrix[0, 1] = 1.5
        matrix[1, 0] = 3.2
        func indexIsValidForRow(row: Int, column: Int) -> Bool {
            return row >= 0 && row < row && column >= 0 && column < column
        }

        
        let someValue = matrix[2, 2]
        // 断言将会触发，因为 [2, 2] 已经超过了 matrix 的范围
        */
        
        
        print()
    }
 
    
// MARK: 继承
    
    func inherit() {
        
        /*
         定义一个基类
         子类生成
         重写
         防止重写
         */
        
        //下面的例子定义了一个叫Vehicle的基类。
        class Vehicle {
            var currentSpeed = 0.0
            var description: String {
                return "traveling at \(currentSpeed) miles per hour"
            }
            func makeNoise() {
                // 什么也不做-因为车辆不一定会有噪音
            }
        }
        
       //您可以用初始化语法创建一个Vehicle的新实例，即类名后面跟一个空括号：
        
        let someVehicle = Vehicle()
        //现在已经创建了一个Vehicle的新实例，你可以访问它的description属性来打印车辆的当前速度：
        
        print("Vehicle: \(someVehicle.description)")
        // 打印 "Vehicle: traveling at 0.0 miles per hour"
        
// MARK: 子类生成
        class Bicycle: Vehicle {
            var hasBasket = false
        }
        
        let bicycle = Bicycle()
        bicycle.hasBasket = true
        
        bicycle.currentSpeed = 15.0
        print("Bicycle: \(bicycle.description)")
        // 打印 "Bicycle: traveling at 15.0 miles per hour"
        
        class Tandem: Bicycle {
            var currentNumberOfPassengers = 0
        }
        
        let tandem = Tandem()
        tandem.hasBasket = true
        tandem.currentNumberOfPassengers = 2
        tandem.currentSpeed = 22.0
        print("Tandem: \(tandem.description)")
        // 打印："Tandem: traveling at 22.0 miles per hour"

// MARK: 重写
       //override关键字会提醒 Swift 编译器去检查该类的超类（或其中一个父类）是否有匹配重写版本的声明。这个检查可以确保你的重写定义是正确的。
        
        //在合适的地方，你可以通过使用super前缀来访问超类版本的方法，属性或下标：
        
       // 在方法someMethod()的重写实现中，可以通过super.someMethod()来调用超类版本的someMethod()方法。
        //在属性someProperty的 getter 或 setter 的重写实现中，可以通过super.someProperty来访问超类版本的someProperty属性。
        //在下标的重写实现中，可以通过super[someIndex]来访问超类版本中的相同下标。

        class Train: Vehicle {
            override func makeNoise() {
                print("Choo Choo")
            }
        }
        
        let train = Train()
        train.makeNoise()
        // 打印 "Choo Choo"
    
// MARK: 重写属性
        //你可以重写继承来的实例属性或类型属性，提供自己定制的 getter 和 setter，或添加属性观察器使重写的属性可以观察属性值什么时候发生改变。
        /*
        重写属性的 Getters 和 Setters
        
        你可以提供定制的 getter（或 setter）来重写任意继承来的属性，无论继承来的属性是存储型的还是计算型的属性。子类并不知道继承来的属性是存储型的还是计算型的，它只知道继承来的属性会有一个名字和类型。你在重写一个属性时，必需将它的名字和类型都写出来。这样才能使编译器去检查你重写的属性是与超类中同名同类型的属性相匹配的。
        
        你可以将一个继承来的只读属性重写为一个读写属性，只需要在重写版本的属性里提供 getter 和 setter 即可。但是，你不可以将一个继承来的读写属性重写为一个只读属性。
        
        注意
        如果你在重写属性中提供了 setter，那么你也一定要提供 getter。如果你不想在重写版本中的 getter 里修改继承来的属性值，你可以直接通过super.someProperty来返回继承来的值，其中someProperty是你要重写的属性的名字。
        */
        
        //以下的例子定义了一个新类，叫Car，它是Vehicle的子类。这个类引入了一个新的存储型属性叫做gear，默认值为整数1。Car类重写了继承自Vehicle的description属性，提供包含当前档位的自定义描述：
        
        class Car: Vehicle {
            var gear = 1
            override var description: String {
                return super.description + " in gear \(gear)"
            }
        }
        
        let car = Car()
        car.currentSpeed = 25.0
        car.gear = 3
        print("Car: \(car.description)")
        // 打印 "Car: traveling at 25.0 miles per hour in gear 3"
        
        
// MARK: 重写属性观察器
        
        //你可以通过重写属性为一个继承来的属性添加属性观察器。这样一来，当继承来的属性值发生改变时，你就会被通知到，无论那个属性原本是如何实现的。关于属性观察器的更多内容，请看属性观察器。
        
        //注意 你不可以为继承来的常量存储型属性或继承来的只读计算型属性添加属性观察器。这些属性的值是不可以被设置的，所以，为它们提供willSet或didSet实现是不恰当。
        //此外还要注意，你不可以同时提供重写的 setter 和重写的属性观察器。如果你想观察属性值的变化，并且你已经为那个属性提供了定制的 setter，那么你在 setter 中就可以观察到任何值变化了。
        
        //下面的例子定义了一个新类叫AutomaticCar，它是Car的子类。AutomaticCar表示自动挡汽车，它可以根据当前的速度自动选择合适的挡位:
        
        class AutomaticCar: Car {
            override var currentSpeed: Double {
                didSet {
                    gear = Int(currentSpeed / 10.0) + 1
                }
            }
        }
        
        //当你设置AutomaticCar的currentSpeed属性，属性的didSet观察器就会自动地设置gear属性，为新的速度选择一个合适的挡位。具体来说就是，属性观察器将新的速度值除以10，然后向下取得最接近的整数值，最后加1来得到档位gear的值。例如，速度为35.0时，挡位为4：
        
        let automatic = AutomaticCar()
        automatic.currentSpeed = 35.0
        print("AutomaticCar: \(automatic.description)")
        // 打印 "AutomaticCar: traveling at 35.0 miles per hour in gear 4"
        
        
// MARK: 防止重写
        /*
        你可以通过把方法，属性或下标标记为final来防止它们被重写，只需要在声明关键字前加上final修饰符即可（例如：final var，final func，final class func，以及final subscript）。
        
        如果你重写了带有final标记的方法，属性或下标，在编译时会报错。在类扩展中的方法，属性或下标也可以在扩展的定义里标记为 final 的。
        
        你可以通过在关键字class前添加final修饰符（final class）来将整个类标记为 final 的。这样的类是不可被继承的，试图继承这样的类会导致编译报错。
        */
        print()
    }
    
// MARK:构造过程
    
    func structure() {
        /*
         存储属性的初始赋值
         自定义构造过程
         默认构造器
         值类型的构造器代理
         类的继承和构造过程
         可失败构造器
         必要构造器
         通过闭包或函数设置属性的默认值
         */
        
        //通过定义构造器来实现构造过程，这些构造器可以看做是用来创建特定类型新实例的特殊方法。与 Objective-C 中的构造器不同，Swift 的构造器无需返回值，它们的主要任务是保证新实例在第一次使用前完成正确的初始化。
        
// MARK:存储属性的初始赋值
        //类和结构体在创建实例时，必须为所有存储型属性设置合适的初始值。存储型属性的值不能处于一个未知的状态。
        
        //你可以在构造器中为存储型属性赋初值，也可以在定义属性时为其设置默认值。以下小节将详细介绍这两种方法。
        
        //注意 当你为存储型属性设置默认值或者在构造器中为其赋值时，它们的值是被直接设置的，不会触发任何属性观察者。
        
        //下面例子中定义了一个用来保存华氏温度的结构体Fahrenheit，它拥有一个Double类型的存储型属性temperature：
        
        struct Fahrenheit {
            var temperature: Double
            init() {
                temperature = 32.0
            }
        }
        var f = Fahrenheit()
        print("The default temperature is \(f.temperature)° Fahrenheit")
        // 打印 "The default temperature is 32.0° Fahrenheit”

// 构造参数
        
        //自定义构造过程时，可以在定义中提供构造参数，指定所需值的类型和名字。构造参数的功能和语法跟函数和方法的参数相同。
        
        //下面例子中定义了一个包含摄氏度温度的结构体Celsius。它定义了两个不同的构造器：init(fromFahrenheit:)和init(fromKelvin:)，二者分别通过接受不同温标下的温度值来创建新的实例：
        
        struct Celsius {
            var temperatureInCelsius: Double
            init(fromFahrenheit fahrenheit: Double) {
                temperatureInCelsius = (fahrenheit - 32.0) / 1.8
            }
            init(fromKelvin kelvin: Double) {
                temperatureInCelsius = kelvin - 273.15
            }
        }
        let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
        // boilingPointOfWater.temperatureInCelsius 是 100.0
        let freezingPointOfWater = Celsius(fromKelvin: 273.15)
        // freezingPointOfWater.temperatureInCelsius 是 0.0
        
        //第一个构造器拥有一个构造参数，其外部名字为fromFahrenheit，内部名字为fahrenheit；第二个构造器也拥有一个构造参数，其外部名字为fromKelvin，内部名字为kelvin。这两个构造器都将唯一的参数值转换成摄氏温度值，并保存在属性temperatureInCelsius中。
        
// 参数的内部名称和外部名称
        
        //跟函数和方法参数相同，构造参数也拥有一个在构造器内部使用的参数名字和一个在调用构造器时使用的外部参数名字。
        
        //然而，构造器并不像函数和方法那样在括号前有一个可辨别的名字。因此在调用构造器时，主要通过构造器中的参数名和类型来确定应该被调用的构造器。正因为参数如此重要，如果你在定义构造器时没有提供参数的外部名字，Swift 会为构造器的每个参数自动生成一个跟内部名字相同的外部名。
        
        //以下例子中定义了一个结构体Color，它包含了三个常量：red、green和blue。这些属性可以存储0.0到1.0之间的值，用来指示颜色中红、绿、蓝成分的含量。
        
        //Color提供了一个构造器，其中包含三个Double类型的构造参数。Color也可以提供第二个构造器，它只包含名为white的Double类型的参数，它被用于给上述三个构造参数赋予同样的值。
        
        struct Color {
            let red, green, blue: Double
            init(red: Double, green: Double, blue: Double) {
                self.red   = red
                self.green = green
                self.blue  = blue
            }
            init(white: Double) {
                red   = white
                green = white
                blue  = white
            }
        }
        //两种构造器都能用于创建一个新的Color实例，你需要为构造器每个外部参数传值：
        
        let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
        let halfGray = Color(white: 0.5)
        //注意，如果不通过外部参数名字传值，你是没法调用这个构造器的。只要构造器定义了某个外部参数名，你就必须使用它，忽略它将导致编译错误：
        
        //let veryGreen = Color(0.0, 1.0, 0.0)
        // 报编译时错误，需要外部名称
        
//  不带外部名的构造器参数
        
        //如果你不希望为构造器的某个参数提供外部名字，你可以使用下划线(_)来显式描述它的外部名，以此重写上面所说的默认行为。
        
        //下面是之前Celsius例子的扩展，跟之前相比添加了一个带有Double类型参数的构造器，其外部名用_代替：
        /*
        struct Celsius {
            var temperatureInCelsius: Double
            init(fromFahrenheit fahrenheit: Double) {
                temperatureInCelsius = (fahrenheit - 32.0) / 1.8
            }
            init(fromKelvin kelvin: Double) {
                temperatureInCelsius = kelvin - 273.15
            }
            init(_ celsius: Double){
                temperatureInCelsius = celsius
            }
        }
        let bodyTemperature = Celsius(37.0)
        */
        // bodyTemperature.temperatureInCelsius 为 37.0
        //调用Celsius(37.0)意图明确，不需要外部参数名称。因此适合使用init(_ celsius: Double)这样的构造器，从而可以通过提供Double类型的参数值调用构造器，而不需要加上外部名。
        
        
// 构造过程中常量属性的修改
        
        //你可以在构造过程中的任意时间点给常量属性指定一个值，只要在构造过程结束时是一个确定的值。一旦常量属性被赋值，它将永远不可更改。
        
        //注意 对于类的实例来说，它的常量属性只能在定义它的类的构造过程中修改；不能在子类中修改。
        //你可以修改上面的SurveyQuestion示例，用常量属性替代变量属性text，表示问题内容text在SurveyQuestion的实例被创建之后不会再被修改。尽管text属性现在是常量，我们仍然可以在类的构造器中设置它的值：
        
        class SurveyQuestion {
            let text: String
            var response: String?
            init(text: String) {
                self.text = text
            }
            func ask() {
                print(text)
            }
        }
        let beetsQuestion = SurveyQuestion(text: "How about beets?")
        beetsQuestion.ask()
        // 打印 "How about beets?"
        beetsQuestion.response = "I also like beets. (But not with cheese.)"
        
// 默认构造器
        //如果结构体或类的所有属性都有默认值，同时没有自定义的构造器，那么 Swift 会给这些结构体或类提供一个默认构造器（default initializers）。这个默认构造器将简单地创建一个所有属性值都设置为默认值的实例。
        
        //下面例子中创建了一个类ShoppingListItem，它封装了购物清单中的某一物品的属性：名字（name）、数量（quantity）和购买状态 purchase state：
        /*
        class ShoppingListItem {
            var name: String?
            var quantity = 1
            var purchased = false
        }
        var item = ShoppingListItem()
        */
// 结构体的逐一成员构造器
        //除了上面提到的默认构造器，如果结构体没有提供自定义的构造器，它们将自动获得一个逐一成员构造器，即使结构体的存储型属性没有默认值。
        /*
        struct Size {
            var width = 0.0, height = 0.0
        }
        let twoByTwo = Size(width: 2.0, height: 2.0)
        */
       
// MARK: 值类型的构造器代理
        //构造器可以通过调用其它构造器来完成实例的部分构造过程。这一过程称为构造器代理，它能减少多个构造器间的代码重复。
        
        //构造器代理的实现规则和形式在值类型和类类型中有所不同。值类型（结构体和枚举类型）不支持继承，所以构造器代理的过程相对简单，因为它们只能代理给自己的其它构造器。类则不同，它可以继承自其它类（请参考继承），这意味着类有责任保证其所有继承的存储型属性在构造时也能正确的初始化。这些责任将在后续章节类的继承和构造过程中介绍。
        
        //对于值类型，你可以使用self.init在自定义的构造器中引用相同类型中的其它构造器。并且你只能在构造器内部调用self.init。
        
        //如果你为某个值类型定义了一个自定义的构造器，你将无法访问到默认构造器（如果是结构体，还将无法访问逐一成员构造器）。这种限制可以防止你为值类型增加了一个额外的且十分复杂的构造器之后,仍然有人错误的使用自动生成的构造器
        
        //注意 假如你希望默认构造器、逐一成员构造器以及你自己的自定义构造器都能用来创建实例，可以将自定义的构造器写到扩展（extension）中，而不是写在值类型的原始定义中。想查看更多内容，请查看扩展章节。
        //下面例子将定义一个结构体Rect，用来代表几何矩形。这个例子需要两个辅助的结构体Size和Point，它们各自为其所有的属性提供了初始值0.0。
        
        struct Size {
            var width = 0.0, height = 0.0
        }
        struct Point {
            var x = 0.0, y = 0.0
        }
        //你可以通过以下三种方式为Rect创建实例——使用被初始化为默认值的origin和size属性来初始化；提供指定的origin和size实例来初始化；提供指定的center和size来初始化。在下面Rect结构体定义中，我们为这三种方式提供了三个自定义的构造器：
        
        struct Rect {
            var origin = Point()
            var size = Size()
            init() {}
            init(origin: Point, size: Size) {
                self.origin = origin
                self.size = size
            }
            init(center: Point, size: Size) {
                let originX = center.x - (size.width / 2)
                let originY = center.y - (size.height / 2)
                self.init(origin: Point(x: originX, y: originY), size: size)
            }
        }
        //第一个Rect构造器init()，在功能上跟没有自定义构造器时自动获得的默认构造器是一样的。这个构造器是一个空函数，使用一对大括号{}来表示，它没有执行任何构造过程。调用这个构造器将返回一个Rect实例，它的origin和size属性都使用定义时的默认值Point(x: 0.0, y: 0.0)和Size(width: 0.0, height: 0.0)：
        
        let basicRect = Rect()
        // basicRect 的 origin 是 (0.0, 0.0)，size 是 (0.0, 0.0)
        //第二个Rect构造器init(origin:size:)，在功能上跟结构体在没有自定义构造器时获得的逐一成员构造器是一样的。这个构造器只是简单地将origin和size的参数值赋给对应的存储型属性：
        
        let originRect = Rect(origin: Point(x: 2.0, y: 2.0),
                              size: Size(width: 5.0, height: 5.0))
        // originRect 的 origin 是 (2.0, 2.0)，size 是 (5.0, 5.0)
        //第三个Rect构造器init(center:size:)稍微复杂一点。它先通过center和size的值计算出origin的坐标，然后再调用（或者说代理给）init(origin:size:)构造器来将新的origin和size值赋值到对应的属性中：
        
        let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                              size: Size(width: 3.0, height: 3.0))
        // centerRect 的 origin 是 (2.5, 2.5)，size 是 (3.0, 3.0)
        //构造器init(center:size:)可以直接将origin和size的新值赋值到对应的属性中。然而，利用恰好提供了相关功能的现有构造器会更为方便，构造器init(center:size:)的意图也会更加清晰。
        
        //注意 如果你想用另外一种不需要自己定义init()和init(origin:size:)的方式来实现这个例子，请参考扩展。
        
        
// MARK: 类的继承和构造过程
        // 指定构造器和便利构造器
        /*
        类的指定构造器的写法跟值类型简单构造器一样：
        
        init(parameters) {
            statements
        }
        便利构造器也采用相同样式的写法，但需要在init关键字之前放置convenience关键字，并使用空格将它们俩分开：
        
        convenience init(parameters) {
            statements
        }
        
        类的构造器代理规则
        
        为了简化指定构造器和便利构造器之间的调用关系，Swift 采用以下三条规则来限制构造器之间的代理调用：
        
        规则 1
        
        指定构造器必须调用其直接父类的的指定构造器。
        
        规则 2
        
        便利构造器必须调用同类中定义的其它构造器。
        
        规则 3
        
        便利构造器必须最终导致一个指定构造器被调用。
        
        一个更方便记忆的方法是：
        
        指定构造器必须总是向上代理
        便利构造器必须总是横向代理
        */
        
// MARK:构造器的继承和重写
        
        //跟 Objective-C 中的子类不同，Swift 中的子类默认情况下不会继承父类的构造器。Swift 的这种机制可以防止一个父类的简单构造器被一个更精细的子类继承，并被错误地用来创建子类的实例。
        
        //注意 父类的构造器仅会在安全和适当的情况下被继承。具体内容请参考后续章节构造器的自动继承。
        //假如你希望自定义的子类中能提供一个或多个跟父类相同的构造器，你可以在子类中提供这些构造器的自定义实现。
        
        //当你在编写一个和父类中指定构造器相匹配的子类构造器时，你实际上是在重写父类的这个指定构造器。因此，你必须在定义子类构造器时带上override修饰符。即使你重写的是系统自动提供的默认构造器，也需要带上override修饰符，具体内容请参考默认构造器。
        
        //正如重写属性，方法或者是下标，override修饰符会让编译器去检查父类中是否有相匹配的指定构造器，并验证构造器参数是否正确。
        
        //注意 当你重写一个父类的指定构造器时，你总是需要写override修饰符，即使你的子类将父类的指定构造器重写为了便利构造器。
        //相反，如果你编写了一个和父类便利构造器相匹配的子类构造器，由于子类不能直接调用父类的便利构造器（每个规则都在上文类的构造器代理规则有所描述），因此，严格意义上来讲，你的子类并未对一个父类构造器提供重写。最后的结果就是，你在子类中“重写”一个父类便利构造器时，不需要加override前缀。
        
        //在下面的例子中定义了一个叫Vehicle的基类。基类中声明了一个存储型属性numberOfWheels，它是值为0的Int类型的存储型属性。numberOfWheels属性用于创建名为descrpiption的String类型的计算型属性：
        
        class Vehicle {
            var numberOfWheels = 0
            var description: String {
                return "\(numberOfWheels) wheel(s)"
            }
        }
        //Vehicle类只为存储型属性提供默认值，而不自定义构造器。因此，它会自动获得一个默认构造器，具体内容请参考默认构造器。自动获得的默认构造器总会是类中的指定构造器，它可以用于创建numberOfWheels为0的Vehicle实例：
        
        let vehicle = Vehicle()
        print("Vehicle: \(vehicle.description)")
        // Vehicle: 0 wheel(s)
        //下面例子中定义了一个Vehicle的子类Bicycle：
        
        class Bicycle: Vehicle {
            override init() {
                super.init()
                numberOfWheels = 2
            }
        }
        //子类Bicycle定义了一个自定义指定构造器init()。这个指定构造器和父类的指定构造器相匹配，所以Bicycle中的指定构造器需要带上override修饰符。
        
        //Bicycle的构造器init()以调用super.init()方法开始，这个方法的作用是调用Bicycle的父类Vehicle的默认构造器。这样可以确保Bicycle在修改属性之前，它所继承的属性numberOfWheels能被Vehicle类初始化。在调用super.init()之后，属性numberOfWheels的原值被新值2替换。
        
        //如果你创建一个Bicycle实例，你可以调用继承的description计算型属性去查看属性numberOfWheels是否有改变：
        
        let bicycle = Bicycle()
        print("Bicycle: \(bicycle.description)")
        // 打印 "Bicycle: 2 wheel(s)"
        //注意 子类可以在初始化时修改继承来的变量属性，但是不能修改继承来的常量属性。
        
       
        
// MARK: 构造器的自动继承
        
        /*
        如上所述，子类在默认情况下不会继承父类的构造器。但是如果满足特定条件，父类构造器是可以被自动继承的。在实践中，这意味着对于许多常见场景你不必重写父类的构造器，并且可以在安全的情况下以最小的代价继承父类的构造器。
        
        假设你为子类中引入的所有新属性都提供了默认值，以下 2 个规则适用：
        
        规则 1
        
        如果子类没有定义任何指定构造器，它将自动继承所有父类的指定构造器。
        
        规则 2
        
        如果子类提供了所有父类指定构造器的实现——无论是通过规则 1 继承过来的，还是提供了自定义实现——它将自动继承所有父类的便利构造器。
        
        即使你在子类中添加了更多的便利构造器，这两条规则仍然适用。
        
        注意
        对于规则 2，子类可以将父类的指定构造器实现为便利构造器。
        
        指定构造器和便利构造器实践
        
        接下来的例子将在实践中展示指定构造器、便利构造器以及构造器的自动继承。这个例子定义了包含三个类Food、RecipeIngredient以及ShoppingListItem的类层次结构，并将演示它们的构造器是如何相互作用的。
        
        类层次中的基类是Food，它是一个简单的用来封装食物名字的类。Food类引入了一个叫做name的String类型的属性，并且提供了两个构造器来创建Food实例：
        */
        class Food {
            var name: String
            init(name: String) {
                self.name = name
            }
            convenience init() {
                self.init(name: "[Unnamed]")
            }
        }
        //下图中展示了Food的构造器链：
        
        //Food构造器链
        
        //类类型没有默认的逐一成员构造器，所以Food类提供了一个接受单一参数name的指定构造器。这个构造器可以使用一个特定的名字来创建新的Food实例：
        
        let namedMeat = Food(name: "Bacon")
        // namedMeat 的名字是 "Bacon”
        //Food类中的构造器init(name: String)被定义为一个指定构造器，因为它能确保Food实例的所有存储型属性都被初始化。Food类没有父类，所以init(name: String)构造器不需要调用super.init()来完成构造过程。
        
        //Food类同样提供了一个没有参数的便利构造器init()。这个init()构造器为新食物提供了一个默认的占位名字，通过横向代理到指定构造器init(name: String)并给参数name传值[Unnamed]来实现：
        
        let mysteryMeat = Food()
        // mysteryMeat 的名字是 [Unnamed]
        //类层级中的第二个类是Food的子类RecipeIngredient。RecipeIngredient类用来表示食谱中的一项原料。它引入了Int类型的属性quantity（以及从Food继承过来的name属性），并且定义了两个构造器来创建RecipeIngredient实例：
        
        class RecipeIngredient: Food {
            var quantity: Int
            init(name: String, quantity: Int) {
                self.quantity = quantity
                super.init(name: name)
            }
            override convenience init(name: String) {
                self.init(name: name, quantity: 1)
            }
        }
        //下图中展示了RecipeIngredient类的构造器链：
        
        //RecipeIngredient构造器
        
        //RecipeIngredient类拥有一个指定构造器init(name: String, quantity: Int)，它可以用来填充RecipeIngredient实例的所有属性值。这个构造器一开始先将传入的quantity参数赋值给quantity属性，这个属性也是唯一在RecipeIngredient中新引入的属性。随后，构造器向上代理到父类Food的init(name: String)。这个过程满足两段式构造过程中的安全检查 1。
        
        //RecipeIngredient还定义了一个便利构造器init(name: String)，它只通过name来创建RecipeIngredient的实例。这个便利构造器假设任意RecipeIngredient实例的quantity为1，所以不需要显式指明数量即可创建出实例。这个便利构造器的定义可以更加方便和快捷地创建实例，并且避免了创建多个quantity为1的RecipeIngredient实例时的代码重复。这个便利构造器只是简单地横向代理到类中的指定构造器，并为quantity参数传递1。
        
        //注意，RecipeIngredient的便利构造器init(name: String)使用了跟Food中指定构造器init(name: String)相同的参数。由于这个便利构造器重写了父类的指定构造器init(name: String)，因此必须在前面使用override修饰符（参见构造器的继承和重写）。
        
        //尽管RecipeIngredient将父类的指定构造器重写为了便利构造器，它依然提供了父类的所有指定构造器的实现。因此，RecipeIngredient会自动继承父类的所有便利构造器。
        
        //在这个例子中，RecipeIngredient的父类是Food，它有一个便利构造器init()。这个便利构造器会被RecipeIngredient继承。这个继承版本的init()在功能上跟Food提供的版本是一样的，只是它会代理到RecipeIngredient版本的init(name: String)而不是Food提供的版本。
        
        //所有的这三种构造器都可以用来创建新的RecipeIngredient实例：
        
        let oneMysteryItem = RecipeIngredient()
        let oneBacon = RecipeIngredient(name: "Bacon")
        let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)
        //类层级中第三个也是最后一个类是RecipeIngredient的子类，叫做ShoppingListItem。这个类构建了购物单中出现的某一种食谱原料。
        
        //购物单中的每一项总是从未购买状态开始的。为了呈现这一事实，ShoppingListItem引入了一个布尔类型的属性purchased，它的默认值是false。ShoppingListItem还添加了一个计算型属性description，它提供了关于ShoppingListItem实例的一些文字描述：
        
        class ShoppingListItem: RecipeIngredient {
            var purchased = false
            var description: String {
                var output = "\(quantity) x \(name)"
                output += purchased ? " ✔" : " ✘"
                return output
            }
        }
        /*
        注意 ShoppingListItem没有定义构造器来为purchased提供初始值，因为添加到购物单的物品的初始状态总是未购买。
        由于它为自己引入的所有属性都提供了默认值，并且自己没有定义任何构造器，ShoppingListItem将自动继承所有父类中的指定构造器和便利构造器。
        
        下图展示了这三个类的构造器链：
        
        三类构造器图
        
        你可以使用全部三个继承来的构造器来创建ShoppingListItem的新实例：
        */
        
        var breakfastList = [
            ShoppingListItem(),
            ShoppingListItem(name: "Bacon"),
            ShoppingListItem(name: "Eggs", quantity: 6),
            ]
        breakfastList[0].name = "Orange juice"
        breakfastList[0].purchased = true
        for item in breakfastList {
            print(item.description)
        }
        // 1 x orange juice ✔
        // 1 x bacon ✘
        // 6 x eggs ✘
        //如上所述，例子中通过字面量方式创建了一个数组breakfastList，它包含了三个ShoppingListItem实例，因此数组的类型也能被自动推导为[ShoppingListItem]。在数组创建完之后，数组中第一个ShoppingListItem实例的名字从[Unnamed]更改为Orange juice，并标记为已购买。打印数组中每个元素的描述显示了它们都已按照预期被赋值。
        
        
        
        
        // 
        
        print()
    }
    
// MARK: 整数
    func testBaseDataType() {
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

