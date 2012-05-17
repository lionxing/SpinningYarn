//
//  GCTurnBasedMatchHelper.m
//  spinningyarn
//
//  Created by chrisfarrell on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GCTurnBasedMatchHelper.h"

@implementation GCTurnBasedMatchHelper

@synthesize gameCenterAvailable;

#pragma mark Initialization

static GCTurnBasedMatchHelper* sharedHelper = nil;
+(GCTurnBasedMatchHelper*) sharedInstance{
    if (!sharedHelper) {
        sharedHelper = [[GCTurnBasedMatchHelper alloc] init];
    }
    return sharedHelper;
}

-(BOOL)isGameCenterAvailable{
    //check for instance of GKLocalPlayer api
    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
    //check if the device is running 4.1 or later
    NSString* reqSysVer = @"4.1";
    NSString* curSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([curSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
    return (gcClass && osVersionSupported);
}

- (id)init
{
    self = [super init];
    if (self) {
        gameCenterAvailable = [self isGameCenterAvailable];
        if (gameCenterAvailable) {
            NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
            [nc addObserver:self selector:@selector(authenticationChanged) name:GKPlayerDidChangeNotificationName object:nil];
        }
    }
    return self;
}

-(void)authenticationChanged{
    if ([GKLocalPlayer localPlayer].isAuthenticated && !userAuthenticated) {
        NSLog(@"authentication changed: player authenticated");
        userAuthenticated = YES;
        
    }else if (![GKLocalPlayer localPlayer].isAuthenticated && userAuthenticated) {
        NSLog(@"authentication changed: player not authenticated");
        userAuthenticated = YES;
    }
}

#pragma mark User functions
-(void)authenticateLocalUser{
    if (!gameCenterAvailable) {
        return;
    }
    NSLog(@"autheticating local user");
    
    if ([GKLocalPlayer localPlayer].isAuthenticated == NO) {
        [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:nil];
    }else {
        NSLog(@"already authenticated");
    }
}

@end
