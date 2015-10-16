//
//  UIImageTests.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/15.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//


import XCTest
@testable import UINProjectBaseSet

class UIImageTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGradationStart() {
        
        let type1 = UIImage.GradationStart.Top
        let type2 = UIImage.GradationStart.Bottom
        let type3 = UIImage.GradationStart.Right
        let type4 = UIImage.GradationStart.Left
        let type5 = UIImage.GradationStart.TopLeft
        let type6 = UIImage.GradationStart.TopRight
        let type7 = UIImage.GradationStart.BottomLeft
        let type8 = UIImage.GradationStart.BottomRight
        
        XCTAssertEqual(type1.hashValue, 0, "Enum rawvalue is wrong :: testGradationStart")
        XCTAssertEqual(type2.hashValue, 1, "Enum rawvalue is wrong :: testGradationStart")
        XCTAssertEqual(type3.hashValue, 2, "Enum rawvalue is wrong :: testGradationStart")
        XCTAssertEqual(type4.hashValue, 3, "Enum rawvalue is wrong :: testGradationStart")
        XCTAssertEqual(type5.hashValue, 4, "Enum rawvalue is wrong :: testGradationStart")
        XCTAssertEqual(type6.hashValue, 5, "Enum rawvalue is wrong :: testGradationStart")
        XCTAssertEqual(type7.hashValue, 6, "Enum rawvalue is wrong :: testGradationStart")
        XCTAssertEqual(type8.hashValue, 7, "Enum rawvalue is wrong :: testGradationStart")
        return
    }
    
    func testImageResizePosition() {
        
        let type1 = UIImage.ImageResizePosition.Center
        XCTAssertEqual(type1.hashValue, 0, "Enum rawvalue is wrong :: testImageResizePosition")
        return
    }
    
    func testImageResizeAspect() {
        
        let type1 = UIImage.ImageResizeAspect.ScaleToFill
        let type2 = UIImage.ImageResizeAspect.AspectFit
        let type3 = UIImage.ImageResizeAspect.AspectFill
        
        XCTAssertEqual(type1.hashValue, 0, "Enum rawvalue is wrong :: testImageResizeAspect")
        XCTAssertEqual(type2.hashValue, 1, "Enum rawvalue is wrong :: testImageResizeAspect")
        XCTAssertEqual(type3.hashValue, 2, "Enum rawvalue is wrong :: testImageResizeAspect")
        return
    }
    
    func testGetGradationImageWith() {
        // Should test on UITesting
        
        let image1 = UIImage.getGradationImageWith(size: CGSizeMake(100, 100), startFrom: .Top, colors: [UIColor.blackColor(), UIColor.whiteColor()], locations: [0.2, 0.8])
        XCTAssertNotNil(image1, "Image is not created")
        
        let image2 = UIImage.getGradationImageWith(size: CGSizeMake(100, 100), startFrom: .Bottom, colors: [UIColor.blackColor(), UIColor.whiteColor()], locations: nil)
        XCTAssertNotNil(image2, "Image is not created")
        
        let image3 = UIImage.getGradationImageWith(size: CGSizeMake(100, 100), startFrom: .Right, colors: [UIColor.blackColor(), UIColor.whiteColor()], locations: nil)
        XCTAssertNotNil(image3, "Image is not created")
        
        let image4 = UIImage.getGradationImageWith(size: CGSizeMake(100, 100), startFrom: .Left, colors: [UIColor.blackColor(), UIColor.whiteColor()], locations: nil)
        XCTAssertNotNil(image4, "Image is not created")
        
        let image5 = UIImage.getGradationImageWith(size: CGSizeMake(100, 100), startFrom: .TopLeft, colors: [UIColor.blackColor(), UIColor.whiteColor()], locations: nil)
        XCTAssertNotNil(image5, "Image is not created")
        
        let image6 = UIImage.getGradationImageWith(size: CGSizeMake(100, 110), startFrom: .TopLeft, colors: [UIColor.blackColor(), UIColor.whiteColor()], locations: nil)
        XCTAssertNotNil(image6, "Image is not created")
        
        let image7 = UIImage.getGradationImageWith(size: CGSizeMake(100, 100), startFrom: .TopRight, colors: [UIColor.blackColor(), UIColor.whiteColor()], locations: nil)
        XCTAssertNotNil(image7, "Image is not created")
        
        let image8 = UIImage.getGradationImageWith(size: CGSizeMake(100, 100), startFrom: .BottomLeft, colors: [UIColor.blackColor(), UIColor.whiteColor()], locations: nil)
        XCTAssertNotNil(image8, "Image is not created")
        
        let image9 = UIImage.getGradationImageWith(size: CGSizeMake(100, 100), startFrom: .BottomRight, colors: [UIColor.blackColor(), UIColor.whiteColor()], locations: nil)
        XCTAssertNotNil(image9, "Image is not created")
        
        let image10 = UIImage.getGradationImageWith(size: CGSizeMake(100, 100), startPoint: CGPointMake(0, 0), endPoint: CGPointMake(100, 100), colors: [UIColor.blackColor(), UIColor.whiteColor()], locations: [0.1, 0.9])
        XCTAssertNotNil(image10, "Image is not created")
        
        let image11 = UIImage.getGradationImageWith(size: CGSizeMake(100, 100), startPoint: CGPointMake(0, 0), endPoint: CGPointMake(100, 100), colors: [UIColor.blackColor(), UIColor.whiteColor()], locations: nil)
        XCTAssertNotNil(image11, "Image is not created")
        return
    }
    
    func testGetGradationMaskedImageWith() {
        // Should test on UITesting
        
        let image = UIImage.getGradationMaskedImageWith(size: CGSizeMake(100, 100), startFrom: .Top)
        XCTAssertNotNil(image, "Image is not created")
        return
    }
    
    func testGetImageWithText() {
        // Should test on UITesting
        
        let image = UIImage.getImageWithText("TEST-STRING", size: CGSizeMake(100, 100))
        XCTAssertNotNil(image, "Image is not created")
        return
    }
    
    func testGetImageFromView() {
        // Should test on UITesting
        
        let view = UIView(frame: CGRectMake(0, 0, 100, 100))
        let image = UIImage.getImageFromView(view, opaque: true)
        XCTAssertNotNil(image, "Image is not created")
        return
    }
    
    func testGetResizedImageWith() {
        // Should test on UITesting
        
        let image = UIImage.getGradationMaskedImageWith(size: CGSizeMake(100, 100), startFrom: .Top)
        let resizeImage1 = image.getResizedImageWith(size: CGSizeMake(80, 80), opaque: true, aspect: .ScaleToFill)
        let resizeImage2 = image.getResizedImageWith(size: CGSizeMake(70, 80), opaque: true, aspect: .AspectFit)
        let resizeImage3 = image.getResizedImageWith(size: CGSizeMake(70, 70), opaque: false, aspect: .AspectFill)
        XCTAssertNotNil(resizeImage1, "Image is not created")
        XCTAssertNotNil(resizeImage2, "Image is not created")
        XCTAssertNotNil(resizeImage3, "Image is not created")
        return
    }
    
    func testGetCroppedImageWith() {
        // Should test on UITesting
        
        let image = UIImage.getGradationMaskedImageWith(size: CGSizeMake(100, 100), startFrom: .Top)
        let croppedImage = image.getCroppedImageWith(size: CGSizeMake(80, 80), position: .Center)
        XCTAssertNotNil(croppedImage, "Image is not created")
        return
    }
    
    func testGetScaleWith() {
        // Should test on UITesting
        
        let image = UIImage.getGradationMaskedImageWith(size: CGSizeMake(100, 100), startFrom: .Top)
        let scaleToFil = image.getScaleWith(CGSizeMake(200, 200), aspect: .ScaleToFill)
        let scaleAspectFit = image.getScaleWith(CGSizeMake(200, 200), aspect: .AspectFit)
        let scaleAspectFill = image.getScaleWith(CGSizeMake(200, 200), aspect: .AspectFill)
        XCTAssertNotNil(scaleToFil, "Image is not created")
        XCTAssertNotNil(scaleAspectFit, "Image is not created")
        XCTAssertNotNil(scaleAspectFill, "Image is not created")
        return
    }
    
    func testGetBlurredImage() {
        // Should test on UITesting
        
        let image = UIImage.getGradationMaskedImageWith(size: CGSizeMake(100, 100), startFrom: .Top)
        let blurredImage = image.getBlurredImage()
        XCTAssertNotNil(blurredImage, "Image is not created")
        return
    }
    
    func testGetBlurredImageVircialSide() {
        // Should test on UITesting
        
        let image = UIImage.getGradationMaskedImageWith(size: CGSizeMake(100, 100), startFrom: .Top)
        let blurredImage = image.getBlurredImageVircialSide()
        XCTAssertNotNil(blurredImage, "Image is not created")
        return
    }
    
    func testGetVerticalBlurredImageWithSize() {
        // Should test on UITesting
        
        let image = UIImage.getGradationMaskedImageWith(size: CGSizeMake(100, 100), startFrom: .Top)
        let blurredImage = image.getVerticalBlurredImageWithSize(size: CGSizeMake(50, 50))
        XCTAssertNotNil(blurredImage, "Image is not created")
        return
    }
    
    func testGetResizableImage() {
        // Should test on UITesting
        
        let image = UIImage.getGradationMaskedImageWith(size: CGSizeMake(100, 100), startFrom: .Top)
        let resizableImage = image.getResizableImage()
        XCTAssertNotNil(resizableImage, "Image is not created")
        return
    }
    
    
    
    
}