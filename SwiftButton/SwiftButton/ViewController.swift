//
//  ViewController.swift
//  SwiftButton
//
//  Created by ylgwhyh on 16/10/12.
//  Copyright © 2016年 com.ylgwhyh.SwiftButton. All rights reserved.
//

import UIKit

//泛型

struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

protocol Container {
    associatedtype ItemType
    mutating func append(_ item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}


//协议和扩展
protocol ExampleProtocol {
    var simpleDescription: String { get }
    
    //协议的Mutating方法要求，允许在该方法内修改值类型
    mutating func adjust()
}

// MARK: 扩展
// func extensions() 里面注释的方法放的位置
extension Int {
    enum Kind {
        case Negative, Zero, Positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .Zero
        case let x where x > 0:
            return .Positive
        default:
            return .Negative
        }
    }
}


extension Double {
    var km: Double { return self * 1_000.0 }
    var m : Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}


extension CGRect {
    init(center: CGPoint, size: CGSize) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: CGPoint(x: originX, y: originY), size: size)
    }
}

extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

extension Int {
    mutating func square() {
        self = self * self
    }
}

extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
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


// MARK: 协议

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

//在协议中定义类型属性时，总是使用 static 关键字作为前缀。当类类型遵循协议时，除了 static 关键字，还可以使用 class 关键字来声明类型属性：

protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}
//如下所示，这是一个只含有一个实例属性要求的协议：

protocol FullyNamed {
    var fullName: String { get }
}

protocol TextRepresentable {
    var textualDescription: String { get }
}
//可以通过扩展，令先前提到的 Dice 类遵循并符合 TextRepresentable 协议：

//protocol SomeProtocol {
//    static func someTypeMethod()
//}
//下面的例子定义了一个只含有一个实例方法的协议：

protocol RandomNumberGenerator {
    func random() -> Double
}

//protocol SomeProtocol {
//    init(someParameter: Int)
//}

protocol Togglable {
    mutating func toggle()
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}
/*
 通过扩展遵循并符合协议，和在原始定义中遵循并符合协议的效果完全相同。协议名称写在类型名之后，以冒号隔开，然后在扩展的大括号内实现协议要求的内容。
 
 现在所有 Dice 的实例都可以看做 TextRepresentable 类型：
 */

// 打印 “A 12-sided dice”
//同样，SnakesAndLadders 类也可以通过扩展遵循并符合 TextRepresentable 协议：


protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}

protocol HasArea {
    var area: Double { get }
}


protocol DiceGameDelegate {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

@objc protocol CounterDataSource {
    @objc optional func incrementForCount(count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

extension PrettyTextRepresentable  {
    var prettyTextualDescription: String {
        return textualDescription
    }
}

extension Collection where Iterator.Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}

extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}

struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}

extension Hamster: TextRepresentable {
    
}


extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = [Int](repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}


protocol DiceGame {
    var dice: Dice { get }
    func play()
}


protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    // 这里是协议的定义部分
}
//如下所示，PrettyTextRepresentable 协议继承了 TextRepresentable 协议：

protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
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
        self.deinitialization() //析构过程
        self.arc()             //ARC
        self.optionalChainCalls() //可选链式调用
        self.errorHandling()   // 错误处理
        self.typeConversion()  //类型转换
        self.nestedtype()      //嵌套类型
        self.extensions()      //扩展方法
        self.protocolTest()    //协议
        self.testGenericity()  //泛型
        self.accessControl()   //访问控制
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
        /*
        class SomeClass {
            class func someTypeMethod() {
                // 在这里实现类型方法
            }
        }
        SomeClass.someTypeMethod()
        */
        
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
        
        
        
        
// MARK:可失败构造器
        /*
        如果一个类、结构体或枚举类型的对象，在构造过程中有可能失败，则为其定义一个可失败构造器。这里所指的“失败”是指，如给构造器传入无效的参数值，或缺少某种所需的外部资源，又或是不满足某种必要的条件等。
        
        为了妥善处理这种构造过程中可能会失败的情况。你可以在一个类，结构体或是枚举类型的定义中，添加一个或多个可失败构造器。其语法为在init关键字后面添加问号(init?)。
        
        注意
        可失败构造器的参数名和参数类型，不能与其它非可失败构造器的参数名，及其参数类型相同。
        可失败构造器会创建一个类型为自身类型的可选类型的对象。你通过return nil语句来表明可失败构造器在何种情况下应该“失败”。
        
        注意 严格来说，构造器都不支持返回值。因为构造器本身的作用，只是为了确保对象能被正确构造。因此你只是用return nil表明可失败构造器构造失败，而不要用关键字return来表明构造成功。
        例如，实现针对数字类型转换的可失败构造器。确保数字类型之间的转换能保持精确的值，使用这个 init(exactly:) 构造器。如果类型转换不能保持值不变，则这个构造器构造失败。
        */
        
// WARNING: 这里还有错
        /*
        let wholeNumber: Double = 12345.0
        let pi = 3.14159
        
        if let valueMaintained = Int(exactly: wholeNumber) {
            print("\(wholeNumber) conversion to Int maintains value")
        }
        // 打印 "12345.0 conversion to Int maintains value"
        
        let valueChanged = Int(exactly: pi)
        // valueChanged 是 Int? 类型, 不是 Int 类型
        
        if valueChanged == nil {
            print("\(pi) conversion to Int does not maintain value")
        }
        */
        // 打印 "3.14159 conversion to Int does not maintain value"
        //下例中，定义了一个名为Animal的结构体，其中有一个名为species的String类型的常量属性。同时该结构体还定义了一个接受一个名为species的String类型参数的可失败构造器。这个可失败构造器检查传入的参数是否为一个空字符串。如果为空字符串，则构造失败。否则，species属性被赋值，构造成功。
        
        struct Animal {
            let species: String
            init?(species: String) {
                if species.isEmpty { return nil }
                self.species = species
            }
        }
        //你可以通过该可失败构造器来构建一个Animal的实例，并检查构造过程是否成功：
        
        let someCreature = Animal(species: "Giraffe")
        // someCreature 的类型是 Animal? 而不是 Animal
        
        if let giraffe = someCreature {
            print("An animal was initialized with a species of \(giraffe.species)")
        }
        // 打印 "An animal was initialized with a species of Giraffe"
        //如果你给该可失败构造器传入一个空字符串作为其参数，则会导致构造失败：
        
        let anonymousCreature = Animal(species: "")
        // anonymousCreature 的类型是 Animal?, 而不是 Animal
        
        if anonymousCreature == nil {
            print("The anonymous creature could not be initialized")
        }
        // 打印 "The anonymous creature could not be initialized"
        //注意 空字符串（如""，而不是"Giraffe"）和一个值为nil的可选类型的字符串是两个完全不同的概念。上例中的空字符串（""）其实是一个有效的，非可选类型的字符串。这里我们之所以让Animal的可失败构造器构造失败，只是因为对于Animal这个类的species属性来说，它更适合有一个具体的值，而不是空字符串。
        
        
        
// MARK:重写一个可失败构造器
        /*
        如同其它的构造器，你可以在子类中重写父类的可失败构造器。或者你也可以用子类的非可失败构造器重写一个父类的可失败构造器。这使你可以定义一个不会构造失败的子类，即使父类的构造器允许构造失败。
        
        注意，当你用子类的非可失败构造器重写父类的可失败构造器时，向上代理到父类的可失败构造器的唯一方式是对父类的可失败构造器的返回值进行强制解包。
        
        注意
        你可以用非可失败构造器重写可失败构造器，但反过来却不行。
        下例定义了一个名为Document的类，name属性的值必须为一个非空字符串或nil，但不能是一个空字符串：
        */
        
        class Document {
            var name: String?
            // 该构造器创建了一个 name 属性的值为 nil 的 document 实例
            init() {}
            // 该构造器创建了一个 name 属性的值为非空字符串的 document 实例
            init?(name: String) {
                self.name = name
                if name.isEmpty { return nil }
            }
        }
        //下面这个例子，定义了一个Document类的子类AutomaticallyNamedDocument。这个子类重写了父类的两个指定构造器，确保了无论是使用init()构造器，还是使用init(name:)构造器并为参数传递空字符串，生成的实例中的name属性总有初始"[Untitled]"：
        
        class AutomaticallyNamedDocument: Document {
            override init() {
                super.init()
                self.name = "[Untitled]"
            }
            override init(name: String) {
                super.init()
                if name.isEmpty {
                    self.name = "[Untitled]"
                } else {
                    self.name = name
                }
            }
        }
       //AutomaticallyNamedDocument用一个非可失败构造器init(name:)重写了父类的可失败构造器init?(name:)。因为子类用另一种方式处理了空字符串的情况，所以不再需要一个可失败构造器，因此子类用一个非可失败构造器代替了父类的可失败构造器。
        
        //你可以在子类的非可失败构造器中使用强制解包来调用父类的可失败构造器。比如，下面的UntitledDocument子类的name属性的值总是"[Untitled]"，它在构造过程中使用了父类的可失败构造器init?(name:)：
        
        class UntitledDocument: Document {
            override init() {
                super.init(name: "[Untitled]")!
            }
        }
        //在这个例子中，如果在调用父类的可失败构造器init?(name:)时传入的是空字符串，那么强制解包操作会引发运行时错误。不过，因为这里是通过非空的字符串常量来调用它，所以并不会发生运行时错误。
        
        /*
        可失败构造器 init!
        
        通常来说我们通过在init关键字后添加问号的方式（init?）来定义一个可失败构造器，但你也可以通过在init后面添加惊叹号的方式来定义一个可失败构造器（init!），该可失败构造器将会构建一个对应类型的隐式解包可选类型的对象。
        
        你可以在init?中代理到init!，反之亦然。你也可以用init?重写init!，反之亦然。你还可以用init代理到init!，不过，一旦init!构造失败，则会触发一个断言。
        
        
        必要构造器
        在类的构造器前添加required修饰符表明所有该类的子类都必须实现该构造器：
        */
        class SomeClass {
            required init() {
                // 构造器的实现代码
            }
        }
        //在子类重写父类的必要构造器时，必须在子类的构造器前也添加required修饰符，表明该构造器要求也应用于继承链后面的子类。在重写父类中必要的指定构造器时，不需要添加override修饰符：
        
        class SomeSubclass: SomeClass {
            required init() {
                // 构造器的实现代码
            }
        }
        /*
        注意如果子类继承的构造器能满足必要构造器的要求，则无须在子类中显式提供必要构造器的实现。
        
        通过闭包或函数设置属性的默认值
        如果某个存储型属性的默认值需要一些定制或设置，你可以使用闭包或全局函数为其提供定制的默认值。每当某个属性所在类型的新实例被创建时，对应的闭包或函数会被调用，而它们的返回值会当做默认值赋值给这个属性。
        
        这种类型的闭包或函数通常会创建一个跟属性类型相同的临时变量，然后修改它的值以满足预期的初始状态，最后返回这个临时变量，作为属性的默认值。
        
        下面介绍了如何用闭包为属性提供默认值：
        */
        /*
        class SomeClass {
            let someProperty: SomeType = {
                // 在这个闭包中给 someProperty 创建一个默认值
                // someValue 必须和 SomeType 类型相同
                return someValue
            }()
        }
        */
        /*
        注意闭包结尾的大括号后面接了一对空的小括号。这用来告诉 Swift 立即执行此闭包。如果你忽略了这对括号，相当于将闭包本身作为值赋值给了属性，而不是将闭包的返回值赋值给属性。
        
        注意
        如果你使用闭包来初始化属性，请记住在闭包执行时，实例的其它部分都还没有初始化。这意味着你不能在闭包里访问其它属性，即使这些属性有默认值。同样，你也不能使用隐式的self属性，或者调用任何实例方法。
        下面例子中定义了一个结构体Checkerboard，它构建了西洋跳棋游戏的棋盘：
        
        西洋跳棋棋盘
        
        西洋跳棋游戏在一副黑白格交替的10x10的棋盘中进行。为了呈现这副游戏棋盘，Checkerboard结构体定义了一个属性boardColors，它是一个包含100个Bool值的数组。在数组中，值为true的元素表示一个黑格，值为false的元素表示一个白格。数组中第一个元素代表棋盘上左上角的格子，最后一个元素代表棋盘上右下角的格子。
        
        boardColor数组是通过一个闭包来初始化并设置颜色值的：
        */
        struct Checkerboard {
            let boardColors: [Bool] = {
                var temporaryBoard = [Bool]()
                var isBlack = false
                for i in 1...8 {
                    for j in 1...8 {
                        temporaryBoard.append(isBlack)
                        isBlack = !isBlack
                    }
                    isBlack = !isBlack
                }
                return temporaryBoard
            }()
            func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
                return boardColors[(row * 8) + column]
            }
        }
        //每当一个新的Checkerboard实例被创建时，赋值闭包会被执行，boardColors的默认值会被计算出来并返回。上面例子中描述的闭包将计算出棋盘中每个格子对应的颜色，并将这些值保存到一个临时数组temporaryBoard中，最后在构建完成时将此数组作为闭包返回值返回。这个返回的数组会保存到boardColors中，并可以通过工具函数squareIsBlackAtRow来查询：
        
        let board = Checkerboard()
        print(board.squareIsBlackAtRow(row: 0, column: 1))
        // 打印 "true"
        print(board.squareIsBlackAtRow(row: 7, column: 7))
        // 打印 "false"
        
        print()
    }
    
    
// MARK:Deinitialization
    
    func deinitialization () {
        
        /*
        本页包含内容：
        
        析构过程原理
        析构器实践
        析构器只适用于类类型，当一个类的实例被释放之前，析构器会被立即调用。析构器用关键字deinit来标示，类似于构造器要用init来标示。
        
        
        析构过程原理
        Swift 会自动释放不再需要的实例以释放资源。如自动引用计数章节中所讲述，Swift 通过自动引用计数（ARC）处理实例的内存管理。通常当你的实例被释放时不需要手动地去清理。但是，当使用自己的资源时，你可能需要进行一些额外的清理。例如，如果创建了一个自定义的类来打开一个文件，并写入一些数据，你可能需要在类实例被释放之前手动去关闭该文件。
        
        在类的定义中，每个类最多只能有一个析构器，而且析构器不带任何参数，如下所示：
        
        deinit {
            // 执行析构过程
        }
        析构器是在实例释放发生前被自动调用。你不能主动调用析构器。子类继承了父类的析构器，并且在子类析构器实现的最后，父类的析构器会被自动调用。即使子类没有提供自己的析构器，父类的析构器也同样会被调用。
        
        因为直到实例的析构器被调用后，实例才会被释放，所以析构器可以访问实例的所有属性，并且可以根据那些属性可以修改它的行为（比如查找一个需要被关闭的文件）。
        
        
        析构器实践
        这是一个析构器实践的例子。这个例子描述了一个简单的游戏，这里定义了两种新类型，分别是Bank和Player。Bank类管理一种虚拟硬币，确保流通的硬币数量永远不可能超过 10,000。在游戏中有且只能有一个Bank存在，因此Bank用类来实现，并使用类型属性和类型方法来存储和管理其当前状态。
        */
        
        class Bank {
            static var coinsInBank = 10_000
            static func distribute(coins numberOfCoinsRequested: Int) -> Int {
                let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
                coinsInBank -= numberOfCoinsToVend
                return numberOfCoinsToVend
            }
            static func receive(coins: Int) {
                coinsInBank += coins
            }
        }
        /*
        Bank使用coinsInBank属性来跟踪它当前拥有的硬币数量。Bank还提供了两个方法，distribute(coins:)和receive(coins:)，分别用来处理硬币的分发和收集。
        
        distribute(coins:)方法在Bank对象分发硬币之前检查是否有足够的硬币。如果硬币不足，Bank对象会返回一个比请求时小的数字（如果Bank对象中没有硬币了就返回0）。此方法返回一个整型值，表示提供的硬币的实际数量。
        
        receive(coins:)方法只是将Bank实例接收到的硬币数目加回硬币存储中。
        
        Player类描述了游戏中的一个玩家。每一个玩家在任意时间都有一定数量的硬币存储在他们的钱包中。这通过玩家的coinsInPurse属性来表示：
        */
        class Player {
            var coinsInPurse: Int
            init(coins: Int) {
                coinsInPurse = Bank.distribute(coins: coins)
            }
            func win(coins: Int) {
                coinsInPurse += Bank.distribute(coins: coins)
            }
            deinit {
                Bank.receive(coins: coinsInPurse)
            }
        }
        //每个Player实例在初始化的过程中，都从Bank对象获取指定数量的硬币。如果没有足够的硬币可用，Player实例可能会收到比指定数量少的硬币.
        
        //Player类定义了一个win(coins:)方法，该方法从Bank对象获取一定数量的硬币，并把它们添加到玩家的钱包。Player类还实现了一个析构器，这个析构器在Player实例释放前被调用。在这里，析构器的作用只是将玩家的所有硬币都返还给Bank对象：
        
        var playerOne: Player? = Player(coins: 100)
        print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
        // 打印 "A new player has joined the game with 100 coins"
        print("There are now \(Bank.coinsInBank) coins left in the bank")
        // 打印 "There are now 9900 coins left in the bank"
        //创建一个Player实例的时候，会向Bank对象请求 100 个硬币，如果有足够的硬币可用的话。这个Player实例存储在一个名为playerOne的可选类型的变量中。这里使用了一个可选类型的变量，因为玩家可以随时离开游戏，设置为可选使你可以追踪玩家当前是否在游戏中。
        
        //因为playerOne是可选的，所以访问其coinsInPurse属性来打印钱包中的硬币数量时，使用感叹号（!）来解包：
        
        playerOne!.win(coins: 2_000)
        print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
        // 输出 "PlayerOne won 2000 coins & now has 2100 coins"
        print("The bank now only has \(Bank.coinsInBank) coins left")
        // 输出 "The bank now only has 7900 coins left"
        //这里，玩家已经赢得了 2,000 枚硬币，所以玩家的钱包中现在有 2,100 枚硬币，而Bank对象只剩余 7,900 枚硬币。
        
        playerOne = nil
        print("PlayerOne has left the game")
        // 打印 "PlayerOne has left the game"
        print("The bank now has \(Bank.coinsInBank) coins")
        // 打印 "The bank now has 10000 coins"
        //玩家现在已经离开了游戏。这通过将可选类型的playerOne变量设置为nil来表示，意味着“没有Player实例”。当这一切发生时，playerOne变量对Player实例的引用被破坏了。没有其它属性或者变量引用Player实例，因此该实例会被释放，以便回收内存。在这之前，该实例的析构器被自动调用，玩家的硬币被返还给银行。
        
         print()
    }
    
