//
//  dotaheroesTests.swift
//  dotaheroesTests
//
//  Created by Ahmad Krisman Ryuzaki on 10/12/20.
//  Copyright © 2020 ahmadkrisman. All rights reserved.
//

import XCTest
import Foundation

@testable import dotaheroes

class dotaheroesTests: XCTestCase {
    
    var sampleHeroes: [Hero] = []
    
    var sampleHero: Hero!
    var similarHeroesTest: [Hero] = []
    var similarHeroesExpected: [Hero] = []

    override func setUpWithError() throws {
        
        if let path = Bundle.main.path(forResource: "sample_response", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                self.sampleHeroes = try decoder.decode(Heroes.self, from: data)
                
              } catch {
                   print(error)
              }
        }
        
        sampleHero = sampleHeroes.first(where: {$0.id == 15}) // Razor
        similarHeroesTest = Utility.getSimilar(hero: sampleHero, from: sampleHeroes)
        
        similarHeroesExpected.append(sampleHeroes.first(where: {$0.id == 82})!) // mepoo
        similarHeroesExpected.append(sampleHeroes.first(where: {$0.id == 89})!) // naga siren
        similarHeroesExpected.append(sampleHeroes.first(where: {$0.id == 49})!) // luna
        
    }

    override func tearDownWithError() throws {}

    func testParsingHeroLogic() throws {
        XCTAssert(self.sampleHeroes.count == 119)
    }
    
    func testSimilarHeroLogic() throws {
        XCTAssertTrue(self.similarHeroesTest[0].id == self.similarHeroesExpected[0].id)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
