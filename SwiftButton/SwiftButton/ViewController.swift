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
        
        self.testBaseData()
        self.testGenericity()
        

        print(7.simpleDescription)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        repeatItem(repeating: "knock", numberOfTimes:4)
        
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