// MARK:ARC
    
    func arc() {
        
        
        /*
         解决实例之间的循环强引用
         Swift 提供了两种办法用来解决你在使用类的属性时所遇到的循环强引用问题：弱引用（weak reference）和无主引用（unowned reference）。
         
         弱引用和无主引用允许循环引用中的一个实例引用而另外一个实例不保持强引用。这样实例能够互相引用而不产生循环强引用。
         
         当其他的实例有更短的生命周期时，使用弱引用，也就是说，当其他实例析构在先时。在上面公寓的例子中，很显然一个公寓在它的生命周期内会在某个时间段没有它的主人，所以一个弱引用就加在公寓类里面，避免循环引用。相比之下，当其他实例有相同的或者更长生命周期时，请使用无主引用。
         */
        
// 弱引用
        
        class Person {
            let name: String
            init(name: String) { self.name = name }
            var apartment: Apartment?
            deinit { print("\(name) is being deinitialized") }
        }
        
        class Apartment {
            let unit: String
            init(unit: String) { self.unit = unit }
            weak var tenant: Person?
            deinit { print("Apartment \(unit) is being deinitialized") }
        }
        
        var john: Person?
        var unit4A: Apartment?
        
        john = Person(name: "John Appleseed")
        unit4A = Apartment(unit: "4A")
        
        john!.apartment = unit4A
        unit4A!.tenant = john
        
        john = nil
        // 打印 “John Appleseed is being deinitialized”
        
        unit4A = nil
        // 打印 “Apartment 4A is being deinitialized”
        
//无主引用
        /*
        和弱引用类似，无主引用不会牢牢保持住引用的实例。和弱引用不同的是，无主引用在其他实例有相同或者更长的生命周期时使用。你可以在声明属性或者变量时，在前面加上关键字unowned表示这是一个无主引用。
        
        无主引用通常都被期望拥有值。不过 ARC 无法在实例被销毁后将无主引用设为nil，因为非可选类型的变量不允许被赋值为nil。
        
        重要
        使用无主引用，你必须确保引用始终指向一个未销毁的实例。
        如果你试图在实例被销毁后，访问该实例的无主引用，会触发运行时错误。
        */
        class Customer {
            let name: String
            var card: CreditCard?
            init(name: String) {
                self.name = name
            }
            deinit { print("\(name) is being deinitialized") }
        }
        class CreditCard {
            let number: UInt64
            unowned let customer: Customer
            init(number: UInt64, customer: Customer) {
                self.number = number
                self.customer = customer
            }
            deinit { print("Card #\(number) is being deinitialized") }
        }

        /*
        var john: Customer?
        john = Customer(name: "John Appleseed")
        john!.card = CreditCard(number: 1234_5678_9012_3456, customer: john!)
        
        john = nil
         
        // 打印 “John Appleseed is being deinitialized”
        // 打印 ”Card #1234567890123456 is being deinitialized”
        */
        

        
        /*
        最后的代码展示了在john变量被设为nil后Customer实例和CreditCard实例的构造函数都打印出了“销毁”的信息。
        
        注意
        上面的例子展示了如何使用安全的无主引用。对于需要禁用运行时的安全检查的情况（例如，出于性能方面的原因），Swift还提供了不安全的无主引用。与所有不安全的操作一样，你需要负责检查代码以确保其安全性。 你可以通过unowned(unsafe)来声明不安全无主引用。如果你试图在实例被销毁后，访问该实例的不安全无主引用，你的程序会尝试访问该实例之前所在的内存地址，这是一个不安全的操作。
        */
        
        
//无主引用以及隐式解析可选属性
        
        /*
        上面弱引用和无主引用的例子涵盖了两种常用的需要打破循环强引用的场景。
        
        Person和Apartment的例子展示了两个属性的值都允许为nil，并会潜在的产生循环强引用。这种场景最适合用弱引用来解决。
        
        Customer和CreditCard的例子展示了一个属性的值允许为nil，而另一个属性的值不允许为nil，这也可能会产生循环强引用。这种场景最适合通过无主引用来解决。
        
        然而，存在着第三种场景，在这种场景中，两个属性都必须有值，并且初始化完成后永远不会为nil。在这种场景中，需要一个类使用无主属性，而另外一个类使用隐式解析可选属性。
        
        这使两个属性在初始化完成后能被直接访问（不需要可选展开），同时避免了循环引用。这一节将为你展示如何建立这种关系。
        
        下面的例子定义了两个类，Country和City，每个类将另外一个类的实例保存为属性。在这个模型中，每个国家必须有首都，每个城市必须属于一个国家。为了实现这种关系，Country类拥有一个capitalCity属性，而City类有一个country属性：
        */
        
        class Country {
            let name: String
            var capitalCity: City!
            init(name: String, capitalName: String) {
                self.name = name
                self.capitalCity = City(name: capitalName, country: self)
            }
        }
        
        class City {
            let name: String
            unowned let country: Country
            init(name: String, country: Country) {
                self.name = name
                self.country = country
            }
        }
        /*
        为了建立两个类的依赖关系，City的构造函数接受一个Country实例作为参数，并且将实例保存到country属性。
        
        Country的构造函数调用了City的构造函数。然而，只有Country的实例完全初始化后，Country的构造函数才能把self传给City的构造函数。在两段式构造过程中有具体描述。
        
        为了满足这种需求，通过在类型结尾处加上感叹号（City!）的方式，将Country的capitalCity属性声明为隐式解析可选类型的属性。这意味着像其他可选类型一样，capitalCity属性的默认值为nil，但是不需要展开它的值就能访问它。在隐式解析可选类型中有描述。
        
        由于capitalCity默认值为nil，一旦Country的实例在构造函数中给name属性赋值后，整个初始化过程就完成了。这意味着一旦name属性被赋值后，Country的构造函数就能引用并传递隐式的self。Country的构造函数在赋值capitalCity时，就能将self作为参数传递给City的构造函数。
        
        以上的意义在于你可以通过一条语句同时创建Country和City的实例，而不产生循环强引用，并且capitalCity的属性能被直接访问，而不需要通过感叹号来展开它的可选值：
        */
        
        var country = Country(name: "Canada", capitalName: "Ottawa")
        print("\(country.name)'s capital city is called \(country.capitalCity.name)")
        // 打印 “Canada's capital city is called Ottawa”
        //在上面的例子中，使用隐式解析可选值意味着满足了类的构造函数的两个构造阶段的要求。capitalCity属性在初始化完成后，能像非可选值一样使用和存取，同时还避免了循环强引用。
        
// MARK: 闭包引起的循环强引用
        /*
        前面我们看到了循环强引用是在两个类实例属性互相保持对方的强引用时产生的，还知道了如何用弱引用和无主引用来打破这些循环强引用。
        
        循环强引用还会发生在当你将一个闭包赋值给类实例的某个属性，并且这个闭包体中又使用了这个类实例时。这个闭包体中可能访问了实例的某个属性，例如self.someProperty，或者闭包中调用了实例的某个方法，例如self.someMethod()。这两种情况都导致了闭包“捕获”self，从而产生了循环强引用。
        
        循环强引用的产生，是因为闭包和类相似，都是引用类型。当你把一个闭包赋值给某个属性时，你是将这个闭包的引用赋值给了属性。实质上，这跟之前的问题是一样的——两个强引用让彼此一直有效。但是，和两个类实例不同，这次一个是类实例，另一个是闭包。
        
        Swift 提供了一种优雅的方法来解决这个问题，称之为闭包捕获列表（closure capture list）。同样的，在学习如何用闭包捕获列表打破循环强引用之前，先来了解一下这里的循环强引用是如何产生的，这对我们很有帮助。
        
        下面的例子为你展示了当一个闭包引用了self后是如何产生一个循环强引用的。例子中定义了一个叫HTMLElement的类，用一种简单的模型表示 HTML 文档中的一个单独的元素：
        */
        
        // 下面报错，暂时注释掉
        class HTMLElement {
            
            let name: String
            let text: String?
            
//            lazy var asHTML: Void -> String = {
//                if let text = self.text {
//                    return "<\(self.name)>\(text)</\(self.name)>"
//                } else {
//                    return "<\(self.name) />"
//                }
//            }
            
            init(name: String, text: String? = nil) {
                self.name = name
                self.text = text
            }
            
            deinit {
                print("\(name) is being deinitialized")
            }
            
        }
        
        /*
        HTMLElement类定义了一个name属性来表示这个元素的名称，例如代表头部元素的"h1"，代表段落的“p”，或者代表换行的“br”。HTMLElement还定义了一个可选属性text，用来设置 HTML 元素呈现的文本。
        
        除了上面的两个属性，HTMLElement还定义了一个lazy属性asHTML。这个属性引用了一个将name和text组合成 HTML 字符串片段的闭包。该属性是Void -> String类型，或者可以理解为“一个没有参数，返回String的函数”。
        
        默认情况下，闭包赋值给了asHTML属性，这个闭包返回一个代表 HTML 标签的字符串。如果text值存在，该标签就包含可选值text；如果text不存在，该标签就不包含文本。对于段落元素，根据text是“some text”还是nil，闭包会返回"<p>some text</p>"或者"<p />"。
        
        可以像实例方法那样去命名、使用asHTML属性。然而，由于asHTML是闭包而不是实例方法，如果你想改变特定 HTML 元素的处理方式的话，可以用自定义的闭包来取代默认值。
        
        例如，可以将一个闭包赋值给asHTML属性，这个闭包能在text属性是nil时使用默认文本，这是为了避免返回一个空的 HTML 标签：
        */
        
//        let heading = HTMLElement(name: "h1")
//        let defaultText = "some default text"
//        heading.asHTML = {
//            return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
//        }
//        print(heading.asHTML())
        // 打印 “<h1>some default text</h1>”
        /*
        注意 asHTML声明为lazy属性，因为只有当元素确实需要被处理为 HTML 输出的字符串时，才需要使用asHTML。也就是说，在默认的闭包中可以使用self，因为只有当初始化完成以及self确实存在后，才能访问lazy属性。
        HTMLElement类只提供了一个构造函数，通过name和text（如果有的话）参数来初始化一个新元素。该类也定义了一个析构函数，当HTMLElement实例被销毁时，打印一条消息。
        
        下面的代码展示了如何用HTMLElement类创建实例并打印消息：
        */
        var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
        //print(paragraph!.asHTML())
        // 打印 “<p>hello, world</p>”
        
        /*
        注意 上面的paragraph变量定义为可选类型的HTMLElement，因此我们可以赋值nil给它来演示循环强引用。
        不幸的是，上面写的HTMLElement类产生了类实例和作为asHTML默认值的闭包之间的循环强引用。循环强引用如下图所示：
        
        实例的asHTML属性持有闭包的强引用。但是，闭包在其闭包体内使用了self（引用了self.name和self.text），因此闭包捕获了self，这意味着闭包又反过来持有了HTMLElement实例的强引用。这样两个对象就产生了循环强引用。（更多关于闭包捕获值的信息，请参考值捕获）。
        
        注意
        虽然闭包多次使用了self，它只捕获HTMLElement实例的一个强引用。
        如果设置paragraph变量为nil，打破它持有的HTMLElement实例的强引用，HTMLElement实例和它的闭包都不会被销毁，也是因为循环强引用：
        */
        paragraph = nil
        //注意，HTMLElement的析构函数中的消息并没有被打印，证明了HTMLElement实例并没有被销毁。
        
        
// MARK:解决闭包引起的循环强引用
        /*
        在定义闭包时同时定义捕获列表作为闭包的一部分，通过这种方式可以解决闭包和类实例之间的循环强引用。捕获列表定义了闭包体内捕获一个或者多个引用类型的规则。跟解决两个类实例间的循环强引用一样，声明每个捕获的引用为弱引用或无主引用，而不是强引用。应当根据代码关系来决定使用弱引用还是无主引用。
        
        注意 Swift 有如下要求：只要在闭包内使用self的成员，就要用self.someProperty或者self.someMethod()（而不只是someProperty或someMethod()）。这提醒你可能会一不小心就捕获了self。
        
        定义捕获列表
        
        捕获列表中的每一项都由一对元素组成，一个元素是weak或unowned关键字，另一个元素是类实例的引用（例如self）或初始化过的变量（如delegate = self.delegate!）。这些项在方括号中用逗号分开。
        
        如果闭包有参数列表和返回类型，把捕获列表放在它们前面：
        */
        
//        lazy var someClosure: (Int, String) -> String = {
//            [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
//            // 这里是闭包的函数体
//        }
        //如果闭包没有指明参数列表或者返回类型，即它们会通过上下文推断，那么可以把捕获列表和关键字in放在闭包最开始的地方：
        
//        lazy var someClosure: Void -> String = {
//            [unowned self, weak delegate = self.delegate!] in
//            // 这里是闭包的函数体
//        }
        
        /*
        弱引用和无主引用
        
        在闭包和捕获的实例总是互相引用并且总是同时销毁时，将闭包内的捕获定义为无主引用。
        
        相反的，在被捕获的引用可能会变为nil时，将闭包内的捕获定义为弱引用。弱引用总是可选类型，并且当引用的实例被销毁后，弱引用的值会自动置为nil。这使我们可以在闭包体内检查它们是否存在。
        
        注意
        如果被捕获的引用绝对不会变为nil，应该用无主引用，而不是弱引用。
        前面的HTMLElement例子中，无主引用是正确的解决循环强引用的方法。这样编写HTMLElement类来避免循环强引用：
        */
        
        /*
        class HTMLElement {
            
            let name: String
            let text: String?
            
            lazy var asHTML: Void -> String = {
                [unowned self] in
                if let text = self.text {
                    return "<\(self.name)>\(text)</\(self.name)>"
                } else {
                    return "<\(self.name) />"
                }
            }
            
            init(name: String, text: String? = nil) {
                self.name = name
                self.text = text
            }
            
            deinit {
                print("\(name) is being deinitialized")
            }
            
        }
        */
        /*
        上面的HTMLElement实现和之前的实现一致，除了在asHTML闭包中多了一个捕获列表。这里，捕获列表是[unowned self]，表示“将self捕获为无主引用而不是强引用”。
        
        和之前一样，我们可以创建并打印HTMLElement实例：
        */
//        var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
//        print(paragraph!.asHTML())
        // 打印 “<p>hello, world</p>”
        //使用捕获列表后引用关系如下图所示：
        
        
        
        //这一次，闭包以无主引用的形式捕获self，并不会持有HTMLElement实例的强引用。如果将paragraph赋值为nil，HTMLElement实例将会被销毁，并能看到它的析构函数打印出的消息：
        
        paragraph = nil
        // 打印 “p is being deinitialized”
        
        print()
    }
    
// MARK: 可选链式调用
    
    /*
     本页包含内容：
     
     使用可选链式调用代替强制展开
     为可选链式调用定义模型类
     通过可选链式调用访问属性
     通过可选链式调用调用方法
     通过可选链式调用访问下标
     连接多层可选链式调用
     在方法的可选返回值上进行可选链式调用
     */
    
    func optionalChainCalls () {
        /*
        可选链式调用是一种可以在当前值可能为nil的可选值上请求和调用属性、方法及下标的方法。如果可选值有值，那么调用就会成功；如果可选值是nil，那么调用将返回nil。多个调用可以连接在一起形成一个调用链，如果其中任何一个节点为nil，整个调用链都会失败，即返回nil。
        
        注意
        Swift 的可选链式调用和 Objective-C 中向nil发送消息有些相像，但是 Swift 的可选链式调用可以应用于任意类型，并且能检查调用是否成功。
        
        使用可选链式调用代替强制展开
        通过在想调用的属性、方法、或下标的可选值后面放一个问号（?），可以定义一个可选链。这一点很像在可选值后面放一个叹号（!）来强制展开它的值。它们的主要区别在于当可选值为空时可选链式调用只会调用失败，然而强制展开将会触发运行时错误。
        
        为了反映可选链式调用可以在空值（nil）上调用的事实，不论这个调用的属性、方法及下标返回的值是不是可选值，它的返回结果都是一个可选值。你可以利用这个返回值来判断你的可选链式调用是否调用成功，如果调用有返回值则说明调用成功，返回nil则说明调用失败。
        
        特别地，可选链式调用的返回结果与原本的返回结果具有相同的类型，但是被包装成了一个可选值。例如，使用可选链式调用访问属性，当可选链式调用成功时，如果属性原本的返回结果是Int类型，则会变为Int?类型。
        
        下面几段代码将解释可选链式调用和强制展开的不同。
        
        首先定义两个类Person和Residence：
        */
        class Person {
            var residence: Residence?
        }
        
        class Residence {
            var numberOfRooms = 1
        }
        //Residence有一个Int类型的属性numberOfRooms，其默认值为1。Person具有一个可选的residence属性，其类型为Residence?。
        
        //假如你创建了一个新的Person实例,它的residence属性由于是是可选型而将初始化为nil,在下面的代码中,john有一个值为nil的residence属性：
        
        let john = Person()
        //如果使用叹号（!）强制展开获得这个john的residence属性中的numberOfRooms值，会触发运行时错误，因为这时residence没有可以展开的值：
        
        //let roomCount = john.residence!.numberOfRooms
        // 这会引发运行时错误
        //john.residence为非nil值的时候，上面的调用会成功，并且把roomCount设置为Int类型的房间数量。正如上面提到的，当residence为nil的时候上面这段代码会触发运行时错误。
        
        //可选链式调用提供了另一种访问numberOfRooms的方式，使用问号（?）来替代原来的叹号（!）：
        
        if let roomCount = john.residence?.numberOfRooms {
            print("John's residence has \(roomCount) room(s).")
        } else {
            print("Unable to retrieve the number of rooms.")
        }
        // 打印 “Unable to retrieve the number of rooms.”
        /*
        在residence后面添加问号之后，Swift 就会在residence不为nil的情况下访问numberOfRooms。
        
        因为访问numberOfRooms有可能失败，可选链式调用会返回Int?类型，或称为“可选的 Int”。如上例所示，当residence为nil的时候，可选的Int将会为nil，表明无法访问numberOfRooms。访问成功时，可选的Int值会通过可选绑定展开，并赋值给非可选类型的roomCount常量。
        
        要注意的是，即使numberOfRooms是非可选的Int时，这一点也成立。只要使用可选链式调用就意味着numberOfRooms会返回一个Int?而不是Int。
        
        可以将一个Residence的实例赋给john.residence，这样它就不再是nil了：
        
        john.residence = Residence()
        john.residence现在包含一个实际的Residence实例，而不再是nil。如果你试图使用先前的可选链式调用访问numberOfRooms，它现在将返回值为1的Int?类型的值：
        */
        
        if let roomCount = john.residence?.numberOfRooms {
            print("John's residence has \(roomCount) room(s).")
        } else {
            print("Unable to retrieve the number of rooms.")
        }
        // 打印 “John's residence has 1 room(s).”
        
// MARK: 为可选链式调用定义模型类
        
        
        func test1() {
            //通过使用可选链式调用可以调用多层属性、方法和下标。这样可以在复杂的模型中向下访问各种子属性，并且判断能否访问子属性的属性、方法或下标。
            
            //下面这段代码定义了四个模型类，这些例子包括多层可选链式调用。为了方便说明，在Person和Residence的基础上增加了Room类和Address类，以及相关的属性、方法以及下标。
            
            //Person类的定义基本保持不变：
            
            class Person {
                var residence: Residence?
            }
            //Residence类比之前复杂些，增加了一个名为rooms的变量属性，该属性被初始化为[Room]类型的空数组：
           
            class Residence {
                //var rooms = [Room]()
                var rooms: [Room] = [Room]()
                var someInts = [Int]()
                var numberOfRooms: Int {
                    return rooms.count
                }
                subscript(i: Int) -> Room {
                    get {
                        return rooms[i]
                    }
                    set {
                        rooms[i] = newValue
                    }
                }
                func printNumberOfRooms() {
                    print("The number of rooms is \(numberOfRooms)")
                }
                var address: Address?
            }
            /*
             现在Residence有了一个存储Room实例的数组，numberOfRooms属性被实现为计算型属性，而不是存储型属性。numberOfRooms属性简单地返回rooms数组的count属性的值。
             
             Residence还提供了访问rooms数组的快捷方式，即提供可读写的下标来访问rooms数组中指定位置的元素。
             
             此外，Residence还提供了printNumberOfRooms方法，这个方法的作用是打印numberOfRooms的值。
             
             最后，Residence还定义了一个可选属性address，其类型为Address?。Address类的定义在下面会说明。
             
             Room类是一个简单类，其实例被存储在rooms数组中。该类只包含一个属性name，以及一个用于将该属性设置为适当的房间名的初始化函数：
             */
            class Room {
                let name: String
                init(name: String) { self.name = name }
            }
            //最后一个类是Address，这个类有三个String?类型的可选属性。buildingName以及buildingNumber属性分别表示某个大厦的名称和号码，第三个属性street表示大厦所在街道的名称：
            
            class Address {
                var buildingName: String?
                var buildingNumber: String?
                var street: String?
                func buildingIdentifier() -> String? {
                    if buildingName != nil {
                        return buildingName
                    } else if buildingNumber != nil && street != nil {
                        return "\(buildingNumber) \(street)"
                    } else {
                        return nil
                    }
                }
            }
            //Address类提供了buildingIdentifier()方法，返回值为String?。 如果buildingName有值则返回buildingName。或者，如果buildingNumber和street均有值则返回buildingNumber。否则，返回nil。
        }
        test1()
    
// MARK:通过可选链式调用访问属性
        
        
        func test2() {
            
            class Person {
                var residence: Residence?
            }

            class Residence {
                //var rooms = [Room]()
                var rooms: [Room] = [Room]()
                var someInts = [Int]()
                var numberOfRooms: Int {
                    return rooms.count
                }
                subscript(i: Int) -> Room {
                    get {
                        return rooms[i]
                    }
                    set {
                        rooms[i] = newValue
                    }
                }
                func printNumberOfRooms() {
                    print("The number of rooms is \(numberOfRooms)")
                }
                var address: Address?
            }
  
            class Room {
                let name: String
                init(name: String) { self.name = name }
            }
   
            class Address {
                var buildingName: String?
                var buildingNumber: String?
                var street: String?
                func buildingIdentifier() -> String? {
                    if buildingName != nil {
                        return buildingName
                    } else if buildingNumber != nil && street != nil {
                        return "\(buildingNumber) \(street)"
                    } else {
                        return nil
                    }
                }
            }
            //正如使用可选链式调用代替强制展开中所述，可以通过可选链式调用在一个可选值上访问它的属性，并判断访问是否成功。
            
            //下面的代码创建了一个Person实例，然后像之前一样，尝试访问numberOfRooms属性：
            
            let john = Person()
            if let roomCount = john.residence?.numberOfRooms {
                print("John's residence has \(roomCount) room(s).")
            } else {
                print("Unable to retrieve the number of rooms.")
            }
            // 打印 “Unable to retrieve the number of rooms.”
            //因为john.residence为nil，所以这个可选链式调用依旧会像先前一样失败。
            
            //还可以通过可选链式调用来设置属性值：
            
            let someAddress = Address()
            someAddress.buildingNumber = "29"
            someAddress.street = "Acacia Road"
            john.residence?.address = someAddress
            //在这个例子中，通过john.residence来设定address属性也会失败，因为john.residence当前为nil。
            
            //上面代码中的赋值过程是可选链式调用的一部分，这意味着可选链式调用失败时，等号右侧的代码不会被执行。对于上面的代码来说，很难验证这一点，因为像这样赋值一个常量没有任何副作用。下面的代码完成了同样的事情，但是它使用一个函数来创建Address实例，然后将该实例返回用于赋值。该函数会在返回前打印“Function was called”，这使你能验证等号右侧的代码是否被执行。
            
            func createAddress() -> Address {
                print("Function was called.")
                
                let someAddress = Address()
                someAddress.buildingNumber = "29"
                someAddress.street = "Acacia Road"
                
                return someAddress
            }
            john.residence?.address = createAddress()
            //没有任何打印消息，可以看出createAddress()函数并未被执行。
            
            
            
// MARK: 通过可选链式调用访问下标
            //通过可选链式调用，我们可以在一个可选值上访问下标，并且判断下标调用是否成功。
            
            //注意
            //通过可选链式调用访问可选值的下标时，应该将问号放在下标方括号的前面而不是后面。可选链式调用的问号一般直接跟在可选表达式的后面。
            //下面这个例子用下标访问john.residence属性存储的Residence实例的rooms数组中的第一个房间的名称，因为john.residence为nil，所以下标调用失败了：
            
            if let firstRoomName = john.residence?[0].name {
                print("The first room name is \(firstRoomName).")
            } else {
                print("Unable to retrieve the first room name.")
            }
            // 打印 “Unable to retrieve the first room name.”
            //在这个例子中，问号直接放在john.residence的后面，并且在方括号的前面，因为john.residence是可选值。
            
            //类似的，可以通过下标，用可选链式调用来赋值：
            
            john.residence?[0] = Room(name: "Bathroom")
            //这次赋值同样会失败，因为residence目前是nil。
            
            //如果你创建一个Residence实例，并为其rooms数组添加一些Room实例，然后将Residence实例赋值给john.residence，那就可以通过可选链和下标来访问数组中的元素：
            
            let johnsHouse = Residence()
            johnsHouse.rooms.append(Room(name: "Living Room"))
            johnsHouse.rooms.append(Room(name: "Kitchen"))
            john.residence = johnsHouse
            
            if let firstRoomName = john.residence?[0].name {
                print("The first room name is \(firstRoomName).")
            } else {
                print("Unable to retrieve the first room name.")
            }
            // 打印 “The first room name is Living Room.”
            
            
            
// MARK:访问可选类型的下标
            
            //如果下标返回可选类型值，比如 Swift 中Dictionary类型的键的下标，可以在下标的结尾括号后面放一个问号来在其可选返回值上进行可选链式调用：
            
            var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
            testScores["Dave"]?[0] = 91
            testScores["Bev"]?[0] += 1
            testScores["Brian"]?[0] = 72
            // "Dave" 数组现在是 [91, 82, 84]，"Bev" 数组现在是 [80, 94, 81]
            //上面的例子中定义了一个testScores数组，包含了两个键值对，把String类型的键映射到一个Int值的数组。这个例子用可选链式调用把"Dave"数组中第一个元素设为91，把"Bev"数组的第一个元素+1，然后尝试把"Brian"数组中的第一个元素设为72。前两个调用成功，因为testScores字典中包含"Dave"和"Bev"这两个键。但是testScores字典中没有"Brian"这个键，所以第三个调用失败。
            
            
// MARK: 连接多层可选链式调用
            /*
            可以通过连接多个可选链式调用在更深的模型层级中访问属性、方法以及下标。然而，多层可选链式调用不会增加返回值的可选层级。
            
            也就是说：
            
            如果你访问的值不是可选的，可选链式调用将会返回可选值。
            如果你访问的值就是可选的，可选链式调用不会让可选返回值变得“更可选”。
            因此：
            
            通过可选链式调用访问一个Int值，将会返回Int?，无论使用了多少层可选链式调用。
            类似的，通过可选链式调用访问Int?值，依旧会返回Int?值，并不会返回Int??。
            下面的例子尝试访问john中的residence属性中的address属性中的street属性。这里使用了两层可选链式调用，residence以及address都是可选值：
            */
            
            if let johnsStreet = john.residence?.address?.street {
                print("John's street name is \(johnsStreet).")
            } else {
                print("Unable to retrieve the address.")
            }
            // 打印 “Unable to retrieve the address.”
            //john.residence现在包含一个有效的Residence实例。然而，john.residence.address的值当前为nil。因此，调用john.residence?.address?.street会失败。
            
            //需要注意的是，上面的例子中，street的属性为String?。john.residence?.address?.street的返回值也依然是String?，即使已经使用了两层可选链式调用。
            
            //如果为john.residence.address赋值一个Address实例，并且为address中的street属性设置一个有效值，我们就能过通过可选链式调用来访问street属性：
            
            let johnsAddress = Address()
            johnsAddress.buildingName = "The Larches"
            johnsAddress.street = "Laurel Street"
            john.residence?.address = johnsAddress
            
            if let johnsStreet = john.residence?.address?.street {
                print("John's street name is \(johnsStreet).")
            } else {
                print("Unable to retrieve the address.")
            }
            // 打印 “John's street name is Laurel Street.”
            //在上面的例子中，因为john.residence包含一个有效的Residence实例，所以对john.residence的address属性赋值将会成功。
            
// MARK:在方法的可选返回值上进行可选链式调用
            //上面的例子展示了如何在一个可选值上通过可选链式调用来获取它的属性值。我们还可以在一个可选值上通过可选链式调用来调用方法，并且可以根据需要继续在方法的可选返回值上进行可选链式调用。
            
            //在下面的例子中，通过可选链式调用来调用Address的buildingIdentifier()方法。这个方法返回String?类型的值。如上所述，通过可选链式调用来调用该方法，最终的返回值依旧会是String?类型：
            
            if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
                print("John's building identifier is \(buildingIdentifier).")
            }
            // 打印 “John's building identifier is The Larches.”
            //如果要在该方法的返回值上进行可选链式调用，在方法的圆括号后面加上问号即可：
            
            if let beginsWithThe =
                john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
                if beginsWithThe {
                    print("John's building identifier begins with \"The\".")
                } else {
                    print("John's building identifier does not begin with \"The\".")
                }
            }
            // 打印 “John's building identifier begins with "The".”
            //注意 在上面的例子中，在方法的圆括号后面加上问号是因为你要在buildingIdentifier()方法的可选返回值上进行可选链式调用，而不是方法本身
            
            print()
        }
        
        test2()
        print()
    }
    
