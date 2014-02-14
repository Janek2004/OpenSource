//
//  JSDataSource.h
//  
//
//  Created by Terry Lewis II on 6/14/13.
//
//

#import <Foundation/Foundation.h>

typedef void (^CellConfigureBlock)(id cell, id item, id indexPath);

@interface iTenDataSource : NSObject <UITableViewDataSource, UICollectionViewDataSource>
/**
 * A datasource class that can serve as both a UITableView and UICollectionView datasource.
 *\param items the array that will serve as the datasource.
 *\param identifier the cell identifier.
 *\param block the configuration block that is used to configure the cell, contains the cell, the item for the indexPath from the array and the indexPath.
 *\returns an instance of the class that will serve as a datasource for either a UITableView or UICollectionView.
*/
- (instancetype)initWithItems:(NSArray *)items cellIdentifier:(NSString *)identifier configureCellBlock:(CellConfigureBlock)block;
- (instancetype)itemForIndexPath:(NSIndexPath *)indexPath;

-(instancetype)objectAtIndexedSubscript:(NSUInteger)index;

@property(strong,nonatomic)NSString *keyPath;
@property(nonatomic, strong) NSArray *items;
@property(nonatomic,strong)  NSArray * headers;
@property(nonatomic,strong)  NSArray * cellIds;
@property (nonatomic,strong) NSDictionary * cellsForClasses;

@end
