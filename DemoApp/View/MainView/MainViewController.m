//
//  MainViewController.m
//  DemoApp
//
//  Created by Oscar Martínez Germán on 13/5/25.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.navigationItem.title = @"DemoApp";
    self.view.backgroundColor = [UIColor systemFillColor];
    self.navigationController.navigationBar.tintColor = UIColor.whiteColor;
}


@end