// MAKR: 错误处理
    
    func errorHandling() {
        /*
        本页包含内容：
        
        表示并抛出错误
        处理错误
        指定清理操作
        错误处理（Error handling）是响应错误以及从错误中恢复的过程。Swift 提供了在运行时对可恢复错误的抛出、捕获、传递和操作的一等公民支持。
        
        某些操作无法保证总是执行完所有代码或总是生成有用的结果。可选类型可用来表示值缺失，但是当某个操作失败时，最好能得知失败的原因，从而可以作出相应的应对。
        
        举个例子，假如有个从磁盘上的某个文件读取数据并进行处理的任务，该任务会有多种可能失败的情况，包括指定路径下文件并不存在，文件不具有可读权限，或者文件编码格式不兼容。区分这些不同的失败情况可以让程序解决并处理某些错误，然后把它解决不了的错误报告给用户。
        
        注意
        Swift 中的错误处理涉及到错误处理模式，这会用到 Cocoa 和 Objective-C 中的NSError。关于这个类的更多信息请参见 Using Swift with Cocoa and Objective-C (Swift 3.0.1) 中的错误处理。
        
        表示并抛出错误
        在 Swift 中，错误用符合Error协议的类型的值来表示。这个空协议表明该类型可以用于错误处理。
        
        Swift 的枚举类型尤为适合构建一组相关的错误状态，枚举的关联值还可以提供错误状态的额外信息。例如，你可以这样表示在一个游戏中操作自动贩卖机时可能会出现的错误状态：
        */
        enum VendingMachineError: Error {
            case invalidSelection                    //选择无效
            case insufficientFunds(coinsNeeded: Int) //金额不足
            case outOfStock                          //缺货
        }
        //抛出一个错误可以让你表明有意外情况发生，导致正常的执行流程无法继续执行。抛出错误使用throw关键字。例如，下面的代码抛出一个错误，提示贩卖机还需要5个硬币：
        
        //throw VendingMachineError. insufficientFunds(coinsNeeded: 5)
        /*
//处理错误
        某个错误被抛出时，附近的某部分代码必须负责处理这个错误，例如纠正这个问题、尝试另外一种方式、或是向用户报告错误。
        
        Swift 中有4种处理错误的方式。你可以把函数抛出的错误传递给调用此函数的代码、用do-catch语句处理错误、将错误作为可选类型处理、或者断言此错误根本不会发生。每种方式在下面的小节中都有描述。
        
        当一个函数抛出一个错误时，你的程序流程会发生改变，所以重要的是你能迅速识别代码中会抛出错误的地方。为了标识出这些地方，在调用一个能抛出错误的函数、方法或者构造器之前，加上try关键字，或者try?或try!这种变体。这些关键字在下面的小节中有具体讲解。
        
        注意
        Swift 中的错误处理和其他语言中用try，catch和throw进行异常处理很像。和其他语言中（包括 Objective-C ）的异常处理不同的是，Swift 中的错误处理并不涉及解除调用栈，这是一个计算代价高昂的过程。就此而言，throw语句的性能特性是可以和return语句相媲美的。
        
        用 throwing 函数传递错误
        
        为了表示一个函数、方法或构造器可以抛出错误，在函数声明的参数列表之后加上throws关键字。一个标有throws关键字的函数被称作throwing 函数。如果这个函数指明了返回值类型，throws关键词需要写在箭头（->）的前面。
        
        func canThrowErrors() throws -> String
        func cannotThrowErrors() -> String
        一个 throwing 函数可以在其内部抛出错误，并将错误传递到函数被调用时的作用域。
        
        注意
        只有 throwing 函数可以传递错误。任何在某个非 throwing 函数内部抛出的错误只能在函数内部处理。
        下面的例子中，VendingMachine类有一个vend(itemNamed:)方法，如果请求的物品不存在、缺货或者投入金额小于物品价格，该方法就会抛出一个相应的VendingMachineError：
        */
        struct Item {
            var price: Int
            var count: Int
        }
        
        class VendingMachine {
            var inventory = [
                "Candy Bar": Item(price: 12, count: 7),
                "Chips": Item(price: 10, count: 4),
                "Pretzels": Item(price: 7, count: 11)
            ]
            var coinsDeposited = 0
            func dispenseSnack(snack: String) {
                print("Dispensing \(snack)")
            }
            
            func vend(itemNamed name: String) throws {
                guard let item = inventory[name] else {
                    throw VendingMachineError.invalidSelection
                }
                
                guard item.count > 0 else {
                    throw VendingMachineError.outOfStock
                }
                
                guard item.price <= coinsDeposited else {
                    throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
                }
                
                coinsDeposited -= item.price
                
                var newItem = item
                newItem.count -= 1
                inventory[name] = newItem
                
                print("Dispensing \(name)")
            }
        }
        //在vend(itemNamed:)方法的实现中使用了guard语句来提前退出方法，确保在购买某个物品所需的条件中，有任一条件不满足时，能提前退出方法并抛出相应的错误。由于throw语句会立即退出方法，所以物品只有在所有条件都满足时才会被售出。
        
        //因为vend(itemNamed:)方法会传递出它抛出的任何错误，在你的代码中调用此方法的地方，必须要么直接处理这些错误——使用do-catch语句，try?或try!；要么继续将这些错误传递下去。例如下面例子中，buyFavoriteSnack(_:vendingMachine:)同样是一个 throwing 函数，任何由vend(itemNamed:)方法抛出的错误会一直被传递到buyFavoriteSnack(person:vendingMachine:)函数被调用的地方。
        
        let favoriteSnacks = [
            "Alice": "Chips",
            "Bob": "Licorice",
            "Eve": "Pretzels",
            ]
        func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
            let snackName = favoriteSnacks[person] ?? "Candy Bar"
            try vendingMachine.vend(itemNamed: snackName)
        }
        //上例中，buyFavoriteSnack(person:vendingMachine:)函数会查找某人最喜欢的零食，并通过调用vend(itemNamed:)方法来尝试为他们购买。因为vend(itemNamed:)方法能抛出错误，所以在调用的它时候在它前面加了try关键字。
        
        //throwing构造器能像throwing函数一样传递错误.例如下面代码中的PurchasedSnack构造器在构造过程中调用了throwing函数,并且通过传递到它的调用者来处理这些错误。
        
        struct PurchasedSnack {
            let name: String
            init(name: String, vendingMachine: VendingMachine) throws {
                try vendingMachine.vend(itemNamed: name)
                self.name = name
            }
        }

        /*
        用 Do-Catch 处理错误
        
        可以使用一个do-catch语句运行一段闭包代码来处理错误。如果在do子句中的代码抛出了一个错误，这个错误会与catch子句做匹配，从而决定哪条子句能处理它。
        
        下面是do-catch语句的一般形式：
 
        do {
            try expression
            statements
        } catch pattern 1 {
            statements
        } catch pattern 2 where condition {
            statements
        }
        在catch后面写一个匹配模式来表明这个子句能处理什么样的错误。如果一条catch子句没有指定匹配模式，那么这条子句可以匹配任何错误，并且把错误绑定到一个名字为error的局部常量。关于模式匹配的更多信息请参考 模式。
        
        catch子句不必将do子句中的代码所抛出的每一个可能的错误都作处理。如果所有catch子句都未处理错误，错误就会传递到周围的作用域。然而，错误还是必须要被某个周围的作用域处理的——要么是一个外围的do-catch错误处理语句，要么是一个 throwing 函数的内部。举例来说，下面的代码处理了VendingMachineError枚举类型的全部枚举值，但是所有其它的错误就必须由它周围的作用域处理：
        */
        var vendingMachine = VendingMachine()
        vendingMachine.coinsDeposited = 8
        do {
            //try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
            
        } catch VendingMachineError.invalidSelection {
            print("Invalid Selection.")
        } catch VendingMachineError.outOfStock {
            print("Out of Stock.")
        } catch VendingMachineError.insufficientFunds(let coinsNeeded) {
            print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
        }
        // 打印 “Insufficient funds. Please insert an additional 2 coins.”
        //上面的例子中，buyFavoriteSnack(person:vendingMachine:)函数在一个try表达式中调用，因为它能抛出错误。如果错误被抛出，相应的执行会马上转移到catch子句中，并判断这个错误是否要被继续传递下去。如果没有错误抛出，do子句中余下的语句就会被执行。
        
// 将错误转换成可选值
        
        //可以使用try?通过将错误转换成一个可选值来处理错误。如果在评估try?表达式时一个错误被抛出，那么表达式的值就是nil。例如,在下面的代码中,x和y有着相同的数值和等价的含义：
        /*
        func someThrowingFunction() throws -> Int {
            // ...
        }
        
        let x = try? someThrowingFunction()
        
        let y: Int?
        do {
            y = try someThrowingFunction()
        } catch {
            y = nil
        }
        */
        //如果someThrowingFunction()抛出一个错误，x和y的值是nil。否则x和y的值就是该函数的返回值。注意，无论someThrowingFunction()的返回值类型是什么类型，x和y都是这个类型的可选类型。例子中此函数返回一个整型，所以x和y是可选整型。
        
        //如果你想对所有的错误都采用同样的方式来处理，用try?就可以让你写出简洁的错误处理代码。例如，下面的代码用几种方式来获取数据，如果所有方式都失败了则返回nil：
        /*
        func fetchData() -> Data? {
            if let data = try? fetchDataFromDisk() { return data }
            if let data = try? fetchDataFromServer() { return data }
            return nil
        }
        */
// 禁用错误传递
        
        //有时你知道某个throwing函数实际上在运行时是不会抛出错误的，在这种情况下，你可以在表达式前面写try!来禁用错误传递，这会把调用包装在一个不会有错误抛出的运行时断言中。如果真的抛出了错误，你会得到一个运行时错误。
        
        //例如，下面的代码使用了loadImage(atPath:)函数，该函数从给定的路径加载图片资源，如果图片无法载入则抛出一个错误。在这种情况下，因为图片是和应用绑定的，运行时不会有错误抛出，所以适合禁用错误传递：
        
        //let photo = try!loadImage(atPath:"./Resources/John Appleseed.jpg")
        
// 指定清理操作
        //可以使用defer语句在即将离开当前代码块时执行一系列语句。该语句让你能执行一些必要的清理工作，不管是以何种方式离开当前代码块的——无论是由于抛出错误而离开，还是由于诸如return或者break的语句。例如，你可以用defer语句来确保文件描述符得以关闭，以及手动分配的内存得以释放。
        
        //defer语句将代码的执行延迟到当前的作用域退出之前。该语句由defer关键字和要被延迟执行的语句组成。延迟执行的语句不能包含任何控制转移语句，例如break或是return语句，或是抛出一个错误。延迟执行的操作会按照它们被指定时的顺序的相反顺序执行——也就是说，第一条defer语句中的代码会在第二条defer语句中的代码被执行之后才执行，以此类推。
        /*
        func processFile(filename: String) throws {
            if exists(filename) {
                let file = open(filename)
                defer {
                    close(file)
                }
                while let line = try file.readline() {
                    // 处理文件。
                }
                // close(file) 会在这里被调用，即作用域的最后。
            }
        }
        */
        //上面的代码使用一条defer语句来确保open(_:)函数有一个相应的对close(_:)函数的调用。
        print()
    }
    
    
// MARK:类型转换
    
    func typeConversion() {
        /*
        本页包含内容：
        
        定义一个类层次作为例子
        检查类型
        向下转型
        Any 和 AnyObject 的类型转换
        类型转换 可以判断实例的类型，也可以将实例看做是其父类或者子类的实例。
        
        类型转换在 Swift 中使用 is 和 as 操作符实现。这两个操作符提供了一种简单达意的方式去检查值的类型或者转换它的类型。
        
        你也可以用它来检查一个类型是否实现了某个协议，就像在检验协议的一致性部分讲述的一样。
        
        
        定义一个类层次作为例子
        你可以将类型转换用在类和子类的层次结构上，检查特定类实例的类型并且转换这个类实例的类型成为这个层次结构中的其他类型。下面的三个代码段定义了一个类层次和一个包含了这些类实例的数组，作为类型转换的例子。
        
        第一个代码片段定义了一个新的基类 MediaItem。这个类为任何出现在数字媒体库的媒体项提供基础功能。特别的，它声明了一个 String 类型的 name 属性，和一个 init(name:) 初始化器。（假定所有的媒体项都有个名称。）
        */
        class MediaItem {
            var name: String
            init(name: String) {
                self.name = name
            }
        }
        //下一个代码段定义了 MediaItem 的两个子类。第一个子类 Movie 封装了与电影相关的额外信息，在父类（或者说基类）的基础上增加了一个 director（导演）属性，和相应的初始化器。第二个子类 Song，在父类的基础上增加了一个 artist（艺术家）属性，和相应的初始化器：
        
        class Movie: MediaItem {
            var director: String
            init(name: String, director: String) {
                self.director = director
                super.init(name: name)
            }
        }
        
        class Song: MediaItem {
            var artist: String
            init(name: String, artist: String) {
                self.artist = artist
                super.init(name: name)
            }
        }
        //最后一个代码段创建了一个数组常量 library，包含两个 Movie 实例和三个 Song 实例。library 的类型是在它被初始化时根据它数组中所包含的内容推断来的。Swift 的类型检测器能够推断出 Movie 和 Song 有共同的父类 MediaItem，所以它推断出 [MediaItem] 类作为 library 的类型：
        
        let library = [
            Movie(name: "Casablanca", director: "Michael Curtiz"),
            Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
            Movie(name: "Citizen Kane", director: "Orson Welles"),
            Song(name: "The One And Only", artist: "Chesney Hawkes"),
            Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
        ]
        // 数组 library 的类型被推断为 [MediaItem]
        //在幕后 library 里存储的媒体项依然是 Movie 和 Song 类型的。但是，若你迭代它，依次取出的实例会是 MediaItem 类型的，而不是 Movie 和 Song 类型。为了让它们作为原本的类型工作，你需要检查它们的类型或者向下转换它们到其它类型，就像下面描述的一样。
        
        
// MARK:检查类型
        /*用类型检查操作符（is）来检查一个实例是否属于特定子类型。若实例属于那个子类型，类型检查操作符返回 true，否则返回 false。
        
        下面的例子定义了两个变量，movieCount 和 songCount，用来计算数组 library 中 Movie 和 Song 类型的实例数量：
        */
        var movieCount = 0
        var songCount = 0
        
        for item in library {
            if item is Movie {
                movieCount += 1
            } else if item is Song {
                songCount += 1
            }
        }
        
        print("Media library contains \(movieCount) movies and \(songCount) songs")
        // 打印 “Media library contains 2 movies and 3 songs”
        //示例迭代了数组 library 中的所有项。每一次，for-in 循环设置 item 为数组中的下一个 MediaItem。
        
        //若当前 MediaItem 是一个 Movie 类型的实例，item is Movie 返回 true，否则返回 false。同样的，item is Song 检查 item 是否为 Song 类型的实例。在循环结束后，movieCount 和 songCount 的值就是被找到的属于各自类型的实例的数量。
        
        
// MARK:向下转型
        /*
        某类型的一个常量或变量可能在幕后实际上属于一个子类。当确定是这种情况时，你可以尝试向下转到它的子类型，用类型转换操作符（as? 或 as!）。
        
        因为向下转型可能会失败，类型转型操作符带有两种不同形式。条件形式as? 返回一个你试图向下转成的类型的可选值。强制形式 as! 把试图向下转型和强制解包（转换结果结合为一个操作。
        
        当你不确定向下转型可以成功时，用类型转换的条件形式（as?）。条件形式的类型转换总是返回一个可选值，并且若下转是不可能的，可选值将是 nil。这使你能够检查向下转型是否成功。
        
        只有你可以确定向下转型一定会成功时，才使用强制形式（as!）。当你试图向下转型为一个不正确的类型时，强制形式的类型转换会触发一个运行时错误。
        
        下面的例子，迭代了 library 里的每一个 MediaItem，并打印出适当的描述。要这样做，item 需要真正作为 Movie 或 Song 的类型来使用，而不仅仅是作为 MediaItem。为了能够在描述中使用 Movie 或 Song 的 director 或 artist 属性，这是必要的。
        
        在这个示例中，数组中的每一个 item 可能是 Movie 或 Song。事前你不知道每个 item 的真实类型，所以这里使用条件形式的类型转换（as?）去检查循环里的每次下转：
        */
        for item in library {
            if let movie = item as? Movie {
                print("Movie: '\(movie.name)', dir. \(movie.director)")
            } else if let song = item as? Song {
                print("Song: '\(song.name)', by \(song.artist)")
            }
        }
        
        // Movie: 'Casablanca', dir. Michael Curtiz
        // Song: 'Blue Suede Shoes', by Elvis Presley
        // Movie: 'Citizen Kane', dir. Orson Welles
        // Song: 'The One And Only', by Chesney Hawkes
        // Song: 'Never Gonna Give You Up', by Rick Astley
        
        /*
        示例首先试图将 item 下转为 Movie。因为 item 是一个 MediaItem 类型的实例，它可能是一个 Movie；同样，它也可能是一个 Song，或者仅仅是基类 MediaItem。因为不确定，as? 形式在试图下转时将返回一个可选值。item as? Movie 的返回值是 Movie? 或者说“可选 Movie”。
        
        当向下转型为 Movie 应用在两个 Song 实例时将会失败。为了处理这种情况，上面的例子使用了可选绑定（optional binding）来检查可选 Movie 真的包含一个值（这个是为了判断下转是否成功。）可选绑定是这样写的“if let movie = item as? Movie”，可以这样解读：
        
        “尝试将 item 转为 Movie 类型。若成功，设置一个新的临时常量 movie 来存储返回的可选 Movie 中的值”
        
        若向下转型成功，然后 movie 的属性将用于打印一个 Movie 实例的描述，包括它的导演的名字 director。相似的原理被用来检测 Song 实例，当 Song 被找到时则打印它的描述（包含 artist 的名字）。
        
        注意
        转换没有真的改变实例或它的值。根本的实例保持不变；只是简单地把它作为它被转换成的类型来使用。
        
        Any 和 AnyObject 的类型转换
        Swift 为不确定类型提供了两种特殊的类型别名：
        
        Any 可以表示任何类型，包括函数类型。
        AnyObject 可以表示任何类类型的实例。
        只有当你确实需要它们的行为和功能时才使用 Any 和 AnyObject。在你的代码里使用你期望的明确类型总是更好的。
        
        这里有个示例，使用 Any 类型来和混合的不同类型一起工作，包括函数类型和非类类型。它创建了一个可以存储 Any 类型的数组 things：
        */
        var things = [Any]()
        
        things.append(0)
        things.append(0.0)
        things.append(42)
        things.append(3.14159)
        things.append("hello")
        things.append((3.0, 5.0))
        things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
        things.append({ (name: String) -> String in "Hello, \(name)" })
        //things 数组包含两个 Int 值，两个 Double 值，一个 String 值，一个元组 (Double, Double)，一个Movie实例“Ghostbusters”，以及一个接受 String 值并返回另一个 String 值的闭包表达式。
        
        //你可以在 switch 表达式的 case 中使用 is 和 as 操作符来找出只知道是 Any 或 AnyObject 类型的常量或变量的具体类型。下面的示例迭代 things 数组中的每一项，并用 switch 语句查找每一项的类型。有几个 switch 语句的 case 绑定它们匹配到的值到一个指定类型的常量，从而可以打印这些值：
        
        for thing in things {
            switch thing {
            case 0 as Int:
                print("zero as an Int")
            case 0 as Double:
                print("zero as a Double")
            case let someInt as Int:
                print("an integer value of \(someInt)")
            case let someDouble as Double where someDouble > 0:
                print("a positive double value of \(someDouble)")
            case is Double:
                print("some other double value that I don't want to print")
            case let someString as String:
                print("a string value of \"\(someString)\"")
            case let (x, y) as (Double, Double):
                print("an (x, y) point at \(x), \(y)")
            case let movie as Movie:
                print("a movie called '\(movie.name)', dir. \(movie.director)")
            case let stringConverter as (String) -> String:
                print(stringConverter("Michael"))
            default:
                print("something else")
            }
        }
        
        // zero as an Int
        // zero as a Double
        // an integer value of 42
        // a positive double value of 3.14159
        // a string value of "hello"
        // an (x, y) point at 3.0, 5.0
        // a movie called 'Ghostbusters', dir. Ivan Reitman
        // Hello, Michael
        // 注意 Any类型可以表示所有类型的值，包括可选类型。Swift 会在你用Any类型来表示一个可选值的时候，给你一个警告。如果你确实想使用Any类型来承载可选值，你可以使用as操作符显式转换为Any，如下所示：
        
        let optionalNumber: Int? = 3
        things.append(optionalNumber)        // 警告
        things.append(optionalNumber as Any) // 没有警告
    }
    
