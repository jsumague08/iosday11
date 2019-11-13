//
//  ChannelViewController.m
//  iOSTrainingAPICalls
//
//  Created by OPSolutions on 12/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import "ChannelViewController.h"
#import "../../../Utility/AppSettings.h"
#import "../../../Chat/Channel/Models/Channel.h"


@interface ChannelViewController ()

@property FIRFirestore *firestoreDB;
@property FIRCollectionReference *channelCollectionReference;
@property NSMutableArray *channelsArray;
@property UIAlertController *alertController;

@end

@implementation ChannelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.channelView = (ChannelView *)[[[NSBundle mainBundle] loadNibNamed:@"ChannelView" owner:self options:nil]objectAtIndex:0];
    [self setDelegates];
    self.channelsArray = [[NSMutableArray alloc] init];
    self.channelView.userLabel.text = [AppSettings.shared getUsername];
    [self setupFirestore];
    [self setupFirestoreListener];
}

- (void)setDelegates {
    self.channelView.channelTableView.delegate = self;
    self.channelView.channelTableView.dataSource = self;
    [self.view addSubview:self.channelView];
    [self.channelView.channelTableView registerNib:[UINib nibWithNibName:@"ChannelTableViewCell" bundle:nil] forCellReuseIdentifier:@"ChannelTableViewCell"];
}

- (void)setupFirestore {
    self.firestoreDB = [FIRFirestore firestore];
    self.channelCollectionReference = [self.firestoreDB collectionWithPath:@"channel"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"array count: %li",self.channelsArray.count);
    return self.channelsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.channelTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"ChannelTableViewCell"];
        Channel *channel = _channelsArray[indexPath.row];
    self.channelTableViewCell.channelLabel.text = channel.channelName;
    
    return self.channelTableViewCell;
}

- (void)didTapAddChannel {
    UIAlertController *alert = [self setupAddChannelAlert];
    [self presentViewController:alert animated:YES completion:nil];
}

- (UIAlertController *)setupAddChannelAlert {
    UIAlertController *alert = [UIAlertController  alertControllerWithTitle:@"Create Channel" message:@"Please input channel name." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self didTapSave];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
        
    [alert addAction:confirmAction];
    [alert addAction:cancelAction];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Channel Name";
    }];
    self.alertController = alert;
    return alert;
}

- (void)showAlertWithMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController  alertControllerWithTitle:@"Channel" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:confirmAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didTapSave {
    UITextField *textField = self.alertController.textFields[0];
    if (textField == nil) {
        return;
    }
    ChannelViewController *channelViewController = self;
    NSString *channelName = textField.text;
    Channel *channel = [Channel initWithChannelName:channelName];
    [self.channelCollectionReference addDocumentWithData:[channel presentation] completion:^(NSError * _Nullable error) {
        NSString *message = @"Success boss";
        if (error) {
            message = [NSString stringWithFormat:@"Awit. Failed to add Channel: %@",error.localizedDescription];
        }
        [channelViewController showAlertWithMessage:message];
    }];
}

- (IBAction)didPressAddButton:(id)sender {
    [self didTapAddChannel];
}

- (void)setupFirestoreListener {
    self.firestoreDB = [FIRFirestore firestore];
    self.channelCollectionReference = [self.firestoreDB collectionWithPath:@"channel"];
    
    ChannelViewController *channelViewController = self;
    [self.channelCollectionReference addSnapshotListener:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        if (error != nil) {
            [channelViewController showAlertTitle:@"Error" withMessage:error.localizedDescription];
            return;
        }
        
        for (FIRDocumentChange *change in ([snapshot documentChanges])) {
            [channelViewController handleDocumentChange:change];
        }
    }];
}

- (void)showAlertTitle:(NSString *)title withMessage:(NSString *)message {
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

- (void)handleDocumentChange:(FIRDocumentChange *)change {
    Channel *channel = [Channel initWithDocument:change.document];
    switch (change.type) {
        case FIRDocumentChangeTypeAdded:
            [self addChannelToTable:channel];
            break;
        case FIRDocumentChangeTypeModified:
         [self updateChannelToTable:channel];
         break;
        case FIRDocumentChangeTypeRemoved:
            [self removeChannelToTable:channel];
        break;
    }
    [self.channelView.channelTableView reloadData];
}

- (void)addChannelToTable:(Channel *)channel {
    if ([self.channelsArray containsObject:channel]) {
        return;
    }
    [self.channelsArray addObject:channel];
    NSInteger index = [self.channelsArray count] -1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    NSArray *paths = [NSArray arrayWithObject:indexPath];
    [self.channelView.channelTableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)removeChannelToTable:(Channel *)channel {
    NSInteger index = [self.channelsArray indexOfObject:channel];
    if ([self.channelsArray containsObject:channel]) {
        [self.channelsArray removeObject:channel];
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    NSArray *paths = [NSArray arrayWithObject:indexPath];
    [self.channelView.channelTableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)updateChannelToTable:(Channel *)channel {
    NSInteger index = [self.channelsArray indexOfObject:channel];
    self.channelsArray[index] = channel;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    NSArray *paths = [NSArray arrayWithObject:indexPath];
    [self.channelView.channelTableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Channel *channel = self.channelsArray[indexPath.row];
    if (channel == nil) {
        return;
    }
    MessageViewController *vc = [MessageViewController initWithChannel:channel];
    
}

@end
