import XCTest
import NibOwner

class Tests: XCTestCase {
    
    func testNib() {
        let view = TestView.fromNib()
        XCTAssertNotNil(view)
        XCTAssertNotNil(view?.testSubview)
    }
    
}