// MARK: 嵌套类型
    func nestedtype() {
        /*
        本页包含内容：
        
        嵌套类型实践
        引用嵌套类型
        枚举常被用于为特定类或结构体实现某些功能。类似的，枚举可以方便的定义工具类或结构体，从而为某个复杂的类型所使用。为了实现这种功能，Swift 允许你定义嵌套类型，可以在支持的类型中定义嵌套的枚举、类和结构体。
        
        要在一个类型中嵌套另一个类型，将嵌套类型的定义写在其外部类型的{}内，而且可以根据需要定义多级嵌套。
        
        
        嵌套类型实践
        下面这个例子定义了一个结构体BlackjackCard（二十一点），用来模拟BlackjackCard中的扑克牌点数。BlackjackCard结构体包含两个嵌套定义的枚举类型Suit和Rank。
        
        在BlackjackCard中，Ace牌可以表示1或者11，Ace牌的这一特征通过一个嵌套在Rank枚举中的结构体Values来表示：
        */
        struct BlackjackCard {
            // 嵌套的 Suit 枚举
            enum Suit: Character {
                case Spades = "♠", Hearts = "♡", Diamonds = "♢", Clubs = "♣"
            }
            
            // 嵌套的 Rank 枚举
            enum Rank: Int {
                case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
                case Jack, Queen, King, Ace
                struct Values {
                    let first: Int, second: Int?
                }
                var values: Values {
                    switch self {
                    case .Ace:
                        return Values(first: 1, second: 11)
                    case .Jack, .Queen, .King:
                        return Values(first: 10, second: nil)
                    default:
                        return Values(first: self.rawValue, second: nil)
                    }
                }
            }
            
            // BlackjackCard 的属性和方法
            let rank: Rank, suit: Suit
            var description: String {
                var output = "suit is \(suit.rawValue),"
                output += " value is \(rank.values.first)"
                if let second = rank.values.second {
                    output += " or \(second)"
                }
                return output
            }
        }
        /*
        Suit枚举用来描述扑克牌的四种花色，并用一个Character类型的原始值表示花色符号。
        
        Rank枚举用来描述扑克牌从Ace~10，以及J、Q、K，这13种牌，并用一个Int类型的原始值表示牌的面值。（这个Int类型的原始值未用于Ace、J、Q、K这4种牌。）
        
        如上所述，Rank枚举在内部定义了一个嵌套结构体Values。结构体Values中定义了两个属性，用于反映只有Ace有两个数值，其余牌都只有一个数值：
        
        first的类型为Int
        second的类型为Int?，或者说“可选 Int”
        Rank还定义了一个计算型属性values，它将会返回一个Values结构体的实例。这个计算型属性会根据牌的面值，用适当的数值去初始化Values实例。对于J、Q、K、Ace这四种牌，会使用特殊数值。对于数字面值的牌，使用枚举实例的原始值。
        
        BlackjackCard结构体拥有两个属性——rank与suit。它也同样定义了一个计算型属性description，description属性用rank和suit中的内容来构建对扑克牌名字和数值的描述。该属性使用可选绑定来检查可选类型second是否有值，若有值，则在原有的描述中增加对second的描述。
        
        因为BlackjackCard是一个没有自定义构造器的结构体，在结构体的逐一成员构造器中可知，结构体有默认的成员构造器，所以你可以用默认的构造器去初始化新常量theAceOfSpades：
        */
        
        let theAceOfSpades = BlackjackCard(rank: .Ace, suit: .Spades)
        print("theAceOfSpades: \(theAceOfSpades.description)")
        // 打印 “theAceOfSpades: suit is ♠, value is 1 or 11”
        //尽管Rank和Suit嵌套在BlackjackCard中，但它们的类型仍可从上下文中推断出来，所以在初始化实例时能够单独通过成员名称（.Ace和.Spades）引用枚举实例。在上面的例子中，description属性正确地反映了黑桃A牌具有1和11两个值。
        
        
        //引用嵌套类型
        //在外部引用嵌套类型时，在嵌套类型的类型名前加上其外部类型的类型名作为前缀：
        
        let heartsSymbol = BlackjackCard.Suit.Hearts.rawValue
        // 红心符号为 “♡”
        //对于上面这个例子，这样可以使Suit、Rank和Values的名字尽可能的短，因为它们的名字可以由定义它们的上下文来限定。
    }
    
    
    
    
// MARK: 扩展
    // 下面注释的扩展方法都放头部去了
    func extensions() {
        /*
         本页包含内容：
         
         扩展语法
         计算型属性
         构造器
         方法
         下标
         嵌套类型
         扩展 就是为一个已有的类、结构体、枚举类型或者协议类型添加新功能。这包括在没有权限获取原始源代码的情况下扩展类型的能力（即 逆向建模 ）。扩展和 Objective-C 中的分类类似。（与 Objective-C 不同的是，Swift 的扩展没有名字。）
         
         Swift 中的扩展可以：
         
         添加计算型属性和计算型类型属性
         定义实例方法和类型方法
         提供新的构造器
         定义下标
         定义和使用新的嵌套类型
         使一个已有类型符合某个协议
         在 Swift 中，你甚至可以对协议进行扩展，提供协议要求的实现，或者添加额外的功能，从而可以让符合协议的类型拥有这些功能。你可以从协议扩展获取更多的细节。
         
         注意
         扩展可以为一个类型添加新的功能，但是不能重写已有的功能。
         
         扩展语法
         使用关键字 extension 来声明扩展：
         
         extension SomeType {
         // 为 SomeType 添加的新功能写到这里
         }
         //可以通过扩展来扩展一个已有类型，使其采纳一个或多个协议。在这种情况下，无论是类还是结构体，协议名字的书写方式完全一样：
         
         extension SomeType: SomeProtocol, AnotherProctocol {
         // 协议实现写到这里
         }
         
         通过这种方式添加协议一致性的详细描述请参阅利用扩展添加协议一致性。
         
         注意
         如果你通过扩展为一个已有类型添加新功能，那么新功能对该类型的所有已有实例都是可用的，即使它们是在这个扩展定义之前创建的。
         */
        // MARK:计算型属性
        //扩展可以为已有类型添加计算型实例属性和计算型类型属性。下面的例子为 Swift 的内建 Double 类型添加了五个计算型实例属性，从而提供与距离单位协作的基本支持：
        /*
        extension Double {
            var km: Double { return self * 1_000.0 }
            var m : Double { return self }
            var cm: Double { return self / 100.0 }
            var mm: Double { return self / 1_000.0 }
            var ft: Double { return self / 3.28084 }
        }
        */
        let oneInch = 25.4.mm
        print("One inch is \(oneInch) meters")
        // 打印 “One inch is 0.0254 meters”
        let threeFeet = 3.ft
        print("Three feet is \(threeFeet) meters")
        // 打印 “Three feet is 0.914399970739201 meters”
        
        /*
         这些计算型属性表达的含义是把一个 Double 值看作是某单位下的长度值。即使它们被实现为计算型属性，但这些属性的名字仍可紧接一个浮点型字面值，从而通过点语法来使用，并以此实现距离转换。
         
         在上述例子中，Double 值 1.0 用来表示“1米”。这就是为什么计算型属性 m 返回 self，即表达式 1.m 被认为是计算 Double 值 1.0。
         
         其它单位则需要一些单位换算。一千米等于 1,000 米，所以计算型属性 km 要把值乘以 1_000.00 来实现千米到米的单位换算。类似地，一米有 3.28024 英尺，所以计算型属性 ft 要把对应的 Double 值除以 3.28024 来实现英尺到米的单位换算。
         
         这些属性是只读的计算型属性，为了更简洁，省略了 get 关键字。它们的返回值是 Double，而且可以用于所有接受 Double 值的数学计算中：
         */
        
        let aMarathon = 42.km + 195.m
        print("A marathon is \(aMarathon) meters long")
        // 打印 “A marathon is 42195.0 meters long”
        //注意 扩展可以添加新的计算型属性，但是不可以添加存储型属性，也不可以为已有属性添加属性观察器。
        
        // MARK: 构造器
        //扩展可以为已有类型添加新的构造器。这可以让你扩展其它类型，将你自己的定制类型作为其构造器参数，或者提供该类型的原始实现中未提供的额外初始化选项。
        
        //扩展能为类添加新的便利构造器，但是它们不能为类添加新的指定构造器或析构器。指定构造器和析构器必须总是由原始的类实现来提供。
        
        /*
         注意
         如果你使用扩展为一个值类型添加构造器，同时该值类型的原始实现中未定义任何定制的构造器且所有存储属性提供了默认值，那么我们就可以在扩展中的构造器里调用默认构造器和逐一成员构造器。
         正如在值类型的构造器代理中描述的，如果你把定制的构造器写在值类型的原始实现中，上述规则将不再适用。
         下面的例子定义了一个用于描述几何矩形的结构体 Rect。这个例子同时定义了两个辅助结构体 Size 和 Point，它们都把 0.0 作为所有属性的默认值：
         */
        struct Size {
            var width = 0.0, height = 0.0
        }
        struct Point {
            var x = 0.0, y = 0.0
        }
        struct Rect {
            var origin = Point()
            var size = Size()
        }
        //因为结构体 Rect 未提供定制的构造器，因此它会获得一个逐一成员构造器。又因为它为所有存储型属性提供了默认值，它又会获得一个默认构造器。详情请参阅默认构造器。这些构造器可以用于构造新的 Rect 实例：
        
        let defaultRect = Rect()
        let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
                                  size: Size(width: 5.0, height: 5.0))
        //你可以提供一个额外的接受指定中心点和大小的构造器来扩展 Rect 结构体：
        
//        extension Rect {
//            init(center: Point, size: Size) {
//                let originX = center.x - (size.width / 2)
//                let originY = center.y - (size.height / 2)
//        	        self.init(origin: Point(x: originX, y: originY), size: size)
//            }
//        }
        //这个新的构造器首先根据提供的 center 和 size 的值计算一个合适的原点。然后调用该结构体的逐一成员构造器 init(origin:size:)，该构造器将新的原点和大小的值保存到了相应的属性中：
        
        let centerRect = Rect(origin: Point(x: 4.0, y: 4.0),
                              size: Size(width: 3.0, height: 3.0))
        // centerRect 的原点是 (2.5, 2.5)，大小是 (3.0, 3.0)
        //注意 如果你使用扩展提供了一个新的构造器，你依旧有责任确保构造过程能够让实例完全初始化。
        
        // MARK: 方法
        //扩展可以为已有类型添加新的实例方法和类型方法。下面的例子为 Int 类型添加了一个名为 repetitions 的实例方法：
        
//        extension Int {
//            func repetitions(task: () -> Void) {
//                for _ in 0..<self {
//                    task()
//                }
//            }
//        }
        /*
         这个 repetitions(task:) 方法接受一个 () -> Void 类型的单参数，表示没有参数且没有返回值的函数。
         
         定义该扩展之后，你就可以对任意整数调用 repetitions(task:) 方法，将闭包中的任务执行整数对应的次数：
         
         3.repetitions({
         print("Hello!")
         })
         // Hello!
         // Hello!
         // Hello!
         可以使用尾随闭包让调用更加简洁：
         
         3.repetitions {
         print("Goodbye!")
         }
         // Goodbye!
         // Goodbye!
         // Goodbye!
         */
        // MARK: 可变实例方法
        
        //通过扩展添加的实例方法也可以修改该实例本身。结构体和枚举类型中修改 self 或其属性的方法必须将该实例方法标注为 mutating，正如来自原始实现的可变方法一样。
        
        //下面的例子为 Swift 的 Int 类型添加了一个名为 square 的可变方法，用于计算原始值的平方值：
        
//        extension Int {
//            mutating func square() {
//                self = self * self
//            }
//        }
        var someInt = 3
        someInt.square()
        // someInt 的值现在是 9
        
        // MAKR:下标
        /*
         扩展可以为已有类型添加新下标。这个例子为 Swift 内建类型 Int 添加了一个整型下标。该下标 [n] 返回十进制数字从右向左数的第 n 个数字：
         
         123456789[0] 返回 9
         123456789[1] 返回 8
         ……以此类推。
         */
//        extension Int {
//            subscript(digitIndex: Int) -> Int {
//                var decimalBase = 1
//                for _ in 0..<digitIndex {
//                    decimalBase *= 10
//                }
//                return (self / decimalBase) % 10
//            }
//        }
        746381295[0]
        // 返回 5
        746381295[1]
        // 返回 9
        746381295[2]
        // 返回 2
        746381295[8]
        // 返回 7
        //如果该 Int 值没有足够的位数，即下标越界，那么上述下标实现会返回 0，犹如在数字左边自动补 0：
        
        746381295[9]
        // 返回 0，即等同于：
        0746381295[9]
        
        // MARK:嵌套类型
        //扩展可以为已有的类、结构体和枚举添加新的嵌套类型：
        /*
         extension Int {
         enum Kind {
         case Negative, Zero, Positive
         }
         var kind: Kind {
         switch self {
         case 0:
         return .Zero
         case let x where x > 0:
         return .Positive
         default:
         return .Negative
         }
         }
         }
         */
        /*
         该例子为 Int 添加了嵌套枚举。这个名为 Kind 的枚举表示特定整数的类型。具体来说，就是表示整数是正数、零或者负数。
         
         这个例子还为 Int 添加了一个计算型实例属性，即 kind，用来根据整数返回适当的 Kind 枚举成员。
         
         现在，这个嵌套枚举可以和任意 Int 值一起使用了：
         */
        func printIntegerKinds(_ numbers: [Int]) {
            for number in numbers {
                switch number.kind {
                case .Negative:
                    print("- ", terminator: "")
                case .Zero:
                    print("0 ", terminator: "")
                case .Positive:
                    print("+ ", terminator: "")
                }
            }
            print("")
        }
        printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
        // 打印 “+ + - 0 - 0 + ”
        /*
         函数 printIntegerKinds(_:) 接受一个 Int 数组，然后对该数组进行迭代。在每次迭代过程中，对当前整数的计算型属性 kind 的值进行评估，并打印出适当的描述。
         
         注意
         由于已知 number.kind 是 Int.Kind 类型，因此在 switch 语句中，Int.Kind 中的所有成员值都可以使用简写形式，例如使用 . Negative 而不是 Int.Kind.Negative。
         */

    }
    
// MARK: 协议
    func protocolTest() {
        /*
        本页包含内容：
        
        协议语法
        属性要求
        方法要求（Method Requirements）
        Mutating 方法要求
        构造器要求
        协议作为类型
        委托（代理）模式
        通过扩展添加协议一致性
        通过扩展遵循协议
        协议类型的集合
        协议的继承
        类类型专属协议
        协议合成
        检查协议一致性
        可选的协议要求
        协议扩展
        协议 定义了一个蓝图，规定了用来实现某一特定任务或者功能的方法、属性，以及其他需要的东西。类、结构体或枚举都可以遵循协议，并为协议定义的这些要求提供具体实现。某个类型能够满足某个协议的要求，就可以说该类型遵循这个协议。
        
        除了遵循协议的类型必须实现的要求外，还可以对协议进行扩展，通过扩展来实现一部分要求或者实现一些附加功能，这样遵循协议的类型就能够使用这些功能。
        
        
        协议语法
        协议的定义方式与类、结构体和枚举的定义非常相似：
        
        protocol SomeProtocol {
            // 这里是协议的定义部分
        }
        要让自定义类型遵循某个协议，在定义类型时，需要在类型名称后加上协议名称，中间以冒号（:）分隔。遵循多个协议时，各协议之间用逗号（,）分隔：
        
        struct SomeStructure: FirstProtocol, AnotherProtocol {
            // 这里是结构体的定义部分
        }
        拥有父类的类在遵循协议时，应该将父类名放在协议名之前，以逗号分隔：
        
        class SomeClass: SomeSuperClass, FirstProtocol, AnotherProtocol {
            // 这里是类的定义部分
        }
        
        属性要求
        协议可以要求遵循协议的类型提供特定名称和类型的实例属性或类型属性。协议不指定属性是存储型属性还是计算型属性，它只指定属性的名称和类型。此外，协议还指定属性是可读的还是可读可写的。
        
        如果协议要求属性是可读可写的，那么该属性不能是常量属性或只读的计算型属性。如果协议只要求属性是可读的，那么该属性不仅可以是可读的，如果代码需要的话，还可以是可写的。
        
        协议总是用 var 关键字来声明变量属性，在类型声明后加上 { set get } 来表示属性是可读可写的，可读属性则用 { get } 来表示：
        */
//        protocol SomeProtocol {
//            var mustBeSettable: Int { get set }
//            var doesNotNeedToBeSettable: Int { get }
//        }
        //在协议中定义类型属性时，总是使用 static 关键字作为前缀。当类类型遵循协议时，除了 static 关键字，还可以使用 class 关键字来声明类型属性：
        
//        protocol AnotherProtocol {
//            static var someTypeProperty: Int { get set }
//        }
        //如下所示，这是一个只含有一个实例属性要求的协议：
        
//        protocol FullyNamed {
//            var fullName: String { get }
//        }
        //FullyNamed 协议除了要求遵循协议的类型提供 fullName 属性外，并没有其他特别的要求。这个协议表示，任何遵循 FullyNamed 的类型，都必须有一个可读的 String 类型的实例属性 fullName。
        
        //下面是一个遵循 FullyNamed 协议的简单结构体：
        
//        struct Person: FullyNamed {
//            var fullName: String
//        }
//        let john = Person(fullName: "John Appleseed")
        // john.fullName 为 "John Appleseed"
        /*
        这个例子中定义了一个叫做 Person 的结构体，用来表示一个具有名字的人。从第一行代码可以看出，它遵循了 FullyNamed 协议。
        
        Person 结构体的每一个实例都有一个 String 类型的存储型属性 fullName。这正好满足了 FullyNamed 协议的要求，也就意味着 Person 结构体正确地符合了协议。（如果协议要求未被完全满足，在编译时会报错。）
        
        下面是一个更为复杂的类，它适配并遵循了 FullyNamed 协议：
        */
        class Starship: FullyNamed {
            var prefix: String?
            var name: String
            init(name: String, prefix: String? = nil) {
                self.name = name
                self.prefix = prefix
            }
            var fullName: String {
                return (prefix != nil ? prefix! + " " : "") + name
            }
        }
        var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
        // ncc1701.fullName 是 "USS Enterprise"
        /*
        Starship 类把 fullName 属性实现为只读的计算型属性。每一个 Starship 类的实例都有一个名为 name 的非可选属性和一个名为 prefix 的可选属性。 当 prefix 存在时，计算型属性 fullName 会将 prefix 插入到 name 之前，从而为星际飞船构建一个全名。
    
        方法要求
        协议可以要求遵循协议的类型实现某些指定的实例方法或类方法。这些方法作为协议的一部分，像普通方法一样放在协议的定义中，但是不需要大括号和方法体。可以在协议中定义具有可变参数的方法，和普通方法的定义方式相同。但是，不支持为协议中的方法的参数提供默认值。
        
        正如属性要求中所述，在协议中定义类方法的时候，总是使用 static 关键字作为前缀。当类类型遵循协议时，除了 static 关键字，还可以使用 class 关键字作为前缀：
        */
//        protocol SomeProtocol {
//            static func someTypeMethod()
//        }
        //下面的例子定义了一个只含有一个实例方法的协议：
        
//        protocol RandomNumberGenerator {
//            func random() -> Double
//        }
        /*
        RandomNumberGenerator 协议要求遵循协议的类型必须拥有一个名为 random， 返回值类型为 Double 的实例方法。尽管这里并未指明，但是我们假设返回值在 [0.0,1.0) 区间内。
            
            RandomNumberGenerator 协议并不关心每一个随机数是怎样生成的，它只要求必须提供一个随机数生成器。
            
            如下所示，下边是一个遵循并符合 RandomNumberGenerator 协议的类。该类实现了一个叫做 线性同余生成器（linear congruential generator） 的伪随机数算法。
        */
//        class LinearCongruentialGenerator: RandomNumberGenerator {
//            var lastRandom = 42.0
//            let m = 139968.0
//            let a = 3877.0
//            let c = 29573.0
//            func random() -> Double {
//                lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
//                return lastRandom / m
//            }
//        }
        let generator = LinearCongruentialGenerator()
        print("Here's a random number: \(generator.random())")
        // 打印 “Here's a random number: 0.37464991998171”
        print("And another one: \(generator.random())")
        // 打印 “And another one: 0.729023776863283”
        /*
        Mutating 方法要求
        有时需要在方法中改变方法所属的实例。例如，在值类型（即结构体和枚举）的实例方法中，将 mutating 关键字作为方法的前缀，写在 func 关键字之前，表示可以在该方法中修改它所属的实例以及实例的任意属性的值。这一过程在在实例方法中修改值类型章节中有详细描述。
        
        如果你在协议中定义了一个实例方法，该方法会改变遵循该协议的类型的实例，那么在定义协议时需要在方法前加 mutating 关键字。这使得结构体和枚举能够遵循此协议并满足此方法要求。
        
        注意
        实现协议中的 mutating 方法时，若是类类型，则不用写 mutating 关键字。而对于结构体和枚举，则必须写 mutating 关键字。
        如下所示，Togglable 协议只要求实现一个名为 toggle 的实例方法。根据名称的暗示，toggle() 方法将改变实例属性，从而切换遵循该协议类型的实例的状态。
        
        toggle() 方法在定义的时候，使用 mutating 关键字标记，这表明当它被调用时，该方法将会改变遵循协议的类型的实例：
        */
//        protocol Togglable {
//            mutating func toggle()
//        }
        //当使用枚举或结构体来实现 Togglable 协议时，需要提供一个带有 mutating 前缀的 toggle() 方法。
        
        //下面定义了一个名为 OnOffSwitch 的枚举。这个枚举在两种状态之间进行切换，用枚举成员 On 和 Off 表示。枚举的 toggle() 方法被标记为 mutating，以满足 Togglable 协议的要求：
        
        enum OnOffSwitch: Togglable {
            case off, on
            mutating func toggle() {
                switch self {
                case .off:
                    self = .on
                case .on:
                    self = .off
                }
            }
        }
        var lightSwitch = OnOffSwitch.off
        lightSwitch.toggle()
        // lightSwitch 现在的值为 .On
        
// MARK:构造器要求
        //协议可以要求遵循协议的类型实现指定的构造器。你可以像编写普通构造器那样，在协议的定义里写下构造器的声明，但不需要写花括号和构造器的实体：
        
//        protocol SomeProtocol {
//            init(someParameter: Int)
//        }
        //构造器要求在类中的实现
        
        //你可以在遵循协议的类中实现构造器，无论是作为指定构造器，还是作为便利构造器。无论哪种情况，你都必须为构造器实现标上 required 修饰符：
        
        class SomeClass: SomeProtocol {
            internal var doesNotNeedToBeSettable: Int

            internal var mustBeSettable: Int

            required init(someParameter: Int) {
                // 这里是构造器的实现部分
                self.doesNotNeedToBeSettable = Int(1.0)
                self.mustBeSettable = Int(1.0)
            }
        }
        /*
        使用 required 修饰符可以确保所有子类也必须提供此构造器实现，从而也能符合协议。
        
        关于 required 构造器的更多内容，请参考必要构造器。
        
        注意
        如果类已经被标记为 final，那么不需要在协议构造器的实现中使用 required 修饰符，因为 final 类不能有子类。关于 final 修饰符的更多内容，请参见防止重写。
        如果一个子类重写了父类的指定构造器，并且该构造器满足了某个协议的要求，那么该构造器的实现需要同时标注 required 和 override 修饰符：
        */
//        protocol SomeProtocol {
//            init()
//        }
        
        class SomeSuperClass {
            init() {
                // 这里是构造器的实现部分
            }
        }
        
        class SomeSubClass: SomeSuperClass, SomeProtocol {
            internal var doesNotNeedToBeSettable: Int

            internal var mustBeSettable: Int

            // 因为遵循协议，需要加上 required
            // 因为继承自父类，需要加上 override
            required override init() {
                // 这里是构造器的实现部分
                self.doesNotNeedToBeSettable = Int(1.0)
                self.mustBeSettable = Int(1.0)
            }
        }
        /*
        可失败构造器要求
        
        协议还可以为遵循协议的类型定义可失败构造器要求，详见可失败构造器。
        
        遵循协议的类型可以通过可失败构造器（init?）或非可失败构造器（init）来满足协议中定义的可失败构造器要求。协议中定义的非可失败构造器要求可以通过非可失败构造器（init）或隐式解包可失败构造器（init!）来满足。
        
        
        协议作为类型
        尽管协议本身并未实现任何功能，但是协议可以被当做一个成熟的类型来使用。
        
        协议可以像其他普通类型一样使用，使用场景如下：
        
        作为函数、方法或构造器中的参数类型或返回值类型
        作为常量、变量或属性的类型
        作为数组、字典或其他容器中的元素类型
        注意
        协议是一种类型，因此协议类型的名称应与其他类型（例如 Int，Double，String）的写法相同，使用大写字母开头的驼峰式写法，例如（FullyNamed 和 RandomNumberGenerator）。
        下面是将协议作为类型使用的例子：
        */
        
//        class Dice {
//            let sides: Int
//            let generator: RandomNumberGenerator
//            init(sides: Int, generator: RandomNumberGenerator) {
//                self.sides = sides
//                self.generator = generator
//            }
//            func roll() -> Int {
//                return Int(generator.random() * Double(sides)) + 1
//            }
//        }
        /*
        例子中定义了一个 Dice 类，用来代表桌游中拥有 N 个面的骰子。Dice 的实例含有 sides 和 generator 两个属性，前者是整型，用来表示骰子有几个面，后者为骰子提供一个随机数生成器，从而生成随机点数。
        
        generator 属性的类型为 RandomNumberGenerator，因此任何遵循了 RandomNumberGenerator 协议的类型的实例都可以赋值给 generator，除此之外并无其他要求。
        
        Dice 类还有一个构造器，用来设置初始状态。构造器有一个名为 generator，类型为 RandomNumberGenerator 的形参。在调用构造方法创建 Dice 的实例时，可以传入任何遵循 RandomNumberGenerator 协议的实例给 generator。
        
        Dice 类提供了一个名为 roll 的实例方法，用来模拟骰子的面值。它先调用 generator 的 random() 方法来生成一个 [0.0,1.0) 区间内的随机数，然后使用这个随机数生成正确的骰子面值。因为 generator 遵循了 RandomNumberGenerator 协议，可以确保它有个 random() 方法可供调用。
            
            下面的例子展示了如何使用 LinearCongruentialGenerator 的实例作为随机数生成器来创建一个六面骰子：
        */
        var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
        for _ in 1...5 {
            print("Random dice roll is \(d6.roll())")
        }
        // Random dice roll is 3
        // Random dice roll is 5
        // Random dice roll is 4
        // Random dice roll is 5
        // Random dice roll is 4
        
// MARK: 委托（代理）模式
        //委托是一种设计模式，它允许类或结构体将一些需要它们负责的功能委托给其他类型的实例。委托模式的实现很简单：定义协议来封装那些需要被委托的功能，这样就能确保遵循协议的类型能提供这些功能。委托模式可以用来响应特定的动作，或者接收外部数据源提供的数据，而无需关心外部数据源的类型。
        
        //下面的例子定义了两个基于骰子游戏的协议：
        
//        protocol DiceGame {
//            var dice: Dice { get }
//            func play()
//        }
//        protocol DiceGameDelegate {
//            func gameDidStart(_ game: DiceGame)
//            func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
//            func gameDidEnd(_ game: DiceGame)
//        }
        //DiceGame 协议可以被任意涉及骰子的游戏遵循。DiceGameDelegate 协议可以被任意类型遵循，用来追踪 DiceGame 的游戏过程。
        
        //如下所示，SnakesAndLadders 是 控制流 章节引入的蛇梯棋游戏的新版本。新版本使用 Dice 实例作为骰子，并且实现了 DiceGame 和 DiceGameDelegate 协议，后者用来记录游戏的过程：
        
//        class SnakesAndLadders: DiceGame {
//            let finalSquare = 25
//            let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
//            var square = 0
//            var board: [Int]
//            init() {
//                board = [Int](repeating: 0, count: finalSquare + 1)
//                board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
//                board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
//            }
//            var delegate: DiceGameDelegate?
//            func play() {
//                square = 0
//                delegate?.gameDidStart(self)
//                gameLoop: while square != finalSquare {
//                    let diceRoll = dice.roll()
//                    delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
//                    switch square + diceRoll {
//                    case finalSquare:
//                        break gameLoop
//                    case let newSquare where newSquare > finalSquare:
//                        continue gameLoop
//                    default:
//                        square += diceRoll
//                        square += board[square]
//                    }
//                }
//                delegate?.gameDidEnd(self)
//            }
//        }
        /*
        关于这个蛇梯棋游戏的详细描述请参阅 控制流 章节中的 Break 部分。
        
        这个版本的游戏封装到了 SnakesAndLadders 类中，该类遵循了 DiceGame 协议，并且提供了相应的可读的 dice 属性和 play() 方法。（ dice 属性在构造之后就不再改变，且协议只要求 dice 为可读的，因此将 dice 声明为常量属性。）
        
        游戏使用 SnakesAndLadders 类的 init() 构造器来初始化游戏。所有的游戏逻辑被转移到了协议中的 play() 方法，play() 方法使用协议要求的 dice 属性提供骰子摇出的值。
        
        注意，delegate 并不是游戏的必备条件，因此 delegate 被定义为 DiceGameDelegate 类型的可选属性。因为 delegate 是可选值，因此会被自动赋予初始值 nil。随后，可以在游戏中为 delegate 设置适当的值。
        
        DicegameDelegate 协议提供了三个方法用来追踪游戏过程。这三个方法被放置于游戏的逻辑中，即 play() 方法内。分别在游戏开始时，新一轮开始时，以及游戏结束时被调用。
        
        因为 delegate 是一个 DiceGameDelegate 类型的可选属性，因此在 play() 方法中通过可选链式调用来调用它的方法。若 delegate 属性为 nil，则调用方法会优雅地失败，并不会产生错误。若 delegate 不为 nil，则方法能够被调用，并传递 SnakesAndLadders 实例作为参数。
        
        如下示例定义了 DiceGameTracker 类，它遵循了 DiceGameDelegate 协议：
        */
        class DiceGameTracker: DiceGameDelegate {
            var numberOfTurns = 0
            func gameDidStart(_ game: DiceGame) {
                numberOfTurns = 0
                if game is SnakesAndLadders {
                    print("Started a new game of Snakes and Ladders")
                }
                print("The game is using a \(game.dice.sides)-sided dice")
            }
            func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
                numberOfTurns += 1
                print("Rolled a \(diceRoll)")
            }
            func gameDidEnd(_ game: DiceGame) {
                print("The game lasted for \(numberOfTurns) turns")
            }
        }
        /*
        DiceGameTracker 实现了 DiceGameDelegate 协议要求的三个方法，用来记录游戏已经进行的轮数。当游戏开始时，numberOfTurns 属性被赋值为 0，然后在每新一轮中递增，游戏结束后，打印游戏的总轮数。
        
        gameDidStart(_:) 方法从 game 参数获取游戏信息并打印。game 参数是 DiceGame 类型而不是 SnakeAndLadders 类型，所以在gameDidStart(_:) 方法中只能访问 DiceGame 协议中的内容。当然了，SnakeAndLadders 的方法也可以在类型转换之后调用。在上例代码中，通过 is 操作符检查 game 是否为 SnakesAndLadders 类型的实例，如果是，则打印出相应的消息。
        
        无论当前进行的是何种游戏，由于 game 符合 DiceGame 协议，可以确保 game 含有 dice 属性。因此在 gameDidStart(_:) 方法中可以通过传入的 game 参数来访问 dice 属性，进而打印出 dice 的 sides 属性的值。
        
        DiceGameTracker 的运行情况如下所示：
        */
        let tracker = DiceGameTracker()
        let game = SnakesAndLadders()
        game.delegate = tracker
        game.play()
        // Started a new game of Snakes and Ladders
        // The game is using a 6-sided dice
        // Rolled a 3
        // Rolled a 5
        // Rolled a 4
        // Rolled a 5
        // The game lasted for 4 turns
        
