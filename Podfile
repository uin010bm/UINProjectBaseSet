
inhibit_all_warnings!
platform :ios, '8.0'
use_frameworks!

source 'https://github.com/CocoaPods/Specs.git'

def testing_pods
    pod 'OHHTTPStubs'
    pod 'OHHTTPStubs/Swift'
end


target 'UINProjectBaseSet' do
    pod 'UIImage+BlurredFrame'
    pod 'BlocksKit'
    pod 'Alamofire'
    pod 'SwiftyJSON'
    testing_pods
end


target 'UINProjectBaseSetTests' do
    testing_pods
end


target 'UINProjectBaseSetUITests' do
    testing_pods
end

