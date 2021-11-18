import XCTest
@testable import CombineURLSession

final class MimeTypeTests: XCTestCase {
    
    func testMimeTypeJpeg() throws {
        XCTAssertEqual(MimeType.jpeg.rawValue, "image/jpeg")
    }
    
    func testMimeTypePng() throws {
        XCTAssertEqual(MimeType.png.rawValue, "image/png")
    }
}
