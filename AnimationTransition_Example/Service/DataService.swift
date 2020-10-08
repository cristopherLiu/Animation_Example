//
//  DataService.swift
//  AnimationTransition_Example
//
//  Created by hjliu on 2020/10/6.
//

import Foundation

class DataService {
  
  /// Making feed stubs
  private lazy var datas: [PhotoObject] = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-mm-dd"
    
    let datas: [PhotoObject] = (0...60).map { idx in
      let time = formatter.date(from: String(format: "2049-06-%02d", (idx/6)+1))!
      let imageURL = "https://picsum.photos/400/300/?random"
      return PhotoObject(time: time, imageURL: imageURL)
    }
    return datas
  }()
  
  private let urls = [
    "https://picsum.photos/300/300/?random",
    "https://picsum.photos/200/400/?random",
    "https://picsum.photos/400/500/?random",
    "https://picsum.photos/500/200/?random"
  ]
  
  private var randomUrl: String {
    let randIdx = Int(arc4random_uniform(UInt32(urls.count)))
    return urls[randIdx]
  }
  
  /// Fetch feeds from server
  func fetchData(complete: @escaping ([PhotoObject]) -> Void) {
    DispatchQueue.global().async {
      sleep(3) // fake response time
      DispatchQueue.main.async {
        complete(self.datas)
      }
    }
  }
}


public extension String {
  /// Ramdomly generated text
  static var loremIpsum: String {
    let baseStr = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas blandit aliquet orci, tincidunt pellentesque eros condimentum quis. Morbi efficitur, metus at tristique gravida, nisi nisi accumsan dolor, a porttitor libero libero eu nunc. Aenean augue mi, facilisis in vulputate at, luctus eget nibh. Nulla condimentum metus sit amet nunc commodo, at tempor velit hendrerit. Vivamus vitae pharetra quam, a fermentum diam. Aliquam dapibus justo ut turpis mattis, in feugiat purus fringilla. In hac habitasse platea dictumst."
    let strLst = baseStr.components(separatedBy: " ")
    let offset = Int(arc4random_uniform(UInt32(strLst.count)))
    let substringLst = strLst[offset..<strLst.count]
    return substringLst.joined(separator: " ")
  }
  
  private static var nameList = ["Emily", "Michael", "Hannah", "Jacob", "Alex", "Ashley", "Tyler", "Taylor", "Andrew", "Jessica", "Daniel", "Katie", "John", "Emma", "Matthew", "Lauren", "Ryan", "samantha", "Austin", "Rachel", "David", "olivia", "Chris", "Kayla", "Nick", "Anna", "Brandon", "Megan", "Nathan", "Alyssa", "Anthony", "Alexis", "Grace", "Justin", "Madison", "Joshua", "elizabeth", "Jordan", "Nicole", "Jake", "Jack", "Abby", "Dylan", "Victoria", "james", "Brianna", "kyle", "Morgan", "Kevin", "Amber", "Ben", "Sydney", "Noah", "Brittany", "Eric", "Haley", "Sam", "Natalie", "Christian", "Julia", "Josh", "Savannah", "Zach", "Danielle", "Joseph", "Courtney", "Logan", "Rebecca", "Jonathan", "Paige", "Adam", "Jasmine", "Aaron", "Sara", "Jason", "Stephanie", "Christopher"]
  
  /// Ramdomly generated name
  static var anyName: String {
    let randIdx = Int(arc4random_uniform(UInt32(nameList.count)))
    return nameList[randIdx]
  }
}
