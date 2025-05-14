//
//  ContactListController.m
//  DemoApp
//
//  Created by Oscar Martínez Germán on 13/5/25.
//

#import "DemoApp-Swift.h" /// Import the Swift header to expose `Swift files`.
#import "ContactListController.h"

@interface ContactListController () <UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, ContactDelegate>
    /// `UI` Elements
    @property (nonatomic, strong) UITableView *tableView;
    @property (nonatomic, strong) UISearchController *searchController;
    
    /// `Properties`
    @property (nonatomic, assign) BOOL isFiltering;
    @property (nonatomic, strong) NSMutableArray<ContactObjC *> *listToBeDisplayed;
    @property (nonatomic, strong) NSMutableArray<ContactObjC *> *originalContactList;
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
    _originalContactList = [[ContactObjC defaultValues] mutableCopy];
    _listToBeDisplayed = _originalContactList;
}

// MARK: - UI SETUP METHODS

- (void)setupUI {
    self.view.backgroundColor = UIColor.systemFillColor;
    self.navigationItem.hidesSearchBarWhenScrolling = FALSE;
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
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.obscuresBackgroundDuringPresentation = FALSE;
    _searchController.searchBar.placeholder = [Strings searchBarPlaceholder];
    self.definesPresentationContext = TRUE;
    self.navigationItem.searchController = self.searchController;
    _searchController.searchBar.tintColor = UIColor.systemBlueColor;
}

-(void)setupTableView {
    _tableView = [[UITableView alloc] initWithFrame: self.view.bounds style: UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.translatesAutoresizingMaskIntoConstraints = FALSE;
    [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier: cellIdentifier];
    
    [self.view addSubview:self.tableView];
    
    /// Set `Constraints`
    [NSLayoutConstraint activateConstraints:@[
        [_tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [_tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        [_tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [_tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
    ]];
}

-(void)setupAddButton {
    UIBarButtonItem * add = [
        BarButton
        createWithTitle:[Strings addButtonTitle] style:UIBarButtonItemStylePlain
        target:self
        action:@selector(onAddButtonTap)
    ];
    add.tintColor = UIColor.systemBlueColor;
    self.editButtonItem.tintColor = UIColor.systemBlueColor;
    self.navigationItem.rightBarButtonItems = @[add, self.editButtonItem];
}

- (void)onAddButtonTap {
    id<ContactDelegate> delegate = self;
    CreateContactViewController *createVC = [[CreateContactViewController alloc] initWithContactDelegate:delegate];    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:createVC animated:TRUE];
    });
}

// MARK: - UITableViewDataSource METHODS

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listToBeDisplayed.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    ContactObjC *contact = _listToBeDisplayed[indexPath.row];
    cell.textLabel.text = contact.name;
    cell.detailTextLabel.text = contact.phone;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return TRUE;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [_tableView setEditing:editing animated:animated];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ContactObjC *contactToBeRemoved = _listToBeDisplayed[indexPath.row];
        [_listToBeDisplayed removeObjectAtIndex:indexPath.row];
        [_originalContactList removeObject:contactToBeRemoved];

        /// Update the table view
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

        /// Reapply search filtering (if necessary)
        if (self.searchController.searchBar.text.length > 0) {
            [self updateSearchResultsForSearchController:self.searchController];
        }
    }
}

// MARK: - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = searchController.searchBar.text;
    if (searchText.length == 0) {
        _listToBeDisplayed = _originalContactList;
    } else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", searchText];
        _listToBeDisplayed = [[_originalContactList filteredArrayUsingPredicate:predicate] mutableCopy];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)didSaveWithContact:(ContactObjC * _Nonnull)contact {
    if (!_originalContactList) {
        _originalContactList = [NSMutableArray array];
    }

    [_originalContactList addObject:contact];
    _listToBeDisplayed = _originalContactList;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

@end
