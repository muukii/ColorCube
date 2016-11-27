//
//  ColorCubeTests.swift
//  ColorCubeTests
//
//  Created by muukii on 2016/11/27.
//  Copyright © 2016 muukii. All rights reserved.
//

import XCTest
@testable import ColorCube

class ColorCubeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testExample() {

      let resultData = Bundle(for: ColorCubeTests.self).path(forResource: "LUT", ofType: "cube")
        .flatMap { URL(fileURLWithPath: $0) }
        .flatMap { try? Data(contentsOf: $0) }

      let sampleImage = Bundle(for: ColorCubeTests.self).path(forResource: "sample", ofType: "jpg")
        .flatMap { URL(fileURLWithPath: $0) }
        .flatMap { try? Data(contentsOf: $0) }
        .flatMap { CIImage.init(data: $0) }

      let image = Bundle(for: ColorCubeTests.self).path(forResource: "LUT", ofType: "png")
        .flatMap { URL(fileURLWithPath: $0) }
        .flatMap { try? Data(contentsOf: $0) }
        .flatMap { UIImage(data: $0) }

      let data = ColorCube.cubeData(lutImage: image!, dimension: 64, colorSpace: CGColorSpaceCreateDeviceRGB())

      let filter = CIFilter(name: "CIColorCube", withInputParameters: [
        "inputCubeDimension":64,
        "inputCubeData": data,
        "inputImage":sampleImage
        ])

      print(filter!.outputImage)

      let o = filter!.outputImage

      XCTAssertEqual(data, resultData)

      print(data)

    }
}
