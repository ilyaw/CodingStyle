import XCTest
@testable import CodingStyle

final class CodingStyleTests: XCTestCase {
    
    ///snake_case_example
    ///CamelCaseExample
    ///kebab-case-example
    
    func testCamelCase() throws {
        @CodingStyle(style: .camelCase) var camelCaseText: String = ""

        camelCaseText = "_thIs-iS text"
        XCTAssertEqual(camelCaseText, "ThisIsText")
        camelCaseText = "some-text_pe_qwe-Qweqe"
        XCTAssertEqual(camelCaseText, "SomeTextPeQweQweqe")
        camelCaseText = "Some Text"
        XCTAssertEqual(camelCaseText, "SomeText")
        camelCaseText = " some_text"
        XCTAssertEqual(camelCaseText, "SomeText")
        camelCaseText = "SOME TEXT"
        XCTAssertEqual(camelCaseText, "SomeText")
        camelCaseText = "-Some text"
        XCTAssertEqual(camelCaseText, "SomeText")
        camelCaseText = "Some-Text"
        XCTAssertEqual(camelCaseText, "SomeText")
        camelCaseText = "Some---_Text"
        XCTAssertEqual(camelCaseText, "SomeText")
        camelCaseText = "kebab-style_snake_case"
        XCTAssertEqual(camelCaseText, "KebabStyleSnakeCase")
    }
    
    func testSnakeCase() throws {
        @CodingStyle(style: .snakeCase) var snakeCaseText: String = ""
        
        snakeCaseText = "FooBar_FOOBAR-foo-bar"
        XCTAssertEqual(snakeCaseText, "foo_bar_foobar_foo_bar")
        snakeCaseText = "foo-bar"
        XCTAssertEqual(snakeCaseText, "foo_bar")
        snakeCaseText = "foo_bar"
        XCTAssertEqual(snakeCaseText, "foo_bar")
        snakeCaseText = "FooBarFooBar-foo bar"
        XCTAssertEqual(snakeCaseText, "foo_bar_foo_bar_foo_bar")
        snakeCaseText = "fo _    -bar FOOBAR-Foo BAR"
        XCTAssertEqual(snakeCaseText, "fo_bar_foobar_foo_bar")
        snakeCaseText = "F-B"
        XCTAssertEqual(snakeCaseText, "f_b")
    }
    
    func testKebabCase() throws {
        @CodingStyle(style: .kebabCase) var kebabCaseText: String = ""
        
        kebabCaseText = "FooBar_FOOBAR-foo-bar"
        XCTAssertEqual(kebabCaseText, "foo-bar-foobar-foo-bar")
        kebabCaseText = "foo_bar"
        XCTAssertEqual(kebabCaseText, "foo-bar")
        kebabCaseText = "foo bar BAR"
        XCTAssertEqual(kebabCaseText, "foo-bar-bar")
    }
}
