//
//  DatabasePresentation.h
//  iOSTrainingAPICalls
//
//  Created by OPSolutions on 13/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//


#import <Foundation/Foundation.h>
@import FirebaseFirestore;

@protocol DatabasePresentation <NSObject>

- (NSDictionary *)presentation;
+ (instancetype)initWithDocument:(FIRQueryDocumentSnapshot *)document;
@end

