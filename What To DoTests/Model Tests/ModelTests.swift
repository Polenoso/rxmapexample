//
//  ModelTests.swift
//  What To DoTests
//
//  Created by Aitor Pagán on 19/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import XCTest
@testable import What_To_Do

class ModelTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }
    
    struct SharyTypeCont: Decodable {
        let type: SharyPlanType
    }
    
    struct SharyEventDataCont: Decodable {
        let data: EventData
    }

    func testDecodeSharyPlanTypeWithMusicTypeShouldReturnTypeMusic() {
        let json = "{\"type\": \"MUSIC\"}"
        let data = Data(json.utf8)
        
        let sharyType = try! JSONDecoder().decode(SharyTypeCont.self, from: data)
        
        XCTAssertTrue(sharyType.type == SharyPlanType.music)
    }
    
    func testDecodeSharyPlanTypeWithUnknownTypeShouldReturnTypeUnknown() {
        let json = "{\"type\": \"THIS IS NOT A SUPPORTED TYPE WHATEVER\"}"
        let data = Data(json.utf8)
        
        let sharyType = try! JSONDecoder().decode(SharyTypeCont.self, from: data)
        
        XCTAssertTrue(sharyType.type == SharyPlanType.unknown)
    }
    
    func testDecodeEventDataShouldDecodeDataProvider() {
        let json = "{\"data\" :{ \"acceptationManual\" : false,"
        + "\"address\" : \"Carrer dels Almogàvers, 122, 08018 Barcelona\","
        + "\"adminProfileImageUrl\" : \"https://lh4.googleusercontent.com/-ARyYaTNl2X0/AAAAAAAAAAI/AAAAAAAAAAc/shjTLByEbJw/s96-c/photo.jpg\","
        + "\"description\" : \"Pau Roca B2B Abu Sou (All night long) at The Loft!💃🏻 http://bit.ly/2PBl7X9\","
        + "\"eventEmoji\" : \"🎧\","
        + "\"finalDate\" : \"2018-12-23\","
        + "\"finalHour\" : \"06:00\","
        + "\"initialDate\" : \"2018-12-22\","
        + "\"initialHour\" : \"23:55\","
        + "\"latitude\" : \"41.397937\","
        + "\"localizable\" : {"
        +    "\"CAT\" : \"Pau Roca B2B Abu Sou (tota la nit) a The Loft!💃🏻 http://bit.ly/2PBl7X9\","
        +    "\"ENG\" : \"Pau Roca B2B Abu Sou (All night long) at The Loft!💃🏻 http://bit.ly/2PBl7X9\","
        +    "\"ESP\" : \"¡Pau Roca B2B Abu Sou (toda la noche) en The Loft!💃🏻 http://bit.ly/2PBl7X9\""
        + "},"
        + "\"longitude\" : \"2.191224\","
        + "\"placeName\" : \"Razzmatazz\","
        + "\"provider\" : \"GOOGLE\","
        + "\"sharyPlanType\" : \"MUSIC\"}}"
        
        let data = Data(json.utf8)
        
        let eventData = try! JSONDecoder().decode(SharyEventDataCont.self, from: data)
        
        XCTAssertTrue(eventData.data.provider == "GOOGLE")
    }
    
    func testReadEventsFromFileShouldAddEventsToArrayEvents() {
        let path = Bundle.init(for: self.classForCoder).path(forResource: "events-test", ofType: "json")
        let jsonFile = FileManager().contents(atPath: path!)
        
        let events = try! JSONDecoder().decode(EventContainer.self, from: jsonFile!)
        
        XCTAssertTrue(events.data.count == 43)
    }

}
