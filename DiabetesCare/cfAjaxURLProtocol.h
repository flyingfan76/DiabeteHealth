//
//  cfAjaxURLProtocol.h
//  DiabetesCare
//
//  Created by Chen, Fan on 7/17/14.
//  Copyright (c) 2014 HealthyCare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cfAjaxURLProtocol : NSURLProtocol

@property (nonatomic, strong) NSMutableData *mutableData;
@property (nonatomic, strong) NSURLResponse *response;

@end
