//
//  MessageViewController.m
//  iOSTrainingAPICalls
//
//  Created by OPSolutions on 13/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()

@property FIRFirestore *firestoreDB;
@property FIRCollectionReference *channelCollectionReference;
@property Channel *channel;
@property UIAlertController *alertController;

@end

@implementation MessageViewController

+ (instancetype)initWithChannel:(Channel *)channel {
    MessageViewController *instance = [[MessageViewController alloc] initWithNibName:nil bundle:nil];
    instance.channel = channel;
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setUp {
    self.firestoreDB = [FIRFirestore firestore];
    NSString *stringURL = [NSString stringWithFormat:@"channel/%@/thread",self.channel.channelId];
    self.channelCollectionReference = [self.firestoreDB collectionWithPath:stringURL];
    [self.channelCollectionReference addSnapshotListener:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        if (error != nil) {
            [self showAlertWithMessage:@"Error"];
        }
    }];
}

- (void)showAlertWithMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController  alertControllerWithTitle:@"Channel" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:confirmAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)handleThreadListener:(FIRDocumentChange *)changes {
    
}

- (void)showErrorWith:(NSString *)message{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Channels"
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                               }];
    [alert addAction:okButton];
    self.alertController = alert;
    [self presentViewController:alert animated:YES completion:nil];
}

@end
