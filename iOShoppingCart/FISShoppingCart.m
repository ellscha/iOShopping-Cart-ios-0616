//
//  FISShoppingCart.m
//  iOShoppingCart
//
//  Created by Elli Scharlin on 6/9/16.
//  Copyright © 2016 FIS. All rights reserved.
//

#import "FISShoppingCart.h"

@implementation FISShoppingCart

-(NSUInteger)calculateTotalPriceInCents{
    NSUInteger priceInCents = 0;
    if (self.items.count == 0) {
        return priceInCents;
    }
    else {
         for (FISItem *item in self.items) {
             priceInCents += item.priceInCents;
         }
        
    }
    
    
    return priceInCents;
}

-(void)addItem :(FISItem *)item{
    [self.items addObject:item];
    
    
}

-(void)removeItem :(FISItem *)item{
    NSMutableArray *itemsCopy = [self.items mutableCopy];
    NSInteger indexOfItemToBeRemoved = [itemsCopy indexOfObject:item];
    [itemsCopy removeObjectAtIndex:indexOfItemToBeRemoved];
    self.items = itemsCopy;
}

-(void)removeAllItemsLikeItem : (FISItem *)item{
    [self.items removeObject:item];
}

-(void)sortItemsByNameAsc{
    NSSortDescriptor *sortByNameAsc = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES
                                       
                                                                     selector:@selector(caseInsensitiveCompare:)];

    NSArray *sortedItemsListByNameAsc = [self.items sortedArrayUsingDescriptors:@[sortByNameAsc]];
    self.items = sortedItemsListByNameAsc;
}

-(void)sortItemsByNameDesc{
    
    NSSortDescriptor *sortByNameDesc = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO
                                       
                                                                     selector:@selector(caseInsensitiveCompare:)];
    
    NSArray *sortedItemsListByNameDesc = [self.items sortedArrayUsingDescriptors:@[sortByNameDesc]];
    self.items = sortedItemsListByNameDesc;
}

-(void)sortItemsByPriceInCentsAsc{
    NSSortDescriptor *sortByPriceInCentsAsc = [NSSortDescriptor sortDescriptorWithKey:@"priceInCents" ascending:YES];
    NSArray *cartWithItemsByPriceInCentsAsc = [self.items sortedArrayUsingDescriptors:@[sortByPriceInCentsAsc]];
    self.items = cartWithItemsByPriceInCentsAsc;
    
}

-(void)sortItemsByPriceInCentsDesc{
    NSSortDescriptor *sortByPriceInCentsDesc = [NSSortDescriptor sortDescriptorWithKey:@"priceInCents" ascending:NO];
    NSArray *cartWithItemsByPriceDesc = [self.items sortedArrayUsingDescriptors:@[sortByPriceInCentsDesc]];
    self.items = cartWithItemsByPriceDesc;
}

-(NSArray *)allItemsWithName : (NSString *)name{
    NSMutableArray *itemsWithName = [NSMutableArray new];
    for (FISItem *itemType in self.items) {
        if ([itemType.name isEqualToString:name]) {
            [itemsWithName addObject:itemType];
        }
    }
    return itemsWithName;
}

-(NSArray *)allItemsWithMinimumPriceInCents : (NSUInteger)minimumPrice{
    NSPredicate *minimumPriceInCentsPredicate = [NSPredicate predicateWithFormat:@"priceInCents >= %lu", minimumPrice];
    NSArray *itemsWithMinimumPriceInCents = [self.items filteredArrayUsingPredicate:minimumPriceInCentsPredicate];
    
    return itemsWithMinimumPriceInCents;
}

-(NSArray *)allItemsWithMaximumPriceInCents : (NSUInteger)maximumPrice{
    NSPredicate *maximumPriceInCentsPredicate = [NSPredicate predicateWithFormat:@"priceInCents <= %lu", maximumPrice];
    NSArray *itemsWithMaximumPriceInCents = [self.items filteredArrayUsingPredicate:maximumPriceInCentsPredicate];
    return itemsWithMaximumPriceInCents;
}


@end