// MARK:通过扩展添加协议一致性
        /*
        即便无法修改源代码，依然可以通过扩展令已有类型遵循并符合协议。扩展可以为已有类型添加属性、方法、下标以及构造器，因此可以符合协议中的相应要求。详情请在扩展章节中查看。
        
        注意
        通过扩展令已有类型遵循并符合协议时，该类型的所有实例也会随之获得协议中定义的各项功能。
        例如下面这个 TextRepresentable 协议，任何想要通过文本表示一些内容的类型都可以实现该协议。这些想要表示的内容可以是实例本身的描述，也可以是实例当前状态的文本描述：
        */
//        protocol TextRepresentable {
//            var textualDescription: String { get }
//        }
        //可以通过扩展，令先前提到的 Dice 类遵循并符合 TextRepresentable 协议：
        
//        extension Dice: TextRepresentable {
//            var textualDescription: String {
//                return "A \(sides)-sided dice"
//            }
//        }
        /*
        通过扩展遵循并符合协议，和在原始定义中遵循并符合协议的效果完全相同。协议名称写在类型名之后，以冒号隔开，然后在扩展的大括号内实现协议要求的内容。
        
        现在所有 Dice 的实例都可以看做 TextRepresentable 类型：
        */
        let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
        print(d12.textualDescription)
        // 打印 “A 12-sided dice”
        //同样，SnakesAndLadders 类也可以通过扩展遵循并符合 TextRepresentable 协议：
        
//        extension SnakesAndLadders: TextRepresentable {
//            var textualDescription: String {
//                return "A game of Snakes and Ladders with \(finalSquare) squares"
//            }
//        }
        print(game.textualDescription)
        // 打印 “A game of Snakes and Ladders with 25 squares”
        
// MARK:通过扩展遵循协议
        //当一个类型已经符合了某个协议中的所有要求，却还没有声明遵循该协议时，可以通过空扩展体的扩展来遵循该协议：
        
//        struct Hamster {
//            var name: String
//            var textualDescription: String {
//                return "A hamster named \(name)"
//            }
//        }
//        extension Hamster: TextRepresentable {}
        //从现在起，Hamster 的实例可以作为 TextRepresentable 类型使用：
        
        let simonTheHamster = Hamster(name: "Simon")
        let somethingTextRepresentable: TextRepresentable = simonTheHamster as! TextRepresentable
        print(somethingTextRepresentable.textualDescription)
        // 打印 “A hamster named Simon”
        //注意 即使满足了协议的所有要求，类型也不会自动遵循协议，必须显式地遵循协议。
        
// MARK:协议类型的集合
        //协议类型可以在数组或者字典这样的集合中使用，在协议类型提到了这样的用法。下面的例子创建了一个元素类型为 TextRepresentable 的数组：
        
        let things: [TextRepresentable] = [game as! TextRepresentable, d12 as! TextRepresentable, simonTheHamster as! TextRepresentable]
        //如下所示，可以遍历 things 数组，并打印每个元素的文本表示：
        
        for thing in things {
            print(thing.textualDescription)
        }
        // A game of Snakes and Ladders with 25 squares
        // A 12-sided dice
        // A hamster named Simon
        //thing 是 TextRepresentable 类型而不是 Dice，DiceGame，Hamster 等类型，即使实例在幕后确实是这些类型中的一种。由于 thing 是 TextRepresentable 类型，任何 TextRepresentable 的实例都有一个 textualDescription 属性，所以在每次循环中可以安全地访问 thing.textualDescription。
        
        
// MARK: 协议的继承
        //协议能够继承一个或多个其他协议，可以在继承的协议的基础上增加新的要求。协议的继承语法与类的继承相似，多个被继承的协议间用逗号分隔：
        
//        protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
//            // 这里是协议的定义部分
//        }
        //如下所示，PrettyTextRepresentable 协议继承了 TextRepresentable 协议：
        
//        protocol PrettyTextRepresentable: TextRepresentable {
//            var prettyTextualDescription: String { get }
//        }
        //例子中定义了一个新的协议 PrettyTextRepresentable，它继承自 TextRepresentable 协议。任何遵循 PrettyTextRepresentable 协议的类型在满足该协议的要求时，也必须满足 TextRepresentable 协议的要求。在这个例子中，PrettyTextRepresentable 协议额外要求遵循协议的类型提供一个返回值为 String 类型的 prettyTextualDescription 属性。
        
        //如下所示，扩展 SnakesAndLadders，使其遵循并符合 PrettyTextRepresentable 协议：
        
//        extension SnakesAndLadders: PrettyTextRepresentable {
//            var prettyTextualDescription: String {
//                var output = textualDescription + ":\n"
//                for index in 1...finalSquare {
//                    switch board[index] {
//                    case let ladder where ladder > 0:
//                        output += "▲ "
//                    case let snake where snake < 0:
//                        output += "▼ "
//                    default:
//                        output += "○ "
//                    }
//                }
//                return output
//            }
//        }
        /*
        上述扩展令 SnakesAndLadders 遵循了 PrettyTextRepresentable 协议，并提供了协议要求的 prettyTextualDescription 属性。每个 PrettyTextRepresentable 类型同时也是 TextRepresentable 类型，所以在 prettyTextualDescription 的实现中，可以访问 textualDescription 属性。然后，拼接上了冒号和换行符。接着，遍历数组中的元素，拼接一个几何图形来表示每个棋盘方格的内容：
        
        当从数组中取出的元素的值大于 0 时，用 ▲ 表示。
        当从数组中取出的元素的值小于 0 时，用 ▼ 表示。
        当从数组中取出的元素的值等于 0 时，用 ○ 表示。
        任意 SankesAndLadders 的实例都可以使用 prettyTextualDescription 属性来打印一个漂亮的文本描述：
        */
        print(game.prettyTextualDescription)
        // A game of Snakes and Ladders with 25 squares:
        // ○ ○ ▲ ○ ○ ▲ ○ ○ ▲ ▲ ○ ○ ○ ▼ ○ ○ ○ ○ ▼ ○ ○ ▼ ○ ▼ ○
        
// MARK: 类类型专属协议
        //你可以在协议的继承列表中，通过添加 class 关键字来限制协议只能被类类型遵循，而结构体或枚举不能遵循该协议。class 关键字必须第一个出现在协议的继承列表中，在其他继承的协议之前：
        
//        protocol SomeClassOnlyProtocol: class, SomeInheritedProtocol {
//            // 这里是类类型专属协议的定义部分
//        }
        /*
        在以上例子中，协议 SomeClassOnlyProtocol 只能被类类型遵循。如果尝试让结构体或枚举类型遵循该协议，则会导致编译错误。
        
        注意
        当协议定义的要求需要遵循协议的类型必须是引用语义而非值语义时，应该采用类类型专属协议。关于引用语义和值语义的更多内容，请查看结构体和枚举是值类型和类是引用类型。
        
        协议合成
        有时候需要同时遵循多个协议，你可以将多个协议采用 SomeProtocol & AnotherProtocol 这样的格式进行组合，称为 协议合成（protocol composition）。你可以罗列任意多个你想要遵循的协议，以与符号(&)分隔。
        
        下面的例子中，将 Named 和 Aged 两个协议按照上述语法组合成一个协议，作为函数参数的类型：
        */
//        protocol Named {
//            var name: String { get }
//        }
//        protocol Aged {
//            var age: Int { get }
//        }
        struct Person: Named, Aged {
            var name: String
            var age: Int
        }
        func wishHappyBirthday(to celebrator: Named & Aged) {
            print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
        }
        let birthdayPerson = Person(name: "Malcolm", age: 21)
        wishHappyBirthday(to: birthdayPerson)
        // 打印 “Happy birthday Malcolm - you're 21!”
        //Named 协议包含 String 类型的 name 属性。Aged 协议包含 Int 类型的 age 属性。Person 结构体遵循了这两个协议。
        
        //wishHappyBirthday(to:) 函数的参数 celebrator 的类型为 Named & Aged。这意味着它不关心参数的具体类型，只要参数符合这两个协议即可。
        
        //上面的例子创建了一个名为 birthdayPerson 的 Person 的实例，作为参数传递给了 wishHappyBirthday(to:) 函数。因为 Person 同时符合这两个协议，所以这个参数合法，函数将打印生日问候语。
        /*
        注意
        协议合成并不会生成新的、永久的协议类型，而是将多个协议中的要求合成到一个只在局部作用域有效的临时协议中。
        
        检查协议一致性
        你可以使用类型转换中描述的 is 和 as 操作符来检查协议一致性，即是否符合某协议，并且可以转换到指定的协议类型。检查和转换到某个协议类型在语法上和类型的检查和转换完全相同：
            
            is 用来检查实例是否符合某个协议，若符合则返回 true，否则返回 false。
                as? 返回一个可选值，当实例符合某个协议时，返回类型为协议类型的可选值，否则返回 nil。
                    as! 将实例强制向下转换到某个协议类型，如果强转失败，会引发运行时错误。
        下面的例子定义了一个 HasArea 协议，该协议定义了一个 Double 类型的可读属性 area：
        */
//        protocol HasArea {
//            var area: Double { get }
//        }
        //如下所示，Circle 类和 Country 类都遵循了 HasArea 协议：
        
        class Circle: HasArea {
            let pi = 3.1415927
            var radius: Double
            var area: Double { return pi * radius * radius }
            init(radius: Double) { self.radius = radius }
        }
        class Country: HasArea {
            var area: Double
            init(area: Double) { self.area = area }
        }
        //Circle 类把 area 属性实现为基于存储型属性 radius 的计算型属性。Country 类则把 area 属性实现为存储型属性。这两个类都正确地符合了 HasArea 协议。
        
        //如下所示，Animal 是一个未遵循 HasArea 协议的类：
        
        class Animal {
            var legs: Int
            init(legs: Int) { self.legs = legs }
        }
        //Circle，Country，Animal 并没有一个共同的基类，尽管如此，它们都是类，它们的实例都可以作为 AnyObject 类型的值，存储在同一个数组中：
        
        let objects: [AnyObject] = [
            Circle(radius: 2.0),
            Country(area: 243_610),
            Animal(legs: 4)
        ]
        //objects 数组使用字面量初始化，数组包含一个 radius 为 2 的 Circle 的实例，一个保存了英国国土面积的 Country 实例和一个 legs 为 4 的 Animal 实例。
        
        //如下所示，objects 数组可以被迭代，并对迭代出的每一个元素进行检查，看它是否符合 HasArea 协议：
        
        for object in objects {
            if let objectWithArea = object as? HasArea {
                print("Area is \(objectWithArea.area)")
            } else {
                print("Something that doesn't have an area")
            }
        }
        // Area is 12.5663708
        // Area is 243610.0
        // Something that doesn't have an area
        //当迭代出的元素符合 HasArea 协议时，将 as? 操作符返回的可选值通过可选绑定，绑定到 objectWithArea 常量上。objectWithArea 是 HasArea 协议类型的实例，因此 area 属性可以被访问和打印。
        
        //objects 数组中的元素的类型并不会因为强转而丢失类型信息，它们仍然是 Circle，Country，Animal 类型。然而，当它们被赋值给 objectWithArea 常量时，只被视为 HasArea 类型，因此只有 area 属性能够被访问。
        
        
// MARK:可选的协议要求
        /*
        协议可以定义可选要求，遵循协议的类型可以选择是否实现这些要求。在协议中使用 optional 关键字作为前缀来定义可选要求。可选要求用在你需要和 Objective-C 打交道的代码中。协议和可选要求都必须带上@objc属性。标记 @objc 特性的协议只能被继承自 Objective-C 类的类或者 @objc 类遵循，其他类以及结构体和枚举均不能遵循这种协议。
        
        使用可选要求时（例如，可选的方法或者属性），它们的类型会自动变成可选的。比如，一个类型为 (Int) -> String 的方法会变成 ((Int) -> String)?。需要注意的是整个函数类型是可选的，而不是函数的返回值。
        
        协议中的可选要求可通过可选链式调用来使用，因为遵循协议的类型可能没有实现这些可选要求。类似 someOptionalMethod?(someArgument) 这样，你可以在可选方法名称后加上 ? 来调用可选方法。详细内容可在可选链式调用章节中查看。
        
        下面的例子定义了一个名为 Counter 的用于整数计数的类，它使用外部的数据源来提供每次的增量。数据源由 CounterDataSource 协议定义，包含两个可选要求：
        */
//        @objc protocol CounterDataSource {
//            @objc optional func incrementForCount(count: Int) -> Int
//            @objc optional var fixedIncrement: Int { get }
//        }
        //CounterDataSource 协议定义了一个可选方法 increment(forCount:) 和一个可选属性 fiexdIncrement，它们使用了不同的方法来从数据源中获取适当的增量值。
        
        //注意 严格来讲，CounterDataSource 协议中的方法和属性都是可选的，因此遵循协议的类可以不实现这些要求，尽管技术上允许这样做，不过最好不要这样写。
        //Counter 类含有 CounterDataSource? 类型的可选属性 dataSource，如下所示：
        
        class Counter {
            var count = 0
            var dataSource: CounterDataSource?
            func increment() {
                if let amount = dataSource?.incrementForCount?(count: count) {
                    count += amount
                } else if let amount = dataSource?.fixedIncrement {
                    count += amount
                }
            }
        }
        /*
        Counter 类使用变量属性 count 来存储当前值。该类还定义了一个 increment 方法，每次调用该方法的时候，将会增加 count 的值。
        
        increment() 方法首先试图使用 increment(forCount:) 方法来得到每次的增量。increment() 方法使用可选链式调用来尝试调用 increment(forCount:)，并将当前的 count 值作为参数传入。
        
        这里使用了两层可选链式调用。首先，由于 dataSource 可能为 nil，因此在 dataSource 后边加上了 ?，以此表明只在 dataSource 非空时才去调用 increment(forCount:) 方法。其次，即使 dataSource 存在，也无法保证其是否实现了 increment(forCount:) 方法，因为这个方法是可选的。因此，increment(forCount:) 方法同样使用可选链式调用进行调用，只有在该方法被实现的情况下才能调用它，所以在 increment(forCount:) 方法后边也加上了 ?。
            
        调用 increment(forCount:) 方法在上述两种情形下都有可能失败，所以返回值为 Int? 类型。虽然在 CounterDataSource 协议中，increment(forCount:) 的返回值类型是非可选 Int。另外，即使这里使用了两层可选链式调用，最后的返回结果依旧是单层的可选类型。关于这一点的更多信息，请查阅连接多层可选链式调用
        
        在调用 increment(forCount:) 方法后，Int? 型的返回值通过可选绑定解包并赋值给常量 amount。如果可选值确实包含一个数值，也就是说，数据源和方法都存在，数据源方法返回了一个有效值。之后便将解包后的 amount 加到 count 上，增量操作完成。
        
        如果没有从 increment(forCount:) 方法获取到值，可能由于 dataSource 为 nil，或者它并没有实现 increment(forCount:) 方法，那么 increment() 方法将试图从数据源的 fixedIncrement 属性中获取增量。fixedIncrement 是一个可选属性，因此属性值是一个 Int? 值，即使该属性在 CounterDataSource 协议中的类型是非可选的 Int。
        
        下面的例子展示了 CounterDataSource 的简单实现。ThreeSource 类遵循了 CounterDataSource 协议，它实现了可选属性 fixedIncrement，每次会返回 3：
        */
        class ThreeSource: NSObject, CounterDataSource {
            let fixedIncrement = 3
        }
        //可以使用 ThreeSource 的实例作为 Counter 实例的数据源：
        
        var counter = Counter()
        counter.dataSource = ThreeSource()
        for _ in 1...4 {
            counter.increment()
            print(counter.count)
        }
        // 3
        // 6
        // 9
        // 12
        //上述代码新建了一个 Counter 实例，并将它的数据源设置为一个 ThreeSource 的实例，然后调用 increment() 方法四次。和预期一样，每次调用都会将 count 的值增加 3.
        
        //下面是一个更为复杂的数据源 TowardsZeroSource，它将使得最后的值变为 0：
        
        @objc class TowardsZeroSource: NSObject, CounterDataSource {
            func increment(forCount count: Int) -> Int {
                if count == 0 {
                    return 0
                } else if count < 0 {
                    return 1
                } else {
                    return -1
                }
            }
        }
        /*
        TowardsZeroSource 实现了 CounterDataSource 协议中的 increment(forCount:) 方法，以 count 参数为依据，计算出每次的增量。如果 count 已经为 0，此方法返回 0，以此表明之后不应再有增量操作发生。
        
        你可以使用 TowardsZeroSource 实例将 Counter 实例来从 -4 增加到 0。一旦增加到 0，数值便不会再有变动：
        */
        counter.count = -4
        counter.dataSource = TowardsZeroSource()
        for _ in 1...5 {
            counter.increment()
            print(counter.count)
        }
        // -3
        // -2
        // -1
        // 0
        // 0
        
