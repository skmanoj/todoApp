//
//  MainViewController.m
//  jaap
//
//  Created by manoj sk on 7/30/17.
//  Copyright © 2017 imtesla. All rights reserved.
//

#import "MainViewController.h"
#import "MainTableViewCell.h"
#import "AppDelegate.h"
#import <MicrosoftAzureMobile/MicrosoftAzureMobile.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface MainViewController()

@property (nonatomic, strong) NSMutableArray *labelArray;
@property (nonatomic, strong) MSClient *client;
@property (nonatomic, strong) UIBarButtonItem *rightButton;
@property (nonatomic, strong) UIBarButtonItem *leftButton;
@property (nonatomic, assign) int selectedindex;
@end

@implementation MainViewController

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	[self setTitle:@"Main"];
	[self setLabelArray:[[NSMutableArray alloc] init]];
	[self setClient:[(AppDelegate *) [[UIApplication sharedApplication] delegate] client]];
	[self setRightButton:[[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action: @selector(rightButtonClicked)]];
	[self setLeftButton:[[UIBarButtonItem alloc] initWithTitle:@"-" style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonClicked)]];
	return self;
}

-(void) initializeData
{
	MSTable *table = [[self client] tableWithName:@"TodoItem"];
	[table readWithCompletion:^(MSQueryResult *result, NSError *error) {
		if(error) { // error is nil if no error occured
			NSLog(@"ERROR %@", error);
		} else {
			for(NSDictionary *item in result.items) { // items is NSArray of records that match query
				NSLog(@"Todo Item: %@", [item objectForKey:@"text"]);
				NSString* key = [item objectForKey:@"id"];
				NSString* value = [item objectForKey:@"text"];
				[[self labelArray] addObject:[NSString stringWithFormat:@"%@:%@", key, value]];
			}
			//after populating data
			[[self tableView] reloadData];
		}
	}];
}

-(void) rightButtonClicked
{
	NSString *uuid = [[NSUUID UUID] UUIDString];
	[[self labelArray] addObject:[NSString stringWithFormat:@"%@:%@", uuid, @"text1"]];

	MSTable *table = [[self client] tableWithName:@"TodoItem"];
	NSDictionary *newItem = @{@"id": uuid, @"text": @"test1", @"complete" : @NO};
	[table insert:newItem completion:^(NSDictionary *result, NSError *error) {
		if(error != nil) {
			NSLog(@"ERROR %@", error);
		} else {
			NSLog(@"Todo Item: %@", [result objectForKey:@"text"]);
			[[self tableView] reloadData];
		}
	}];
}

-(void) leftButtonClicked
{
	NSString* cellValue = [[self labelArray] objectAtIndex:[self selectedindex]];
	NSArray *array = [cellValue componentsSeparatedByString:@":"];
	MSTable *table = [[self client] tableWithName:@"TodoItem"];
	[[self labelArray] removeObjectAtIndex:[self selectedindex]];

	[table deleteWithId:array[0] completion:^(id itemId, NSError *error) {
		if(error != nil) {
			NSLog(@"ERROR %@", error);
		} else {
			NSLog(@"Todo Item deleted: %@", itemId);
			[[self tableView] reloadData];
		}
	}];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self setSelectedindex: (int)[indexPath row]];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[[self navigationItem] setRightBarButtonItem:[self rightButton]];
	[[self navigationItem] setLeftBarButtonItem:[self leftButton]];
	[self initializeData];
	[[self tableView] setDelegate:self];
	[[self tableView] setDataSource:self];
	[[self tableView] registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:@"tableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [[self labelArray] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	MainTableViewCell* cell = [[self tableView] dequeueReusableCellWithIdentifier:@"tableViewCell"];
	NSString* cellValue = [[self labelArray] objectAtIndex:indexPath.item];
	NSArray *array = [cellValue componentsSeparatedByString:@":"];
	[cell initializeCell:array[1]];
	return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(editingStyle == UITableViewCellEditingStyleDelete) {
		[[self labelArray] removeObjectAtIndex:indexPath.item];
		[[self tableView] deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}
}


@end
