platform :ios, '6.0'
xcodeproj 'Nocilla.xcodeproj'

pod 'JRSwizzle'

target :NocillaTests, :exclusive => true do
   pod 'MKNetworkKit', '~> 0.87'
   pod 'AFNetworking', '= 1.0RC1'
   pod 'CocoaHTTPServer', '~> 2.2.1'
   pod 'Kiwi'
   pod 'ASIHTTPRequest', '>= 1.8.1'
   pod 'JRSwizzle' #for some reason the tests aren't linking properly without repeating this...
end
