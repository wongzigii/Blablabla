//
//  ChatViewController.m
//  Blablabla
//
//  Created by Wongzigii on 15/3/24.
//  Copyright (c) 2015年 Wongzigii. All rights reserved.
//

#import "ChatViewController.h"
#import "BLXMPPTool.h"
#import "Constant.h"
@interface ChatViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.contactJID.bare;
    [self getChatHistroy];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getChatHistroy) name:kXMPP_MESSAGE_CHANGE object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kXMPP_MESSAGE_CHANGE object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)getChatHistroy
{
    XMPPMessageArchivingCoreDataStorage *storage = [BLXMPPTool sharedInstance].xmppMessageArchivingCoreDataStorage;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:storage.messageEntityName inManagedObjectContext:storage.mainThreadManagedObjectContext];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    //XMPPJID *bareJid
    //NSString *bareJidStr
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"bareJidStr == %@",self.contactJID.bare];
    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp"
                                                                   ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [storage.mainThreadManagedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (!fetchedObjects) {
        
    }
    self.historyArray = [NSMutableArray arrayWithArray:fetchedObjects];
    [self.tableView reloadData];
    if (self.historyArray.count > 1) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.historyArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

#pragma mark - UITableViewDelegate


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.historyArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMPPMessageArchiving_Message_CoreDataObject *message = self.historyArray[indexPath.row];
    NSString *identifier = message.isOutgoing ? @"MessageCellRight" : @"MessageCellLeft";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    UILabel *contentLabel = (UILabel *)[cell viewWithTag:10002];
    contentLabel.text = message.body;
    return cell;
}

@end
