//
//  SBVC.swift
//  SwiftButton
//
//  Created by hyh on 2017/4/18.
//  Copyright © 2017年 com.ylgwhyh.SwiftButton. All rights reserved.
//

import UIKit

class SBVC: UIViewController {

    var Flat:String?
    var Flong:String?
    var Tlat:String?
    var Tlong:String?
    
    // 重写父类的构造方法
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.customInit()
    }
    
    required init?(coder:NSCoder) {
        super.init(coder:coder)
        self.customInit()
    }

    func customInit() {
        Flat = "flat value";
        Flong="flong value";
        Tlat="Tlat value";
        Tlong="tlong value";
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func calculation()
    {
        print("origin_lat new\(Flat)")
        print("origin_lng new\(Flong)")
        print("dest_lat new\(Tlat)")
        print("dest_lng new\(Tlong)")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
