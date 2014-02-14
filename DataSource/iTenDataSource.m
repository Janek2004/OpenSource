//
//  JSDataSource.m
//
//
//  Created by Terry Lewis II on 6/14/13.
//  
//

#import "iTenDataSource.h"


@interface iTenDataSource ()
@property(nonatomic, copy) NSString *cellIdentifier;
@property(nonatomic, copy) CellConfigureBlock configureCellBlock;
@end

@implementation iTenDataSource

- (instancetype)initWithItems:(NSArray *)items cellIdentifier:(NSString *)identifier configureCellBlock:(CellConfigureBlock)block {
    self = [super init];
    if(self) {
        _items = items;
        _cellIdentifier = identifier;
        _configureCellBlock = [block copy];
    }
    return self;

}

- (id)itemForIndexPath:(NSIndexPath *)indexPath {
    if([self.items[0] respondsToSelector:@selector(objectAtIndex:)])
        return self.items[(NSUInteger)indexPath.section][(NSUInteger)indexPath.row];
    else
        return self.items[(NSUInteger)indexPath.row];
}
#pragma mark - UITableView datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(self.cellIds){
        self.cellIdentifier = _cellIds[indexPath.section];
    }
   
    id item = [self itemForIndexPath:indexPath];
    
    if([item isMemberOfClass:[iTenEvent class]])
    {
        if([[(iTenEvent *)item hasHeader]boolValue]){
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Header" forIndexPath:indexPath];
           self.configureCellBlock(cell, item, indexPath);
            return cell;
        }
        else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
            self.configureCellBlock(cell, item, indexPath);
            return cell;
        }
        
    }
    else{
         UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
        self.configureCellBlock(cell, item, indexPath);
                return cell;
    }
}
  

  

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if([self.items[0] respondsToSelector:@selector(objectAtIndex:)])
        return self.items.count;
    else
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([self.items[0] respondsToSelector:@selector(objectAtIndex:)])
        return [self.items[section] count];
    else
        return self.items.count;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(self.headers.count >0)
    {
        return self.headers[section];
    }
    else if([self.items[0] respondsToSelector:@selector(objectAtIndex:)])
        return [self.items[section][0] valueForKeyPath:self.keyPath];
    else
        return nil;
}

#pragma mark - UICollectionView data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    id item = self.items[(NSUInteger)indexPath.row];
    self.configureCellBlock(cell, item, indexPath);
    return cell;
}

-(id)objectAtIndexedSubscript:(NSUInteger)index {
    return self.items[index];
}
@end
