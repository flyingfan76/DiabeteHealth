//
//  cfAjaxURLProtocol.m
//  DiabetesCare
//
//  Created by Chen, Fan on 7/17/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import "cfAjaxURLProtocol.h"
@interface cfAjaxURLProtocol () <NSURLConnectionDelegate>
@property (nonatomic, strong) NSURLConnection *connection;
@end

@interface cfAjaxURLProtocol()
- (NSData *) generateFakeJson;
@end


@implementation cfAjaxURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    static NSUInteger requestCount = 0;
    NSLog(@"Request #%u: URL = %@", requestCount++, request.URL.absoluteString);

    BOOL bReturn = NO;
    if ([request.URL.absoluteString rangeOfString:@"data.json"].location == NSNotFound) {
        bReturn = NO;
    } else {
        if ([NSURLProtocol propertyForKey:@"myURLHandleKey" inRequest:request]) {
            bReturn = NO;
        }else
        {
            bReturn = YES;
        }
    }
    return bReturn;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b {
    return [super requestIsCacheEquivalent:a toRequest:b];
}

- (void)stopLoading {
    [self.connection cancel];
    self.connection = nil;
}

- (void)startLoading {
    NSURLRequest *request = [self request];
    
    NSData *jsonData = [self generateFakeJson];

    NSDictionary *headers = @{@"Access-Control-Allow-Origin" : @"*", @"Access-Control-Allow-Headers" : @"Content-Type"};
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:request.URL statusCode:200 HTTPVersion:@"1.1" headerFields:headers];
    
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    [self.client URLProtocol:self didLoadData:jsonData];
    [self.client URLProtocolDidFinishLoading:self];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    self.response = response;
    self.mutableData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.client URLProtocol:self didLoadData:data];
    [self.mutableData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self.client URLProtocolDidFinishLoading:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self.client URLProtocol:self didFailWithError:error];
}

- (NSData *) generateFakeJson{
//  1. option1 generate jsonData from file
//       NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
//        NSData *jsonData = [NSData dataWithContentsOfFile:path];
//        NSLog(@"%@",jsonData);
    
    
//  2. option2 generate jsonData from string
//    NSString *jsonString = @"[{\"name\":\"Before\",\"data\":[[0,10],[3600,100]]}]";
//    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//    
//    NSLog(@"%@",jsonData);

//  3. option3 generate jsonData from NSMutableArray
    
    NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
    [item setObject:@"before" forKey:@"name"];
    NSArray  *obj1 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:100],nil];
    NSArray  *obj2 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInteger:3600],[NSNumber numberWithInteger:100],nil];
    
    NSMutableArray *arrayItem = [[NSMutableArray alloc] initWithObjects:obj1,obj2, nil];
    
    [item setObject:arrayItem forKey:@"data"];
    
    NSMutableArray *parent = [[NSMutableArray alloc] init];
    [parent addObject:item];
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parent options:NSJSONWritingPrettyPrinted error:&error];
    NSLog(@"%@",jsonData);
    
 
    return jsonData;
}



@end
