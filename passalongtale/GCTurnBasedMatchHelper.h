//
//  GCTurnBasedMatchHelper.h
//  spinningyarn
//
//  Created by chrisfarrell on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface GCTurnBasedMatchHelper : NSObject{
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
}

@property (assign, readonly) BOOL gameCenterAvailable;

+(GCTurnBasedMatchHelper*) sharedInstance;
-(void)authenticateLocalUser;

@end