// MARK: 协议扩展
        //协议可以通过扩展来为遵循协议的类型提供属性、方法以及下标的实现。通过这种方式，你可以基于协议本身来实现这些功能，而无需在每个遵循协议的类型中都重复同样的实现，也无需使用全局函数。
        
        //例如，可以扩展 RandomNumberGenerator 协议来提供 randomBool() 方法。该方法使用协议中定义的 random() 方法来返回一个随机的 Bool 值：
        
//        extension RandomNumberGenerator {
//            func randomBool() -> Bool {
//                return random() > 0.5
//            }
//        }
        //通过协议扩展，所有遵循协议的类型，都能自动获得这个扩展所增加的方法实现，无需任何额外修改：
        
        let generator_test = LinearCongruentialGenerator()
        print("Here's a random number: \(generator_test.random())")
        // 打印 “Here's a random number: 0.37464991998171”
        print("And here's a random Boolean: \(generator_test.randomBool())")
        // 打印 “And here's a random Boolean: true”
        
        /*
        提供默认实现
        
        可以通过协议扩展来为协议要求的属性、方法以及下标提供默认的实现。如果遵循协议的类型为这些要求提供了自己的实现，那么这些自定义实现将会替代扩展中的默认实现被使用。
        
        注意
        通过协议扩展为协议要求提供的默认实现和可选的协议要求不同。虽然在这两种情况下，遵循协议的类型都无需自己实现这些要求，但是通过扩展提供的默认实现可以直接调用，而无需使用可选链式调用。
        例如，PrettyTextRepresentable 协议继承自 TextRepresentable 协议，可以为其提供一个默认的 prettyTextualDescription 属性，只是简单地返回 textualDescription 属性的值：
        */
//        extension PrettyTextRepresentable  {
//            var prettyTextualDescription: String {
//                return textualDescription
//            }
//        }
        
// MARK: 为协议扩展添加限制条件
        /*
        在扩展协议的时候，可以指定一些限制条件，只有遵循协议的类型满足这些限制条件时，才能获得协议扩展提供的默认实现。这些限制条件写在协议名之后，使用 where 子句来描述，正如Where子句中所描述的。
        
        例如，你可以扩展 CollectionType 协议，但是只适用于集合中的元素遵循了 TextRepresentable 协议的情况：
        */
//        extension Collection where Iterator.Element: TextRepresentable {
//            var textualDescription: String {
//                let itemsAsText = self.map { $0.textualDescription }
//                return "[" + itemsAsText.joined(separator: ", ") + "]"
//            }
//        }
        //textualDescription 属性返回整个集合的文本描述，它将集合中的每个元素的文本描述以逗号分隔的方式连接起来，包在一对方括号中。
        
        //现在我们来看看先前的 Hamster 结构体，它符合 TextRepresentable 协议，同时这里还有个装有 Hamster 的实例的数组：
        
        let murrayTheHamster = Hamster(name: "Murray")
        let morganTheHamster = Hamster(name: "Morgan")
        let mauriceTheHamster = Hamster(name: "Maurice")
        let hamsters = [murrayTheHamster, morganTheHamster, mauriceTheHamster]
        //因为 Array 符合 CollectionType 协议，而数组中的元素又符合 TextRepresentable 协议，所以数组可以使用 textualDescription 属性得到数组内容的文本表示：
        
        print(hamsters.textualDescription)
        // 打印 “[A hamster named Murray, A hamster named Morgan, A hamster named Maurice]”
        //注意 如果多个协议扩展都为同一个协议要求提供了默认实现，而遵循协议的类型又同时满足这些协议扩展的限制条件，那么将会使用限制条件最多的那个协议扩展提供的默认实现。
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
        
        
        
        
        /*
        本页包含内容：
        
        泛型所解决的问题
        泛型函数
        类型参数
        命名类型参数
        泛型类型
        扩展一个泛型类型
        类型约束
        关联类型
        泛型 Where 语句
        具有泛型 where 子句的扩展
        泛型代码让你能够根据自定义的需求，编写出适用于任意类型、灵活可重用的函数及类型。它能让你避免代码的重复，用一种清晰和抽象的方式来表达代码的意图。
        
        泛型是 Swift 最强大的特性之一，许多 Swift 标准库是通过泛型代码构建的。事实上，泛型的使用贯穿了整本语言手册，只是你可能没有发现而已。例如，Swift 的 Array 和 Dictionary 都是泛型集合。你可以创建一个 Int 数组，也可创建一个 String 数组，甚至可以是任意其他 Swift 类型的数组。同样的，你也可以创建存储任意指定类型的字典。
        
        
        泛型所解决的问题
        下面是一个标准的非泛型函数 swapTwoInts(_:_:)，用来交换两个 Int 值：
        */
        
        /*
        func swapTwoInts(_ a: inout Int, _ b: inout Int) {
            let temporaryA = a
            a = b
            b = temporaryA
        }
        //这个函数使用输入输出参数（inout）来交换 a 和 b 的值，请参考输入输出参数。
        
        //swapTwoInts(_:_:) 函数交换 b 的原始值到 a，并交换 a 的原始值到 b。你可以调用这个函数交换两个 Int 变量的值：
        
        var someInt = 3
        var anotherInt = 107
        swapTwoInts(&someInt, &anotherInt)
        print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
        // 打印 “someInt is now 107, and anotherInt is now 3”
        //诚然，swapTwoInts(_:_:) 函数挺有用，但是它只能交换 Int 值，如果你想要交换两个 String 值或者 Double值，就不得不写更多的函数，例如 swapTwoStrings(_:_:) 和 swapTwoDoubles(_:_:)，如下所示：
        
        func swapTwoStrings(_ a: inout String, _ b: inout String) {
            let temporaryA = a
            a = b
            b = temporaryA
        }
        
        func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
            let temporaryA = a
            a = b
            b = temporaryA
        }
        */
        
        /*
        你可能注意到 swapTwoInts(_:_:)、swapTwoStrings(_:_:) 和 swapTwoDoubles(_:_:) 的函数功能都是相同的，唯一不同之处就在于传入的变量类型不同，分别是 Int、String 和 Double。
        
        在实际应用中，通常需要一个更实用更灵活的函数来交换两个任意类型的值，幸运的是，泛型代码帮你解决了这种问题。（这些函数的泛型版本已经在下面定义好了。）
        
        注意
        在上面三个函数中，a 和 b 类型相同。如果 a 和 b 类型不同，那它们俩就不能互换值。Swift 是类型安全的语言，所以它不允许一个 String 类型的变量和一个 Double 类型的变量互换值。试图这样做将导致编译错误。
        
        泛型函数
        泛型函数可以适用于任何类型，下面的 swapTwoValues(_:_:) 函数是上面三个函数的泛型版本：
        */
        
        func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
            let temporaryA = a
            a = b
            b = temporaryA
        }
        //swapTwoValues(_:_:) 的函数主体和 swapTwoInts(_:_:) 函数是一样的，它们只在第一行有点不同，如下所示：
        
        //func swapTwoInts(_ a: inout Int, _ b: inout Int)
        //func swapTwoValues<T>(_ a: inout T, _ b: inout T)
        
        /*
        这个函数的泛型版本使用了占位类型名（在这里用字母 T 来表示）来代替实际类型名（例如 Int、String 或 Double）。占位类型名没有指明 T 必须是什么类型，但是它指明了 a 和 b 必须是同一类型 T，无论 T 代表什么类型。只有 swapTwoValues(_:_:) 函数在调用时，才能根据所传入的实际类型决定 T 所代表的类型。
        
        另外一个不同之处在于这个泛型函数名（swapTwoValues(_:_:)）后面跟着占位类型名（T），并用尖括号括起来（<T>）。这个尖括号告诉 Swift 那个 T 是 swapTwoValues(_:_:) 函数定义内的一个占位类型名，因此 Swift 不会去查找名为 T 的实际类型。
        
        swapTwoValues(_:_:) 函数现在可以像 swapTwoInts(_:_:) 那样调用，不同的是它能接受两个任意类型的值，条件是这两个值有着相同的类型。swapTwoValues(_:_:) 函数被调用时，T 所代表的类型都会由传入的值的类型推断出来。
        
        在下面的两个例子中，T 分别代表 Int 和 String：
        */
        
        var someInt = 3
        var anotherInt = 107
        swapTwoValues(&someInt, &anotherInt)
        // someInt 现在 107, and anotherInt 现在 3
        
        var someString = "hello"
        var anotherString = "world"
        swapTwoValues(&someString, &anotherString)
        // someString 现在 "world", and anotherString 现在 "hello"
        //注意 上面定义的 swapTwoValues(_:_:) 函数是受 swap(_:_:) 函数启发而实现的。后者存在于 Swift 标准库，你可以在你的应用程序中使用它。如果你在代码中需要类似 swapTwoValues(_:_:) 函数的功能，你可以使用已存在的 swap(_:_:) 函数。
        
        
// MARK: 命名类型参数
        /*
        在大多数情况下，类型参数具有一个描述性名字，例如 Dictionary<Key, Value> 中的 Key 和 Value，以及 Array<Element> 中的 Element，这可以告诉阅读代码的人这些类型参数和泛型函数之间的关系。然而，当它们之间没有有意义的关系时，通常使用单个字母来命名，例如 T、U、V，正如上面演示的 swapTwoValues(_:_:) 函数中的 T 一样。
        
        注意
        请始终使用大写字母开头的驼峰命名法（例如 T 和 MyTypeParameter）来为类型参数命名，以表明它们是占位类型，而不是一个值。
        
// MARK: 泛型类型
        除了泛型函数，Swift 还允许你定义泛型类型。这些自定义类、结构体和枚举可以适用于任何类型，类似于 Array 和 Dictionary。
        
        这部分内容将向你展示如何编写一个名为 Stack （栈）的泛型集合类型。栈是一系列值的有序集合，和 Array 类似，但它相比 Swift 的 Array 类型有更多的操作限制。数组允许在数组的任意位置插入新元素或是删除其中任意位置的元素。而栈只允许在集合的末端添加新的元素（称之为入栈）。类似的，栈也只能从末端移除元素（称之为出栈）。
        
        注意
        栈的概念已被 UINavigationController 类用来构造视图控制器的导航结构。你通过调用 UINavigationController 的 pushViewController(_:animated:) 方法来添加新的视图控制器到导航栈，通过 popViewControllerAnimated(_:) 方法来从导航栈中移除视图控制器。每当你需要一个严格的“后进先出”方式来管理集合，栈都是最实用的模型。
        下图展示了一个栈的入栈（push）和出栈（pop）的行为：
        
        此处输入图片的描述
        
        现在有三个值在栈中。
        第四个值被压入到栈的顶部。
        现在有四个值在栈中，最近入栈的那个值在顶部。
        栈中最顶部的那个值被移除，或称之为出栈。
        移除掉一个值后，现在栈又只有三个值了。
        下面展示了如何编写一个非泛型版本的栈，以 Int 型的栈为例：
        
        struct IntStack {
            var items = [Int]()
            mutating func push(_ item: Int) {
                items.append(item)
            }
            mutating func pop() -> Int {
                return items.removeLast()
            }
        }
        
        这个结构体在栈中使用一个名为 items 的 Array 属性来存储值。Stack 提供了两个方法：push(_:) 和 pop()，用来向栈中压入值以及从栈中移除值。这些方法被标记为 mutating，因为它们需要修改结构体的 items 数组。
        
        上面的 IntStack 结构体只能用于 Int 类型。不过，可以定义一个泛型 Stack 结构体，从而能够处理任意类型的值。
        
        下面是相同代码的泛型版本：
        */
        
//        struct Stack<Element> {
//            var items = [Element]()
//            mutating func push(_ item: Element) {
//                items.append(item)
//            }
//            mutating func pop() -> Element {
//                return items.removeLast()
//            }
//        }
        
        /*
        注意，Stack 基本上和 IntStack 相同，只是用占位类型参数 Element 代替了实际的 Int 类型。这个类型参数包裹在紧随结构体名的一对尖括号里（<Element>）。
        
        Element 为待提供的类型定义了一个占位名。这种待提供的类型可以在结构体的定义中通过 Element 来引用。在这个例子中，Element 在如下三个地方被用作占位符：
        
        创建 items 属性，使用 Element 类型的空数组对其进行初始化。
        指定 push(_:) 方法的唯一参数 item 的类型必须是 Element 类型。
        指定 pop() 方法的返回值类型必须是 Element 类型。
        由于 Stack 是泛型类型，因此可以用来创建 Swift 中任意有效类型的栈，就像 Array 和 Dictionary 那样。
        
        你可以通过在尖括号中写出栈中需要存储的数据类型来创建并初始化一个 Stack 实例。例如，要创建一个 String 类型的栈，可以写成 Stack<String>()：
        */
        
        var stackOfStrings = Stack<String>()
        stackOfStrings.push("uno")
        stackOfStrings.push("dos")
        stackOfStrings.push("tres")
        stackOfStrings.push("cuatro")
        // 栈中现在有 4 个字符串
        //下图展示了 stackOfStrings 如何将这四个值入栈：
        
        //此处输入图片的描述
        
        //移除并返回栈顶部的值 "cuatro"，即将其出栈：
        
        let fromTheTop = stackOfStrings.pop()
        // fromTheTop 的值为 "cuatro"，现在栈中还有 3 个字符串
        //下图展示了 stackOfStrings 如何将顶部的值出栈：
        
        //此处输入图片的描述
        
        
        
// MARK: 扩展一个泛型类型
        //当你扩展一个泛型类型的时候，你并不需要在扩展的定义中提供类型参数列表。原始类型定义中声明的类型参数列表在扩展中可以直接使用，并且这些来自原始类型中的参数名称会被用作原始定义中类型参数的引用。
        
        //下面的例子扩展了泛型类型 Stack，为其添加了一个名为 topItem 的只读计算型属性，它将会返回当前栈顶端的元素而不会将其从栈中移除：
        
//        extension Stack {
//            var topItem: Element? {
//                return items.isEmpty ? nil : items[items.count - 1]
//            }
//        }
        /*
        topItem 属性会返回一个 Element 类型的可选值。当栈为空的时候，topItem 会返回 nil；当栈不为空的时候，topItem 会返回 items 数组中的最后一个元素。
        
        注意，这个扩展并没有定义一个类型参数列表。相反的，Stack 类型已有的类型参数名称 Element，被用在扩展中来表示计算型属性 topItem 的可选类型。
        
        计算型属性 topItem 现在可以用来访问任意 Stack 实例的顶端元素且不移除它：
        */
        if let topItem = stackOfStrings.topItem {
            print("The top item on the stack is \(topItem).")
        }
        // 打印 “The top item on the stack is tres.”
        
// MARK: 类型约束
        /*
        swapTwoValues(_:_:) 函数和 Stack 类型可以作用于任何类型。不过，有的时候如果能将使用在泛型函数和泛型类型中的类型添加一个特定的类型约束，将会是非常有用的。类型约束可以指定一个类型参数必须继承自指定类，或者符合一个特定的协议或协议组合。
        
        例如，Swift 的 Dictionary 类型对字典的键的类型做了些限制。在字典的描述中，字典的键的类型必须是可哈希（hashable）的。也就是说，必须有一种方法能够唯一地表示它。Dictionary 的键之所以要是可哈希的，是为了便于检查字典是否已经包含某个特定键的值。若没有这个要求，Dictionary 将无法判断是否可以插入或者替换某个指定键的值，也不能查找到已经存储在字典中的指定键的值。
        
        为了实现这个要求，一个类型约束被强制加到 Dictionary 的键类型上，要求其键类型必须符合 Hashable 协议，这是 Swift 标准库中定义的一个特定协议。所有的 Swift 基本类型（例如 String、Int、Double 和 Bool）默认都是可哈希的。
        
        当你创建自定义泛型类型时，你可以定义你自己的类型约束，这些约束将提供更为强大的泛型编程能力。抽象概念，例如可哈希的，描述的是类型在概念上的特征，而不是它们的显式类型。
        */
        
// MARK: 类型约束语法
        
        //你可以在一个类型参数名后面放置一个类名或者协议名，并用冒号进行分隔，来定义类型约束，它们将成为类型参数列表的一部分。对泛型函数添加类型约束的基本语法如下所示（作用于泛型类型时的语法与之相同）：
        
//        func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
//            // 这里是泛型函数的函数体部分
//        }
        //上面这个函数有两个类型参数。第一个类型参数 T，有一个要求 T 必须是 SomeClass 子类的类型约束；第二个类型参数 U，有一个要求 U 必须符合 SomeProtocol 协议的类型约束。
        
        
// MARK: 类型约束实践
        
        //这里有个名为 findIndex(ofString:in:) 的非泛型函数，该函数的功能是在一个 String 数组中查找给定 String 值的索引。若查找到匹配的字符串，findIndex(ofString:in:) 函数返回该字符串在数组中的索引值，否则返回 nil：
        /*
        func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
            for (index, value) in array.enumerated() {
                if value == valueToFind {
                    return index
                }
            }
            return nil
        }
        //findIndex(ofString:in:) 函数可以用于查找字符串数组中的某个字符串：
        
        let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
        if let foundIndex = findIndex(ofString: "llama", in: strings) {
            print("The index of llama is \(foundIndex)")
        }
        */
        // 打印 “The index of llama is 2”
        /*
        如果只能查找字符串在数组中的索引，用处不是很大。不过，你可以用占位类型 T 替换 String 类型来写出具有相同功能的泛型函数 findIndex(_:_:)。
        
        下面展示了 findIndex(ofString:in:) 函数的泛型版本 findIndex(ofString:in:)。请注意这个函数返回值的类型仍然是 Int?，这是因为函数返回的是一个可选的索引数，而不是从数组中得到的一个可选值。需要提醒的是，这个函数无法通过编译，原因会在例子后面说明：
        */
        /*
        func findIndex<T>(of valueToFind: T, in array:[T]) -> Int? {
            for (index, value) in array.enumerated() {
                if value == valueToFind {
                    return index
                }
            }
            return nil
        }
        */
        /*
        上面所写的函数无法通过编译。问题出在相等性检查上，即 "if value == valueToFind"。不是所有的 Swift 类型都可以用等式符（==）进行比较。比如说，如果你创建一个自定义的类或结构体来表示一个复杂的数据模型，那么 Swift 无法猜到对于这个类或结构体而言“相等”意味着什么。正因如此，这部分代码无法保证适用于每个可能的类型 T，当你试图编译这部分代码时会出现相应的错误。
        
        不过，所有的这些并不会让我们无从下手。Swift 标准库中定义了一个 Equatable 协议，该协议要求任何遵循该协议的类型必须实现等式符（==）及不等符(!=)，从而能对该类型的任意两个值进行比较。所有的 Swift 标准类型自动支持 Equatable 协议。
        
        任何 Equatable 类型都可以安全地使用在 findIndex(of:in:) 函数中，因为其保证支持等式操作符。为了说明这个事实，当你定义一个函数时，你可以定义一个 Equatable 类型约束作为类型参数定义的一部分：
        */
        func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
            for (index, value) in array.enumerated() {
                if value == valueToFind {
                    return index
                }
            }
            return nil
        }
        //findIndex(of:in:) 唯一的类型参数写做 T: Equatable，也就意味着“任何符合 Equatable 协议的类型 T ”。
        
        //findIndex(of:in:) 函数现在可以成功编译了，并且可以作用于任何符合 Equatable 的类型，如 Double 或 String：
        
        let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])
        // doubleIndex 类型为 Int?，其值为 nil，因为 9.3 不在数组中
        let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])
        // stringIndex 类型为 Int?，其值为 2
        
// MARK: 关联类型
        /*
        定义一个协议时，有的时候声明一个或多个关联类型作为协议定义的一部分将会非常有用。关联类型为协议中的某个类型提供了一个占位名（或者说别名），其代表的实际类型在协议被采纳时才会被指定。你可以通过 associatedtype 关键字来指定关联类型。
        
        
        关联类型实践
        
        下面例子定义了一个 Container 协议，该协议定义了一个关联类型 ItemType：
        */
//        protocol Container {
//            associatedtype ItemType
//            mutating func append(_ item: ItemType)
//            var count: Int { get }
//            subscript(i: Int) -> ItemType { get }
//        }
        /*
        Container 协议定义了三个任何采纳了该协议的类型（即容器）必须提供的功能：
        
        必须可以通过 append(_:) 方法添加一个新元素到容器里。
        必须可以通过 count 属性获取容器中元素的数量，并返回一个 Int 值。
        必须可以通过索引值类型为 Int 的下标检索到容器中的每一个元素。
        这个协议没有指定容器中元素该如何存储，以及元素必须是何种类型。这个协议只指定了三个任何遵从 Container 协议的类型必须提供的功能。遵从协议的类型在满足这三个条件的情况下也可以提供其他额外的功能。
        
        任何遵从 Container 协议的类型必须能够指定其存储的元素的类型，必须保证只有正确类型的元素可以加进容器中，必须明确通过其下标返回的元素的类型。
        
        为了定义这三个条件，Container 协议需要在不知道容器中元素的具体类型的情况下引用这种类型。Container 协议需要指定任何通过 append(_:) 方法添加到容器中的元素和容器中的元素是相同类型，并且通过容器下标返回的元素的类型也是这种类型。
        
        为了达到这个目的，Container 协议声明了一个关联类型 ItemType，写作 associatedtype ItemType。这个协议无法定义 ItemType 是什么类型的别名，这个信息将留给遵从协议的类型来提供。尽管如此，ItemType 别名提供了一种方式来引用 Container 中元素的类型，并将之用于 append(_:) 方法和下标，从而保证任何 Container 的行为都能够正如预期地被执行。
        
        下面是先前的非泛型的 IntStack 类型，这一版本采纳并符合了 Container 协议：
        */
        
//        struct IntStack: Container {
//            // IntStack 的原始实现部分
//            var items = [Int]()
//            mutating func push(_ item: Int) {
//                items.append(item)
//            }
//            mutating func pop() -> Int {
//                return items.removeLast()
//            }
//            // Container 协议的实现部分
//            typealias ItemType = Int
//            mutating func append(_ item: Int) {
//                self.push(item)
//            }
//            var count: Int {
//                return items.count
//            }
//            subscript(i: Int) -> Int {
//                return items[i]
//            }
//        }
        
        /*
        IntStack 结构体实现了 Container 协议的三个要求，其原有功能也不会和这些要求相冲突。
        
        此外，IntStack 在实现 Container 的要求时，指定 ItemType 为 Int 类型，即 typealias ItemType = Int，从而将 Container 协议中抽象的 ItemType 类型转换为具体的 Int 类型。
        
        由于 Swift 的类型推断，你实际上不用在 IntStack 的定义中声明 ItemType 为 Int。因为 IntStack 符合 Container 协议的所有要求，Swift 只需通过 append(_:) 方法的 item 参数类型和下标返回值的类型，就可以推断出 ItemType 的具体类型。事实上，如果你在上面的代码中删除了 typealias ItemType = Int 这一行，一切仍旧可以正常工作，因为 Swift 清楚地知道 ItemType 应该是哪种类型。
        
        你也可以让泛型 Stack 结构体遵从 Container 协议：
        */
