//
//  ContactViewController.m
//  Blablabla
//
//  Created by Wongzigii on 15/3/23.
//  Copyright (c) 2015年 Wongzigii. All rights reserved.
//

#import "ContactViewController.h"
#import "Constant.h"
#import "BLXMPPTool.h"
#import "ChatViewController.h"

@interface ContactViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addFriendItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingItem;

@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rosterChange) name:kXMPP_ROSTER_CHANGE object:nil];
    self.addFriendItem.style = UIBarButtonSystemItemAdd;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kXMPP_ROSTER_CHANGE object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rosterChange
{
    self.contactArray = [NSMutableArray arrayWithArray:[BLXMPPTool sharedInstance].xmppRosterMemoryStorage.unsortedUsers];
    [self.tableView reloadData];
}

//cell
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    XMPPUserMemoryStorageObject *user = self.contactArray[indexPath.row];
    ChatViewController *vc = [segue destinationViewController];
    vc.contactJID = user.jid;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contactArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCell"];
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:10002];
    XMPPUserMemoryStorageObject *user = self.contactArray[indexPath.row];
    nameLabel.text = user.jid.full;
    return cell;
}

@end
