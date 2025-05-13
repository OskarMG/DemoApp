//
//  ContactListController.m
//  DemoApp
//
//  Created by Oscar Martínez Germán on 13/5/25.
//

#import "DemoApp-Swift.h" /// Import the auto-generated Swift header to expose `Swift files`.
#import "ContactListController.h"

@interface ContactListController ()

@end

@implementation ContactListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.navigationItem.title = [Strings contactListTitle];
    self.view.backgroundColor = [UIColor systemFillColor];
    self.navigationController.navigationBar.tintColor = UIColor.whiteColor;
}


@end
