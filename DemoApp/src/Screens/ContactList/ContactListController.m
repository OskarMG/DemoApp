//
//  ContactListController.m
//  DemoApp
//
//  Created by Oscar Martínez Germán on 13/5/25.
//

#import "DemoApp-Swift.h" /// Import the auto-generated Swift header to expose `Swift files`.
#import "ContactListController.h"

@interface ContactListController () <UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating>
    /// `UI` Elements
    @property (nonatomic, strong) UITableView *tableView;
    @property (nonatomic, strong) UISearchController *searchController;
    
    /// `Properties`
    @property (nonatomic, assign) BOOL isFiltering;
    @property (nonatomic, strong) NSArray<NSString *> *listToBeDisplayed;
    @property (nonatomic, strong) NSArray<NSString *> *originalContactList;
@end

@implementation ContactListController

static NSString *cellIdentifier = @"ContactCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setContact];
    [self setupUI];
}

- (void)setContact {
    /// Initial default values for `UI PURPOSE ONLY`
    self.originalContactList = @[@"Oscar", @"Lynn", @"Zabdi", @"Monica"];
    self.listToBeDisplayed = self.originalContactList;
}

// MARK: - UI SETUP METHODS

- (void)setupUI {
    self.view.backgroundColor = UIColor.systemFillColor;
    self.navigationItem.hidesSearchBarWhenScrolling = NO;
    self.navigationItem.title = [Strings contactListTitle];
    self.navigationItem.backBarButtonItem = [BarButton
        createWithTitle:@"" style:UIBarButtonItemStylePlain
        target:self
        action:@selector(onAddButtonTap)
    ];
    
    [self setupSearchController];
    [self setupTableView];
    [self setupAddButton];
}

- (void)setupSearchController {
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.obscuresBackgroundDuringPresentation = NO;
    self.searchController.searchBar.placeholder = [Strings searchBarPlaceholder];
    self.definesPresentationContext = YES;
    self.navigationItem.searchController = self.searchController;
    self.searchController.searchBar.tintColor = UIColor.systemBlueColor;
}

-(void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame: self.view.bounds style: UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier: cellIdentifier];
    
    [self.view addSubview:self.tableView];
    
    /// Set `Constraints`
    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
    ]];
}

-(void)setupAddButton {
    UIBarButtonItem * add = [
        BarButton
        createWithTitle:[Strings addButtonTitle] style:UIBarButtonItemStylePlain
        target:self
        action:@selector(onAddButtonTap)
    ];
    UIBarButtonItem * edit = [
        BarButton
        createWithTitle:[Strings editButtonTitle] style:UIBarButtonItemStylePlain
        target:self
        action:@selector(onEditButtonTap)
    ];
    
    add.tintColor = UIColor.systemBlueColor;
    edit.tintColor = UIColor.systemBlueColor;
    self.navigationItem.rightBarButtonItems = @[add, edit];
}

- (void)onAddButtonTap {
    CreateContactViewController *createVC = [[CreateContactViewController alloc] init];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:createVC animated:YES];
    });
}

- (void)onEditButtonTap {
    NSLog(@"KLK");
}

// MARK: - UITableViewDataSource METHODS

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listToBeDisplayed.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    cell.textLabel.text = self.listToBeDisplayed[indexPath.row];
    return cell;
}

// MARK: - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = searchController.searchBar.text;
    if (searchText.length == 0) {
        self.listToBeDisplayed = self.originalContactList;
    } else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", searchText];
        self.listToBeDisplayed = [self.originalContactList filteredArrayUsingPredicate:predicate];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}


@end
