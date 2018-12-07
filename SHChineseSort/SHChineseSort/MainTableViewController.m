//
//  MainTableViewController.m
//  SHChineseSort
//
//  Created by Daniel on 2018/12/7.
//  Copyright © 2018年 Daniel. All rights reserved.
//

#import "MainTableViewController.h"
#import "SHChineseSort.h"
#import "CityTableViewCell.h"

@interface City : NSObject
@property (nonatomic, copy) NSString *cityName;
@end

@implementation City
@end

@interface MainTableViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSArray *sectionTitleArray;

@property (nonatomic, strong) NSArray <NSArray *> *sortedObjArr;

@property (nonatomic, assign) BOOL isSort;

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.rowHeight = 50;
    self.tableView.tableFooterView = [UIView new];
    [self insertData];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"排序" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonMethod:)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)rightBarButtonMethod:(UIBarButtonItem *)item{
    if (!self.isSort) {
        [SHChineseSort sortAndGroup:self.dataArray key:@"cityName" finish:^(bool isSuccess, NSMutableArray *unGroupArr, NSMutableArray *sectionTitleArr, NSMutableArray<NSMutableArray *> *sortedObjArr) {
            if (isSuccess) {
                self.isSort = !self.isSort;
                self.sectionTitleArray = sectionTitleArr;
                self.sortedObjArr = sortedObjArr;
                [self.tableView reloadData];
            }
        }];
        [item setTitle:@"恢复"];
    }else{
        self.isSort = !self.isSort;
        [self.tableView reloadData];
        [item setTitle:@"排序"];
    }
    
}

- (void)insertData{
    NSString *county = @"q井陉 w元氏 e赞皇 r高邑 t临城 y内丘 u邢台 i永年 o涉县 p磁县 [临漳 a魏县 s大名 d邯郸 f成安 g肥乡 h广平 j馆陶 k曲周 l邱县 ;临西 z南和 x鸡泽 c威县 v任县 b巨鹿 n平乡 m广宗 <清河 #故城";
    NSArray * nameArr = [county componentsSeparatedByString:@" "];
    for (NSString *name in nameArr) {
        City *c = [City new];
        c.cityName = name;
        [self.dataArray addObject:c];
    }
    if (!self.isSort) {
        [self.tableView reloadData];
    }
    
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.isSort ? self.sectionTitleArray.count : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.isSort ? self.sortedObjArr[section].count : self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityTableViewCell" forIndexPath:indexPath];
    City *c;
    if (!self.isSort) {
        c = self.dataArray[indexPath.row];
    }else{
        c = self.sortedObjArr[indexPath.section][indexPath.row];
    }
    cell.cityLabel.text = c.cityName;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.isSort ? 10 : 0.01;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
