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
@property FIRUser *user;
@property UIAlertController *alertController;
@property NSMutableArray<Message *>*messages;

@end

@implementation MessageViewController

+ (instancetype)initWithChannel:(Channel *)channel withUser:(FIRUser *)user {
    MessageViewController *instance = [[MessageViewController alloc] initWithNibName:nil bundle:nil];
    instance.channel = channel;
    instance.user = user;
    instance.showTypingIndicator = YES;
    instance.messages =  [[NSMutableArray alloc]init];
    instance.inputToolbar.contentView.leftBarButtonItem = nil;
    
    return instance;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpDelegates];
    [self setUp];
}

- (void)setUpDelegates {
    self.inputToolbar.delegate = self;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (void)setUp {
    self.firestoreDB = [FIRFirestore firestore];
    NSString *stringURL = [NSString stringWithFormat:@"channel/%@/thread",self.channel.channelId];
    self.channelCollectionReference = [self.firestoreDB collectionWithPath:stringURL];
    [self.channelCollectionReference addSnapshotListener:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        if (error != nil) {
            [self showAlertWithMessage:@"Error"];
        }
        
        for (FIRDocumentChange *change in [snapshot documentChanges]) {
            [self handleThreadListener:change];
            
        }
        [self automaticallyScrollsToMostRecentMessage];
        
    }];
}

- (void)showAlertWithMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController  alertControllerWithTitle:@"Channel" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:confirmAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)handleThreadListener:(FIRDocumentChange *)changes {
    Message *message = [Message initWithDocument:changes.document];
    if (message == nil) {
        return;
    }
    switch (changes.type) {
        case FIRDocumentChangeTypeAdded:
            [self.messages addObject:message];
            break;
        case FIRDocumentChangeTypeModified:
            
            break;
        case FIRDocumentChangeTypeRemoved:
        
            break;
    }
    [self.collectionView reloadData];
    [self scrollToBottomAnimated:YES];
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.messages.count;
}

- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.messages[indexPath.row];
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didTapMessageBubbleAtIndexPath:(NSIndexPath *)indexPath {
    Message *message = self.messages[indexPath.row];
    NSLog(@"Tapped Message Bubble: %@", message);
}

- (NSString *)senderId {
    return self.user.uid;
}

- (NSString *)senderDisplayName {
    return [AppSettings.shared getUsername];
}

- (id<JSQMessageAvatarImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    JSQMessagesAvatarImageFactory *factory = [[JSQMessagesAvatarImageFactory alloc] init];
    Message *msg = self.messages[indexPath.row];
    
    NSString *initial = @"Puwit";
    if (![msg.senderDisplayName isEqualToString:@""]) {
        initial = [[msg.senderDisplayName substringFromIndex:1] capitalizedString];
    }
    
    return [factory avatarImageWithUserInitials:initial backgroundColor:UIColor.redColor textColor:UIColor.blackColor font:[UIFont systemFontOfSize:14.f]];
}

- (id<JSQMessageBubbleImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    JSQMessagesBubbleImageFactory *factory = [[JSQMessagesBubbleImageFactory alloc] init];
    
    Message *msg = self.messages[indexPath.row];
    if ([self.senderId isEqualToString:msg.senderId]) {
        return [factory outgoingMessagesBubbleImageWithColor:UIColor.lightGrayColor];
    }
    return [factory incomingMessagesBubbleImageWithColor:UIColor.lightGrayColor];
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath {
    Message *msg = self.messages[indexPath.row];
    NSString *senderName = msg.channelsDict[@"senderName"];
    return [[NSMutableAttributedString alloc] initWithString:senderName];
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath {
    return 15.0f;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath {
    return 15.0f;
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    Message *msg = self.messages[indexPath.row];
    NSString *dateSent = [formatter stringFromDate:msg.channelsDict[@"date"]];
    return [[NSMutableAttributedString alloc] initWithString:dateSent];
}

- (void)didPressSendButton:(UIButton *)button withMessageText:(NSString *)text senderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName date:(NSDate *)date {
    Message *message = [Message messageWithSenderId:senderId displayName:senderDisplayName text:text];
    [self sendMessage:message];
    self.inputToolbar.contentView.textView.text = @"";
}

- (void)sendMessage:(Message *)message {
    [self.channelCollectionReference addDocumentWithData:message.channelsDict completion:^(NSError * _Nullable error) {
        if (error != nil) {
            [self showAlertWithMessage:@"Error"];
        }
    }];
}


@end