// MARK: 这里会报错
        /*
        struct Stack<Element>: Container {
            // Stack<Element> 的原始实现部分
            var items = [Element]()
            mutating func push(_ item: Element) {
                items.append(item)
            }
            mutating func pop() -> Element {
                return items.removeLast()
            }
            // Container 协议的实现部分
            mutating func append(_ item: Element) {
                self.push(item)
            }
            var count: Int {
                return items.count
            }
            subscript(i: Int) -> Element {
                return items[i]
            }
        }
        */
        /*
        这一次，占位类型参数 Element 被用作 append(_:) 方法的 item 参数和下标的返回类型。Swift 可以据此推断出 Element 的类型即是 ItemType 的类型。
        
        
        通过扩展一个存在的类型来指定关联类型
        
        通过扩展添加协议一致性中描述了如何利用扩展让一个已存在的类型符合一个协议，这包括使用了关联类型的协议。
        
        Swift 的 Array 类型已经提供 append(_:) 方法，一个 count 属性，以及一个接受 Int 类型索引值的下标用以检索其元素。这三个功能都符合 Container 协议的要求，也就意味着你只需简单地声明 Array 采纳该协议就可以扩展 Array，使其遵从 Container 协议。你可以通过一个空扩展来实现这点，正如通过扩展采纳协议中的描述：
        */
        //extension Array: Container {}
        //如同上面的泛型 Stack 结构体一样，Array 的 append(_:) 方法和下标确保了 Swift 可以推断出 ItemType 的类型。定义了这个扩展后，你可以将任意 Array 当作 Container 来使用。
        print()
        
        // MARK: TODO 例题未完成
    }

