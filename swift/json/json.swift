#!/usr/bin/env swift

import Foundation
// {"id":4,"table":"Message","script":"ddd","created_at":"2016-05-12T02:33:34.235Z","updated_at":"2016-05-12T02:33:34.235Z"}

let d1 = NSData(contentsOfFile: "/Users/yielding/code/swift/json/data1.json")!
let s0 = try! String(contentsOfFile: "/Users/yielding/code/swift/json/data1.json", encoding: NSUTF8StringEncoding)
let d2 = s0.data(using: NSUTF8StringEncoding)!

let json = try! NSJSONSerialization.jsonObject(with: d2, options: NSJSONReadingOptions())

typealias PayLoad = [String: AnyObject]

let p1 = json[0]["person"] as! PayLoad
print(p1["name"]!)

print("ok")