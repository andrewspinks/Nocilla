#import "Kiwi.h"
#import "Nocilla.h"
#import "HTTPServer.h"
#import "LSHTTPStubURLProtocol.h"


SPEC_BEGIN(NSURLSessionStubbingSepc)

beforeEach(^{
    [[LSNocilla sharedInstance] start];
});
afterEach(^{
    [[LSNocilla sharedInstance] stop];
    [[LSNocilla sharedInstance] clearStubs];
});

context(@"NSURLSession", ^{
    it(@"should stub the request", ^{
        stubRequest(@"GET", @"https://example.com/say-hello").
        withHeader(@"Content-Type", @"text/plain").
        andReturn(200).
        withHeader(@"Content-Type", @"text/plain").
        withBody(@"hola");
        
        NSURL *url = [NSURL URLWithString:@"https://example.com/say-hello"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"GET"];
        [request setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];

        __block NSHTTPURLResponse *httpResp = nil;
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//        configuration.protocolClasses=@[[LSHTTPStubURLProtocol class]];
        NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:configuration];
        NSURLSessionDataTask *task = [urlSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
          httpResp = (NSHTTPURLResponse *)response;
        }];

        [task resume];

        [[expectFutureValue(httpResp) shouldEventually] beNonNil];
        [[expectFutureValue(theValue(httpResp.statusCode)) shouldEventually]  equal:theValue(200)];
    });
});
SPEC_END