//
//  ViewController.swift
//  SwiftButton
//
//  Created by ylgwhyh on 16/10/12.
//  Copyright © 2016年 com.ylgwhyh.SwiftButton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func studyButton(_ sender: UIButton) {
        print("I am studying Swift...")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.testBaseData()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    }
    
    


}