// MARK: 访问控制
    
    func accessControl() {
        /*
        本页内容包括：
        
        模块和源文件
        访问级别
        访问控制语法
        自定义类型
        子类
        常量、变量、属性、下标
        构造器
        协议
        扩展
        泛型
        类型别名
        访问控制可以限定其他源文件或模块中的代码对你的代码的访问级别。这个特性可以让我们隐藏代码的一些实现细节，并且可以为其他人可以访问和使用的代码提供接口。
        
        你可以明确地给单个类型（类、结构体、枚举）设置访问级别，也可以给这些类型的属性、方法、构造器、下标等设置访问级别。协议也可以被限定在一定的范围内使用，包括协议里的全局常量、变量和函数。
        
        Swift 不仅提供了多种不同的访问级别，还为某些典型场景提供了默认的访问级别，这样就不需要我们在每段代码中都申明显式访问级别。其实，如果只是开发一个单一目标的应用程序，我们完全可以不用显式声明代码的访问级别。
        
        注意
        为了简单起见，对于代码中可以设置访问级别的特性（属性、基本类型、函数等），在下面的章节中我们会称之为“实体”。
        
// MARK:模块和源文件
        Swift 中的访问控制模型基于模块和源文件这两个概念。
        
        模块指的是独立的代码单元，框架或应用程序会作为一个独立的模块来构建和发布。在 Swift 中，一个模块可以使用 import 关键字导入另外一个模块。
        
        在 Swift 中，Xcode 的每个目标（例如框架或应用程序）都被当作独立的模块处理。如果你是为了实现某个通用的功能，或者是为了封装一些常用方法而将代码打包成独立的框架，这个框架就是 Swift 中的一个模块。当它被导入到某个应用程序或者其他框架时，框架内容都将属于这个独立的模块。
        
        源文件就是 Swift 中的源代码文件，它通常属于一个模块，即一个应用程序或者框架。尽管我们一般会将不同的类型分别定义在不同的源文件中，但是同一个源文件也可以包含多个类型、函数之类的定义。
        
        
// MARK:访问级别
        Swift 为代码中的实体提供了五种不同的访问级别。这些访问级别不仅与源文件中定义的实体相关，同时也与源文件所属的模块相关。
        
        开放访问和公开访问可以访问同一模块源文件中的任何实体，在模块外也可以通过导入该模块来访问源文件里的所有实体。通常情况下，框架中的某个接口可以被任何人使用时，你可以将其设置为开放或者公开访问。
        内部访问可以访问同一模块源文件中的任何实体，但是不能从模块外访问该模块源文件中的实体。通常情况下，某个接口只在应用程序或框架内部使用时，你可以将其设置为内部访问。
        文件私有访问限制实体只能被所定义的文件内部访问。当需要把这些细节被整个文件使用的时候，使用文件私有访问隐藏了一些特定功能的实现细节。
        私有访问限制实体只能在所定义的作用域内使用。需要把这些细节被整个作用域使用的时候，使用文件私有访问隐藏了一些特定功能的实现细节。
        开放访问为最高（限制最少）访问级别，私有访问为最低（限制最多）访问级别。
        
        开放访问只作用于类类型和类的成员，它和公开访问的区别如下：
        
        公开访问或者其他更严访问级别的类，只能在它们定义的模块内部被继承。
        公开访问或者其他更严访问级别的类成员，只能在它们定义的模块内部的子类中重写。
        开放访问的类，可以在它们定义的模块中被继承，也可以在引用它们的模块中被继承。
        开放访问的类成员，可以在它们定义的模块中子类中重写，也可以在引用它们的模块中的子类重写。
        把一个类标记为开放，显式地表明，你认为其他模块中的代码使用此类作为父类，然后你已经设计好了你的类的代码了。
        
        
// MARK:访问级别基本原则
        
        Swift 中的访问级别遵循一个基本原则：不可以在某个实体中定义访问级别更低（更严格）的实体。
        
        例如：
        
        一个公开访问级别的变量，其类型的访问级别不能是内部，文件私有或是私有类型的。因为无法保证变量的类型在使用变量的地方也具有访问权限。
        函数的访问级别不能高于它的参数类型和返回类型的访问级别。因为这样就会出现函数可以在任何地方被访问，但是它的参数类型和返回类型却不可以的情况。
        关于此原则的各种情况的具体实现，将在下面的细节中体现。
        
        
// MARK:默认访问级别
        
        如果你不为代码中的实体显式指定访问级别，那么它们默认为 internal 级别（有一些例外情况，稍后会进行说明）。因此，在大多数情况下，我们不需要显式指定实体的访问级别。
        
        
        单目标应用程序的访问级别
        
        当你编写一个单目标应用程序时，应用的所有功能都是为该应用服务，而不需要提供给其他应用或者模块使用，所以我们不需要明确设置访问级别，使用默认的访问级别 internal 即可。但是，你也可以使用文件私有访问或私有访问级别，用于隐藏一些功能的实现细节。
        
        
// MARK:框架的访问级别
        
        当你开发框架时，就需要把一些对外的接口定义为开放访问或公开访问级别，以便使用者导入该框架后可以正常使用其功能。这些被你定义为对外的接口，就是这个框架的 API。
        
        注意
        框架依然会使用默认的内部访问级别，也可以指定为文件私有访问或者私有访问级别。当你想把某个实体作为框架的 API 的时候，需显式为其指定开放访问或公开访问级别。
        
        单元测试目标的访问级别
        
        当你的应用程序包含单元测试目标时，为了测试，测试模块需要访问应用程序模块中的代码。默认情况下只有开放访问或公开访问级别级别的实体才可以被其他模块访问。然而，如果在导入应用程序模块的语句前使用 @testable 特性，然后在允许测试的编译设置（Build Options -> Enable Testability）下编译这个应用程序模块，单元测试目标就可以访问应用程序模块中所有内部级别的实体。
        */
        
// MARK:访问控制语法
        /*
        通过修饰符 open，public，internal，fileprivate，private 来声明实体的访问级别：
        
        public class SomePublicClass {}
        internal class SomeInternalClass {}
        fileprivate class SomeFilePrivateClass {}
        private class SomePrivateClass {}
        
        public var somePublicVariable = 0
        internal let someInternalConstant = 0
        fileprivate func someFilePrivateFunction() {}
        private func somePrivateFunction() {}
        除非专门指定，否则实体默认的访问级别为内部访问级别，可以查阅默认访问级别这一节。这意味着在不使用修饰符显式声明访问级别的情况下，SomeInternalClass 和 someInternalConstant 仍然拥有隐式的内部访问级别：
        */
        class SomeInternalClass {}   // 隐式内部访问级别
        var someInternalConstant = 0 // 隐式内部访问级别
        
// MARK:自定义类型
        //如果想为一个自定义类型指定访问级别，在定义类型时进行指定即可。新类型只能在它的访问级别限制范围内使用。例如，你定义了一个文件私有级别的类，那这个类就只能在定义它的源文件中使用，可以作为属性类型、函数参数类型或者返回类型，等等。
        
        //一个类型的访问级别也会影响到类型成员（属性、方法、构造器、下标）的默认访问级别。如果你将类型指定为私有或者文件私有级别，那么该类型的所有成员的默认访问级别也会变成私有或者文件私有级别。如果你将类型指定为公开或者内部访问级别（或者不明确指定访问级别，而使用默认的内部访问级别），那么该类型的所有成员的默认访问级别将是内部访问。
        
// MARK:重要
        //上面提到，一个公开类型的所有成员的访问级别默认为内部访问级别，而不是公开级别。如果你想将某个成员指定为公开访问级别，那么你必须显式指定。这样做的好处是，在你定义公共接口的时候，可以明确地选择哪些接口是需要公开的，哪些是内部使用的，避免不小心将内部使用的接口公开。
        /*
        public class SomePublicClass {                  // 显式公开类
            public var somePublicProperty = 0            // 显式公开类成员
            var someInternalProperty = 0                 // 隐式内部类成员
            fileprivate func someFilePrivateMethod() {}  // 显式文件私有类成员
            private func somePrivateMethod() {}          // 显式私有类成员
        }
        
        class SomeInternalClass {                       // 隐式内部类
            var someInternalProperty = 0                 // 隐式内部类成员
            fileprivate func someFilePrivateMethod() {}  // 显式文件私有类成员
            private func somePrivateMethod() {}          // 显式私有类成员
        }
        
        fileprivate class SomeFilePrivateClass {        // 显式文件私有类
            func someFilePrivateMethod() {}              // 隐式文件私有类成员
            private func somePrivateMethod() {}          // 显式私有类成员
        }
        
        private class SomePrivateClass {                // 显式私有类
            func somePrivateMethod() {}                  // 隐式私有类成员
        }
        */
// MARK:元组类型
        /*
        元组的访问级别将由元组中访问级别最严格的类型来决定。例如，如果你构建了一个包含两种不同类型的元组，其中一个类型为内部访问级别，另一个类型为私有访问级别，那么这个元组的访问级别为私有访问级别。
        
        注意
        元组不同于类、结构体、枚举、函数那样有单独的定义。元组的访问级别是在它被使用时自动推断出的，而无法明确指定。
        */
// MARK:函数类型
        /*
        函数的访问级别根据访问级别最严格的参数类型或返回类型的访问级别来决定。但是，如果这种访问级别不符合函数定义所在环境的默认访问级别，那么就需要明确地指定该函数的访问级别。
        
        下面的例子定义了一个名为 someFunction() 的全局函数，并且没有明确地指定其访问级别。也许你会认为该函数应该拥有默认的访问级别 internal，但事实并非如此。事实上，如果按下面这种写法，代码将无法通过编译：
        
        func someFunction() -> (SomeInternalClass, SomePrivateClass) {
            // 此处是函数实现部分
        }
        我们可以看到，这个函数的返回类型是一个元组，该元组中包含两个自定义的类（可查阅自定义类型）。其中一个类的访问级别是 internal，另一个的访问级别是 private，所以根据元组访问级别的原则，该元组的访问级别是 private（元组的访问级别与元组中访问级别最低的类型一致）。
        
        因为该函数返回类型的访问级别是 private，所以你必须使用 private 修饰符，明确指定该函数的访问级别：
        
        private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
            // 此处是函数实现部分
        }
        将该函数指定为 public 或 internal，或者使用默认的访问级别 internal 都是错误的，因为如果把该函数当做 public 或 internal 级别来使用的话，可能会无法访问 private 级别的返回值。
        */
        
// MARK:枚举类型
        
        //枚举成员的访问级别和该枚举类型相同，你不能为枚举成员单独指定不同的访问级别。
        
        //比如下面的例子，枚举 CompassPoint 被明确指定为 public 级别，那么它的成员 North、South、East、West 的访问级别同样也是 public：
        /*
        public enum CompassPoint {
            case North
            case South
            case East
            case West
        }
        */
        /*
// MARK:原始值和关联值
        
        枚举定义中的任何原始值或关联值的类型的访问级别至少不能低于枚举类型的访问级别。例如，你不能在一个 internal 访问级别的枚举中定义 private 级别的原始值类型。
        
        
// MARK:嵌套类型
        
        如果在 private 级别的类型中定义嵌套类型，那么该嵌套类型就自动拥有 private 访问级别。如果在 public 或者 internal 级别的类型中定义嵌套类型，那么该嵌套类型自动拥有 internal 访问级别。如果想让嵌套类型拥有 public 访问级别，那么需要明确指定该嵌套类型的访问级别。
        
        
// MARK:子类
        子类的访问级别不得高于父类的访问级别。例如，父类的访问级别是 internal，子类的访问级别就不能是 public。
        
        此外，你可以在符合当前访问级别的条件下重写任意类成员（方法、属性、构造器、下标等）。
        
        可以通过重写为继承来的类成员提供更高的访问级别。下面的例子中，类 A 的访问级别是 public，它包含一个方法 someMethod()，访问级别为 private。类 B 继承自类 A，访问级别为 internal，但是在类 B 中重写了类 A 中访问级别为 private 的方法 someMethod()，并重新指定为 internal 级别。通过这种方式，我们就可以将某类中 private 级别的类成员重新指定为更高的访问级别，以便其他人使用：
        */
        /*
        public class A {
            private func someMethod() {}
        }
        
        internal class B: A {
            override internal func someMethod() {}
        }
        //我们甚至可以在子类中，用子类成员去访问访问级别更低的父类成员，只要这一操作在相应访问级别的限制范围内（也就是说，在同一源文件中访问父类 private 级别的成员，在同一模块内访问父类 internal 级别的成员）：
        
        public class A {
            private func someMethod() {}
        }
        
        internal class B: A {
            override internal func someMethod() {
                super.someMethod()
            }
        }
        */
        /*
        因为父类 A 和子类 B 定义在同一个源文件中，所以在子类 B 可以在重写的 someMethod() 方法中调用 super.someMethod()。
        
        
// MARK:常量、变量、属性、下标
        常量、变量、属性不能拥有比它们的类型更高的访问级别。例如，你不能定义一个 public 级别的属性，但是它的类型却是 private 级别的。同样，下标也不能拥有比索引类型或返回类型更高的访问级别。
        
        如果常量、变量、属性、下标的类型是 private 级别的，那么它们必须明确指定访问级别为 private：
        
        private var privateInstance = SomePrivateClass()
        
        Getter 和 Setter
        
        常量、变量、属性、下标的 Getters 和 Setters 的访问级别和它们所属类型的访问级别相同。
        
        Setter 的访问级别可以低于对应的 Getter 的访问级别，这样就可以控制变量、属性或下标的读写权限。在 var 或 subscript 关键字之前，你可以通过 fileprivate(set)，private(set) 或 internal(set) 为它们的写入权限指定更低的访问级别。
        
        注意
        这个规则同时适用于存储型属性和计算型属性。即使你不明确指定存储型属性的 Getter 和 Setter，Swift 也会隐式地为其创建 Getter 和 Setter，用于访问该属性的后备存储。使用 fileprivate(set)，private(set) 和 internal(set) 可以改变 Setter 的访问级别，这对计算型属性也同样适用。
        下面的例子中定义了一个名为 TrackedString 的结构体，它记录了 value 属性被修改的次数：
        */
        struct TrackedString {
            private(set) var numberOfEdits = 0
            var value: String = "" {
                didSet {
                    numberOfEdits += 1
                }
            }
        }
        //TrackedString 结构体定义了一个用于存储 String 值的属性 value，并将初始值设为 ""（一个空字符串）。该结构体还定义了另一个用于存储 Int 值的属性 numberOfEdits，它用于记录属性 value 被修改的次数。这个功能通过属性 value 的 didSet 观察器实现，每当给 value 赋新值时就会调用 didSet 方法，然后将 numberOfEdits 的值加一。
        
        //结构体 TrackedString 和它的属性 value 均没有显式指定访问级别，所以它们都拥有默认的访问级别 internal。但是该结构体的 numberOfEdits 属性使用了 private(set) 修饰符，这意味着 numberOfEdits 属性只能在定义该结构体的源文件中赋值。numberOfEdits 属性的 Getter 依然是默认的访问级别 internal，但是 Setter 的访问级别是 private，这表示该属性只有在当前的源文件中是可读写的，而在当前源文件所属的模块中只是一个可读的属性。
        
        //如果你实例化 TrackedString 结构体，并多次对 value 属性的值进行修改，你就会看到 numberOfEdits 的值会随着修改次数而变化：
        
        var stringToEdit = TrackedString()
        stringToEdit.value = "This string will be tracked."
        stringToEdit.value += " This edit will increment numberOfEdits."
        stringToEdit.value += " So will this one."
        print("The number of edits is \(stringToEdit.numberOfEdits)")
        // 打印 “The number of edits is 3”
        //虽然你可以在其他的源文件中实例化该结构体并且获取到 numberOfEdits 属性的值，但是你不能对其进行赋值。这一限制保护了该记录功能的实现细节，同时还提供了方便的访问方式。
        
        //你可以在必要时为 Getter 和 Setter 显式指定访问级别。下面的例子将 TrackedString 结构体明确指定为了 public 访问级别。结构体的成员（包括 numberOfEdits 属性）拥有默认的访问级别 internal。你可以结合 public 和 private(set) 修饰符把结构体中的 numberOfEdits 属性的 Getter 的访问级别设置为 public，而 Setter 的访问级别设置为 private：
        /*
        public struct TrackedString {
            public private(set) var numberOfEdits = 0
            public var value: String = "" {
                didSet {
                    numberOfEdits += 1
                }
            }
            public init() {}
        }
        */
        /*
// MARK:构造器
        自定义构造器的访问级别可以低于或等于其所属类型的访问级别。唯一的例外是必要构造器，它的访问级别必须和所属类型的访问级别相同。
        
        如同函数或方法的参数，构造器参数的访问级别也不能低于构造器本身的访问级别。
        
        
// MARK:默认构造器
        
        如默认构造器所述，Swift 会为结构体和类提供一个默认的无参数的构造器，只要它们为所有存储型属性设置了默认初始值，并且未提供自定义的构造器。
        
        默认构造器的访问级别与所属类型的访问级别相同，除非类型的访问级别是 public。如果一个类型被指定为 public 级别，那么默认构造器的访问级别将为 internal。如果你希望一个 public 级别的类型也能在其他模块中使用这种无参数的默认构造器，你只能自己提供一个 public 访问级别的无参数构造器。
        
        
// MARK:结构体默认的成员逐一构造器
        
        如果结构体中任意存储型属性的访问级别为 private，那么该结构体默认的成员逐一构造器的访问级别就是 private。否则，这种构造器的访问级别依然是 internal。
        
        如同前面提到的默认构造器，如果你希望一个 public 级别的结构体也能在其他模块中使用其默认的成员逐一构造器，你依然只能自己提供一个 public 访问级别的成员逐一构造器。
        
        
// MARK:协议
        如果想为一个协议类型明确地指定访问级别，在定义协议时指定即可。这将限制该协议只能在适当的访问级别范围内被采纳。
        
        协议中的每一个要求都具有和该协议相同的访问级别。你不能将协议中的要求设置为其他访问级别。这样才能确保该协议的所有要求对于任意采纳者都将可用。
        
        注意
        如果你定义了一个 public 访问级别的协议，那么该协议的所有实现也会是 public 访问级别。这一点不同于其他类型，例如，当类型是 public 访问级别时，其成员的访问级别却只是 internal。
        
        协议继承
        
        如果定义了一个继承自其他协议的新协议，那么新协议拥有的访问级别最高也只能和被继承协议的访问级别相同。例如，你不能将继承自 internal 协议的新协议定义为 public 协议。
        
        
// MARK: 协议一致性
        
        一个类型可以采纳比自身访问级别低的协议。例如，你可以定义一个 public 级别的类型，它可以在其他模块中使用，同时它也可以采纳一个 internal 级别的协议，但是只能在该协议所在的模块中作为符合该协议的类型使用。
        
        采纳了协议的类型的访问级别取它本身和所采纳协议两者间最低的访问级别。也就是说如果一个类型是 public 级别，采纳的协议是 internal 级别，那么采纳了这个协议后，该类型作为符合协议的类型时，其访问级别也是 internal。
        
        如果你采纳了协议，那么实现了协议的所有要求后，你必须确保这些实现的访问级别不能低于协议的访问级别。例如，一个 public 级别的类型，采纳了 internal 级别的协议，那么协议的实现至少也得是 internal 级别。
        
        注意
        Swift 和 Objective-C 一样，协议的一致性是全局的，也就是说，在同一程序中，一个类型不可能用两种不同的方式实现同一个协议。
        
// MARK:扩展
        你可以在访问级别允许的情况下对类、结构体、枚举进行扩展。扩展成员具有和原始类型成员一致的访问级别。例如，你扩展了一个 public 或者 internal 类型，扩展中的成员具有默认的 internal 访问级别，和原始类型中的成员一致 。如果你扩展了一个 private 类型，扩展成员则拥有默认的 private 访问级别。
        
        或者，你可以明确指定扩展的访问级别（例如，private extension），从而给该扩展中的所有成员指定一个新的默认访问级别。这个新的默认访问级别仍然可以被单独指定的访问级别所覆盖。
        
        
// MARK:通过扩展添加协议一致性
        
        如果你通过扩展来采纳协议，那么你就不能显式指定该扩展的访问级别了。协议拥有相应的访问级别，并会为该扩展中所有协议要求的实现提供默认的访问级别。
        
        
// MARK:泛型
        泛型类型或泛型函数的访问级别取决于泛型类型或泛型函数本身的访问级别，还需结合类型参数的类型约束的访问级别，根据这些访问级别中的最低访问级别来确定。
        
        
// MARK:类型别名
        你定义的任何类型别名都会被当作不同的类型，以便于进行访问控制。类型别名的访问级别不可高于其表示的类型的访问级别。例如，private 级别的类型别名可以作为 private，file-private，internal，public或者open类型的别名，但是 public 级别的类型别名只能作为 public 类型的别名，不能作为 internal，file-private，或 private 类型的别名。
        
        注意
        这条规则也适用于为满足协议一致性而将类型别名用于关联类型的情况。
        */
        print()
    }
    
    func tesd() {
        /*
        本页内容包括：
        
        位运算符
        溢出运算符
        优先级和结合性
        运算符函数
        自定义运算符
        除了在之前介绍过的基本运算符，Swift 中还有许多可以对数值进行复杂运算的高级运算符。这些高级运算符包含了在 C 和 Objective-C 中已经被大家所熟知的位运算符和移位运算符。
        
        与 C 语言中的算术运算符不同，Swift 中的算术运算符默认是不会溢出的。所有溢出行为都会被捕获并报告为错误。如果想让系统允许溢出行为，可以选择使用 Swift 中另一套默认支持溢出的运算符，比如溢出加法运算符（&+）。所有的这些溢出运算符都是以 & 开头的。
        
        自定义结构体、类和枚举时，如果也为它们提供标准 Swift 运算符的实现，将会非常有用。在 Swift 中自定义运算符非常简单，运算符也会针对不同类型使用对应实现。
        
        我们不用被预定义的运算符所限制。在 Swift 中可以自由地定义中缀、前缀、后缀和赋值运算符，以及相应的优先级与结合性。这些运算符在代码中可以像预定义的运算符一样使用，我们甚至可以扩展已有的类型以支持自定义的运算符。
        */
        
// MARK:位运算符
        //位运算符可以操作数据结构中每个独立的比特位。它们通常被用在底层开发中，比如图形编程和创建设备驱动。位运算符在处理外部资源的原始数据时也十分有用，比如对自定义通信协议传输的数据进行编码和解码。
        
        //Swift 支持 C 语言中的全部位运算符，接下来会一一介绍。
        
        
// MARK:按位取反运算符
        
        //按位取反运算符（~）可以对一个数值的全部比特位进行取反：
        
        //Art/bitwiseNOT_2x.png
        
        //按位取反运算符是一个前缀运算符，需要直接放在运算的数之前，并且它们之间不能添加任何空格：
        
        let initialBits: UInt8 = 0b00001111
        let invertedBits = ~initialBits // 等于 0b11110000
        //UInt8 类型的整数有 8 个比特位，可以存储 0 ~ 255 之间的任意整数。这个例子初始化了一个 UInt8 类型的整数，并赋值为二进制的 00001111，它的前 4 位都为 0，后 4 位都为 1。这个值等价于十进制的 15。
        
        //接着使用按位取反运算符创建了一个名为 invertedBits 的常量，这个常量的值与全部位取反后的 initialBits 相等。即所有的 0 都变成了 1，同时所有的 1 都变成 0。invertedBits 的二进制值为 11110000，等价于无符号十进制数的 240。
        
        
// MARK:按位与运算符
        
        //按位与运算符（&）可以对两个数的比特位进行合并。它返回一个新的数，只有当两个数的对应位都为 1 的时候，新数的对应位才为 1：
        
        //Art/bitwiseAND_2x.png
        
        //在下面的示例当中，firstSixBits 和 lastSixBits 中间 4 个位的值都为 1。按位与运算符对它们进行了运算，得到二进制数值 00111100，等价于无符号十进制数的 60：
        
        let firstSixBits: UInt8 = 0b11111100
        let lastSixBits: UInt8  = 0b00111111
        let middleFourBits = firstSixBits & lastSixBits // 等于 00111100
        
// MARK:按位或运算符
        
        //按位或运算符（|）可以对两个数的比特位进行比较。它返回一个新的数，只要两个数的对应位中有任意一个为 1 时，新数的对应位就为 1：
        
        //Art/bitwiseOR_2x.png
        
        //在下面的示例中，someBits 和 moreBits 不同的位会被设置为 1。接位或运算符对它们进行了运算，得到二进制数值 11111110，等价于无符号十进制数的 254：
        
        let someBits: UInt8 = 0b10110010
        let moreBits: UInt8 = 0b01011110
        let combinedbits = someBits | moreBits // 等于 11111110
        
// MARK:按位异或运算符
        
        //按位异或运算符（^）可以对两个数的比特位进行比较。它返回一个新的数，当两个数的对应位不相同时，新数的对应位就为 1：
        
        //Art/bitwiseXOR_2x.png
        
        //在下面的示例当中，firstBits 和 otherBits 都有一个自己的位为 1 而对方的对应位为 0 的位。 按位异或运算符将新数的这两个位都设置为 1，同时将其它位都设置为 0：
        
        let firstBits: UInt8 = 0b00010100
        let otherBits: UInt8 = 0b00000101
        let outputBits = firstBits ^ otherBits // 等于 00010001
        
// MARK:按位左移、右移运算符
        
        //按位左移运算符（<<）和按位右移运算符（>>）可以对一个数的所有位进行指定位数的左移和右移，但是需要遵守下面定义的规则。
        
        //对一个数进行按位左移或按位右移，相当于对这个数进行乘以 2 或除以 2 的运算。将一个整数左移一位，等价于将这个数乘以 2，同样地，将一个整数右移一位，等价于将这个数除以 2。
        
        
// MARK:无符号整数的移位运算
        /*
        对无符号整数进行移位的规则如下：
        
        已经存在的位按指定的位数进行左移和右移。
        任何因移动而超出整型存储范围的位都会被丢弃。
        用 0 来填充移位后产生的空白位。
        这种方法称为逻辑移位。
        
        以下这张图展示了 11111111 << 1（即把 11111111 向左移动 1 位），和 11111111 >> 1（即把 11111111 向右移动 1 位）的结果。蓝色的部分是被移位的，灰色的部分是被抛弃的，橙色的部分则是被填充进来的：
        
        Art/bitshiftUnsigned_2x.png
        
        下面的代码演示了 Swift 中的移位运算：
        */
        
        let shiftBits: UInt8 = 4 // 即二进制的 00000100
        /*
        shiftBits << 1           // 00001000
        shiftBits << 2           // 00010000
        shiftBits << 5           // 10000000
        shiftBits << 6           // 00000000
        shiftBits >> 2           // 00000001
        可以使用移位运算对其他的数据类型进行编码和解码：
        */
        
        let pink: UInt32 = 0xCC6699
        let redComponent = (pink & 0xFF0000) >> 16  // redComponent 是 0xCC，即 204
        let greenComponent = (pink & 0x00FF00) >> 8 // greenComponent 是 0x66， 即 102
        let blueComponent = pink & 0x0000FF         // blueComponent 是 0x99，即 153
        /*
        这个示例使用了一个命名为 pink 的 UInt32 型常量来存储 CSS 中粉色的颜色值。该 CSS 的十六进制颜色值 #CC6699，在 Swift 中表示为 0xCC6699。然后利用按位与运算符（&）和按位右移运算符（>>）从这个颜色值中分解出红（CC）、绿（66）以及蓝（99）三个部分。
        
        红色部分是通过对 0xCC6699 和 0xFF0000 进行按位与运算后得到的。0xFF0000 中的 0 部分“掩盖”了 OxCC6699 中的第二、第三个字节，使得数值中的 6699 被忽略，只留下 0xCC0000。
        
        然后，再将这个数按向右移动 16 位（>> 16）。十六进制中每两个字符表示 8 个比特位，所以移动 16 位后 0xCC0000 就变为 0x0000CC。这个数和0xCC是等同的，也就是十进制数值的 204。
        
        同样的，绿色部分通过对 0xCC6699 和 0x00FF00 进行按位与运算得到 0x006600。然后将这个数向右移动 8 位，得到 0x66，也就是十进制数值的 102。
        
        最后，蓝色部分通过对 0xCC6699 和 0x0000FF 进行按位与运算得到 0x000099。这里不需要再向右移位，所以结果为 0x99 ，也就是十进制数值的 153。
        
        
// MARK:有符号整数的移位运算
        
        对比无符号整数，有符号整数的移位运算相对复杂得多，这种复杂性源于有符号整数的二进制表现形式。（为了简单起见，以下的示例都是基于 8 比特位的有符号整数的，但是其中的原理对任何位数的有符号整数都是通用的。）
        
        有符号整数使用第 1 个比特位（通常被称为符号位）来表示这个数的正负。符号位为 0 代表正数，为 1 代表负数。
        
        其余的比特位（通常被称为数值位）存储了实际的值。有符号正整数和无符号数的存储方式是一样的，都是从 0 开始算起。这是值为 4 的 Int8 型整数的二进制位表现形式：
        
        Art/bitshiftSignedFour_2x.png
        
        符号位为 0，说明这是一个正数，另外 7 位则代表了十进制数值 4 的二进制表示。
        
        负数的存储方式略有不同。它存储的值的绝对值等于 2 的 n 次方减去它的实际值（也就是数值位表示的值），这里的 n 为数值位的比特位数。一个 8 比特位的数有 7 个比特位是数值位，所以是 2 的 7 次方，即 128。
        
        这是值为 -4 的 Int8 型整数的二进制位表现形式：
        
        Art/bitshiftSignedMinusFour_2x.png
        
        这次的符号位为 1，说明这是一个负数，另外 7 个位则代表了数值 124（即 128 - 4）的二进制表示：
        
        Art/bitshiftSignedMinusFourValue_2x.png
        
        负数的表示通常被称为二进制补码表示。用这种方法来表示负数乍看起来有点奇怪，但它有几个优点。
        
        首先，如果想对 -1 和 -4 进行加法运算，我们只需要将这两个数的全部 8 个比特位进行相加，并且将计算结果中超出 8 位的数值丢弃：
        
        Art/bitshiftSignedAddition_2x.png
        
        其次，使用二进制补码可以使负数的按位左移和右移运算得到跟正数同样的效果，即每向左移一位就将自身的数值乘以 2，每向右一位就将自身的数值除以 2。要达到此目的，对有符号整数的右移有一个额外的规则：
        
        当对整数进行按位右移运算时，遵循与无符号整数相同的规则，但是对于移位产生的空白位使用符号位进行填充，而不是用 0。
        Art/bitshiftSigned_2x.png
        
        这个行为可以确保有符号整数的符号位不会因为右移运算而改变，这通常被称为算术移位。
        
        由于正数和负数的特殊存储方式，在对它们进行右移的时候，会使它们越来越接近 0。在移位的过程中保持符号位不变，意味着负整数在接近 0 的过程中会一直保持为负。
        */
        
// MARK:溢出运算符
        /*
        在默认情况下，当向一个整数赋予超过它容量的值时，Swift 默认会报错，而不是生成一个无效的数。这个行为为我们在运算过大或着过小的数的时候提供了额外的安全性。
        
        例如，Int16 型整数能容纳的有符号整数范围是 -32768 到 32767，当为一个 Int16 型变量赋的值超过这个范围时，系统就会报错：
        */
        var potentialOverflow = Int16.max
        // potentialOverflow 的值是 32767，这是 Int16 能容纳的最大整数
        potentialOverflow += 1
        /*
        // 这里会报错
        为过大或者过小的数值提供错误处理，能让我们在处理边界值时更加灵活。
        
        然而，也可以选择让系统在数值溢出的时候采取截断处理，而非报错。可以使用 Swift 提供的三个溢出运算符来让系统支持整数溢出运算。这些运算符都是以 & 开头的：
        
        溢出加法 &+
            溢出减法 &-
            溢出乘法 &*
        */
            
// MARK:数值溢出
        
        //数值有可能出现上溢或者下溢。
        
        //这个示例演示了当我们对一个无符号整数使用溢出加法（&+）进行上溢运算时会发生什么：
        
        var unsignedOverflow = UInt8.max
        // unsignedOverflow 等于 UInt8 所能容纳的最大整数 255
        unsignedOverflow = unsignedOverflow &+ 1
        // 此时 unsignedOverflow 等于 0
        //unsignedOverflow 被初始化为 UInt8 所能容纳的最大整数（255，以二进制表示即 11111111）。然后使用了溢出加法运算符（&+）对其进行加 1 运算。这使得它的二进制表示正好超出 UInt8 所能容纳的位数，也就导致了数值的溢出，如下图所示。数值溢出后，留在 UInt8 边界内的值是 00000000，也就是十进制数值的 0。
        
        //Art/overflowAddition_2x.png
        
        //同样地，当我们对一个无符号整数使用溢出减法（&-）进行下溢运算时也会产生类似的现象：
        
        //var unsignedOverflow = UInt8.min
        // unsignedOverflow 等于 UInt8 所能容纳的最小整数 0
        unsignedOverflow = unsignedOverflow &- 1
        // 此时 unsignedOverflow 等于 255
        //UInt8 型整数能容纳的最小值是 0，以二进制表示即 00000000。当使用溢出减法运算符对其进行减 1 运算时，数值会产生下溢并被截断为 11111111， 也就是十进制数值的 255。
        
        //Art/overflowUnsignedSubtraction_2x.png
        
        //溢出也会发生在有符号整型数值上。在对有符号整型数值进行溢出加法或溢出减法运算时，符号位也需要参与计算，正如按位左移、右移运算符所描述的。
        
        var signedOverflow = Int8.min
        // signedOverflow 等于 Int8 所能容纳的最小整数 -128
        signedOverflow = signedOverflow &- 1
        // 此时 signedOverflow 等于 127
        //Int8 型整数能容纳的最小值是 -128，以二进制表示即 10000000。当使用溢出减法运算符对其进行减 1 运算时，符号位被翻转，得到二进制数值 01111111，也就是十进制数值的 127，这个值也是 Int8 型整数所能容纳的最大值。
        
       // Art/overflowSignedSubtraction_2x.png
        
        //对于无符号与有符号整型数值来说，当出现上溢时，它们会从数值所能容纳的最大数变成最小的数。同样地，当发生下溢时，它们会从所能容纳的最小数变成最大的数。
        
        
// MARK:优先级和结合性
        /*
        运算符的优先级使得一些运算符优先于其他运算符，高优先级的运算符会先被计算。
        
        结合性定义了相同优先级的运算符是如何结合的，也就是说，是与左边结合为一组，还是与右边结合为一组。可以将这意思理解为“它们是与左边的表达式结合的”或者“它们是与右边的表达式结合的”。
        
        在复合表达式的运算顺序中，运算符的优先级和结合性是非常重要的。举例来说，运算符优先级解释了为什么下面这个表达式的运算结果会是 17。
        
        2 + 3 % 4 * 5
        // 结果是 17
        如果完全从左到右进行运算，则运算的过程是这样的：
        
        2 + 3 = 5
        5 % 4 = 1
        1 * 5 = 5
        但是正确答案是 17 而不是 5。优先级高的运算符要先于优先级低的运算符进行计算。与 C 语言类似，在 Swift 中，乘法运算符（*）与取余运算符（%）的优先级高于加法运算符（+）。因此，它们的计算顺序要先于加法运算。
        
        而乘法与取余的优先级相同。这时为了得到正确的运算顺序，还需要考虑结合性。乘法与取余运算都是左结合的。可以将这考虑成为这两部分表达式都隐式地加上了括号：
        
        2 + ((3 % 4) * 5)
        (3 % 4) 等于 3，所以表达式相当于：
        
        2 + (3 * 5)
        3 * 5 等于 15，所以表达式相当于：
        
        2 + 15
        因此计算结果为 17。
        
        如果想查看完整的 Swift 运算符优先级和结合性规则，请参考表达式。如果想查看 Swift 标准库提供所有的运算符，请查看 Swift Standard Library Operators Reference。
        
        注意
        相对 C 语言和 Objective-C 来说，Swift 的运算符优先级和结合性规则更加简洁和可预测。但是，这也意味着它们相较于 C 语言及其衍生语言并不是完全一致的。在对现有的代码进行移植的时候，要注意确保运算符的行为仍然符合你的预期。
        */
// MARK:运算符函数
        //类和结构体可以为现有的运算符提供自定义的实现，这通常被称为运算符重载。
        
        //下面的例子展示了如何为自定义的结构体实现加法运算符（+）。算术加法运算符是一个双目运算符，因为它可以对两个值进行运算，同时它还是中缀运算符，因为它出现在两个值中间。
        
        //例子中定义了一个名为 Vector2D 的结构体用来表示二维坐标向量 (x, y)，紧接着定义了一个可以对两个 Vector2D 结构体进行相加的运算符函数：
        
        struct Vector2D {
            var x = 0.0, y = 0.0
        }
        
        extension Vector2D {
            static func + (left: Vector2D, right: Vector2D) -> Vector2D {
                return Vector2D(x: left.x + right.x, y: left.y + right.y)
            }
        }
        //该运算符函数被定义为 Vector2D 上的一个类方法，并且函数的名字与它要进行重载的 + 名字一致。因为加法运算并不是一个向量必需的功能，所以这个类方法被定义在 Vector2D 的一个扩展中，而不是 Vector2D 结构体声明内。而算术加法运算符是双目运算符，所以这个运算符函数接收两个类型为 Vector2D 的参数，同时有一个 Vector2D 类型的返回值。
        
        //在这个实现中，输入参数分别被命名为 left 和 right，代表在 + 运算符左边和右边的两个 Vector2D 实例。函数返回了一个新的 Vector2D 实例，这个实例的 x 和 y 分别等于作为参数的两个实例的 x 和 y 的值之和。
        
        //这个类方法可以在任意两个 Vector2D 实例中间作为中缀运算符来使用：
        
        let vector = Vector2D(x: 3.0, y: 1.0)
        let anotherVector = Vector2D(x: 2.0, y: 4.0)
        let combinedVector = vector + anotherVector
        // combinedVector 是一个新的 Vector2D 实例，值为 (5.0, 5.0)
        //这个例子实现两个向量 (3.0，1.0) 和 (2.0，4.0) 的相加，并得到新的向量 (5.0，5.0)。这个过程如下图示：
        
        //Art/vectorAddition_2x.png
        
// MARK:前缀和后缀运算符
        
        //上个例子演示了一个双目中缀运算符的自定义实现。类与结构体也能提供标准单目运算符的实现。单目运算符只运算一个值。当运算符出现在值之前时，它就是前缀的（例如 -a），而当它出现在值之后时，它就是后缀的（例如 b!）。
        
        //要实现前缀或者后缀运算符，需要在声明运算符函数的时候在 func 关键字之前指定 prefix 或者 postfix 修饰符：
        
        extension Vector2D {
            static prefix func - (vector: Vector2D) -> Vector2D {
                return Vector2D(x: -vector.x, y: -vector.y)
            }
        }
        //这段代码为 Vector2D 类型实现了单目负号运算符。由于该运算符是前缀运算符，所以这个函数需要加上 prefix 修饰符。
        
        //对于简单数值，单目负号运算符可以对它们的正负性进行改变。对于 Vector2D 来说，该运算将其 x 和 y 属性的正负性都进行了改变：
        
        let positive = Vector2D(x: 3.0, y: 4.0)
        let negative = -positive
        // negative 是一个值为 (-3.0, -4.0) 的 Vector2D 实例
        let alsoPositive = -negative
        // alsoPositive 是一个值为 (3.0, 4.0) 的 Vector2D 实例
        
// MARK:复合赋值运算符
        
        //复合赋值运算符将赋值运算符（=）与其它运算符进行结合。例如，将加法与赋值结合成加法赋值运算符（+=）。在实现的时候，需要把运算符的左参数设置成 inout 类型，因为这个参数的值会在运算符函数内直接被修改。
        
        extension Vector2D {
            static func += (left: inout Vector2D, right: Vector2D) {
                left = left + right
            }
        }
        //因为加法运算在之前已经定义过了，所以在这里无需重新定义。在这里可以直接利用现有的加法运算符函数，用它来对左值和右值进行相加，并再次赋值给左值：
        
        var original = Vector2D(x: 1.0, y: 2.0)
        let vectorToAdd = Vector2D(x: 3.0, y: 4.0)
        original += vectorToAdd
        // original 的值现在为 (4.0, 6.0)
        //注意
       // 不能对默认的赋值运算符（=）进行重载。只有组合赋值运算符可以被重载。同样地，也无法对三目条件运算符 （a ? b : c） 进行重载。
        
// MARK:等价运算符
        
        //自定义的类和结构体没有对等价运算符进行默认实现，等价运算符通常被称为“相等”运算符（==）与“不等”运算符（!=）。对于自定义类型，Swift 无法判断其是否“相等”，因为“相等”的含义取决于这些自定义类型在你的代码中所扮演的角色。
        
        //为了使用等价运算符能对自定义的类型进行判等运算，需要为其提供自定义实现，实现的方法与其它中缀运算符一样：
        
        extension Vector2D {
            static func == (left: Vector2D, right: Vector2D) -> Bool {
                return (left.x == right.x) && (left.y == right.y)
            }
            static func != (left: Vector2D, right: Vector2D) -> Bool {
                return !(left == right)
            }
        }
        //上述代码实现了“相等”运算符（==）来判断两个 Vector2D 实例是否相等。对于 Vector2D 类型来说，“相等”意味着“两个实例的 x 属性和 y 属性都相等”，这也是代码中用来进行判等的逻辑。示例里同时也实现了“不等”运算符（!=），它简单地将“相等”运算符的结果进行取反后返回。
        
        //现在我们可以使用这两个运算符来判断两个 Vector2D 实例是否相等：
        
        let twoThree = Vector2D(x: 2.0, y: 3.0)
        let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
        if twoThree == anotherTwoThree {
            print("These two vectors are equivalent.")
        }
        // 打印 “These two vectors are equivalent.”
        
// MARK:自定义运算符
        /*
        除了实现标准运算符，在 Swift 中还可以声明和实现自定义运算符。可以用来自定义运算符的字符列表请参考运算符。
        
        新的运算符要使用 operator 关键字在全局作用域内进行定义，同时还要指定 prefix、infix 或者 postfix 修饰符：
        
        prefix operator +++
        上面的代码定义了一个新的名为 +++ 的前缀运算符。对于这个运算符，在 Swift 中并没有意义，因此我们针对 Vector2D 的实例来定义它的意义。对这个示例来讲，+++ 被实现为“前缀双自增”运算符。它使用了前面定义的复合加法运算符来让矩阵对自身进行相加，从而让 Vector2D 实例的 x 属性和 y 属性的值翻倍。实现 +++ 运算符的方式如下：
        */
        extension Vector2D {
            static prefix func +++ (vector: inout Vector2D) -> Vector2D {
                vector += vector
                return vector
            }
        }
        
        var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
        let afterDoubling = +++toBeDoubled
        // toBeDoubled 现在的值为 (2.0, 8.0)
        // afterDoubling 现在的值也为 (2.0, 8.0)
        
// MARK: 自定义中缀运算符的优先级
        /*
        每个自定义中缀运算符都属于某个优先级组。这个优先级组指定了这个运算符和其他中缀运算符的优先级和结合性。优先级和结合性中详细阐述了这两个特性是如何对中缀运算符的运算产生影响的。
        
        而没有明确放入优先级组的自定义中缀运算符会放到一个默认的优先级组内，其优先级高于三元运算符。
        
        以下例子定义了一个新的自定义中缀运算符 +-，此运算符属于 AdditionPrecedence 优先组：
        */
        infix operator +-: AdditionPrecedence
        extension Vector2D {
            static func +- (left: Vector2D, right: Vector2D) -> Vector2D {
                return Vector2D(x: left.x + right.x, y: left.y - right.y)
            }
        }
        let firstVector = Vector2D(x: 1.0, y: 2.0)
        let secondVector = Vector2D(x: 3.0, y: 4.0)
        let plusMinusVector = firstVector +- secondVector
        // plusMinusVector 是一个 Vector2D 实例，并且它的值为 (4.0, -2.0)
        //这个运算符把两个向量的 x 值相加，同时用第一个向量的 y 值减去第二个向量的 y 值。因为它本质上是属于“相加型”运算符，所以将它放置 + 和 - 等默认的中缀“相加型”运算符相同的优先级组中。关于 Swift 标准库提供的运算符，以及完整的运算符优先级组和结合性设置，请参考 Swift Standard Library Operators Reference。而更多关于优先级组以及自定义操作符和优先级组的语法，请参考运算符声明
        
        //注意 当定义前缀与后缀运算符的时候，我们并没有指定优先级。然而，如果对同一个值同时使用前缀与后缀运算符，则后缀运算符会先参与运算。
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

