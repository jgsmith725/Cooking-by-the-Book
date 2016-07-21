//
//  DataClass.m
//  Cooking by the Book
//
//  Created by Jack Smith on 6/26/16.
//  Copyright © 2016 EthanJack. All rights reserved.
//

#import "DataClass.h"
#import "CookbookRecipe.h"

@implementation DataClass
//@synthesize userId;

static DataClass *instance = nil;

+(DataClass *)getInstance{
    @synchronized (self) {
        if (instance == nil)
        {
            instance = [DataClass new];
        }
    }
    return instance;
}

-(void)initCookbookAry:(NSArray *)jsonCookbookAry_{
    NSMutableArray *cookbookAry_ = [[NSMutableArray alloc]init];
    self.cookbookAry = cookbookAry_;
    
    for (int i=0;i<jsonCookbookAry_.count;i++){
        NSDictionary *recipeDict = [jsonCookbookAry_ objectAtIndex:i];
        NSArray *tagAry = [recipeDict objectForKey:@"tagInfo"];
        NSMutableArray *tagNumAry = [[NSMutableArray alloc]init];
        NSLog(@"tagAry count = %lu",(unsigned long)tagAry.count);
        
        for (int ii=0;ii<tagAry.count;ii++){
            NSDictionary *tagDict = [tagAry objectAtIndex:ii];
            [tagNumAry addObject:[tagDict objectForKey:@"tagID"]];
            NSLog(@"tagID = %@",[tagDict objectForKey:@"tagID"]);
            NSLog(@"tagAry count inside ii loop = %lu",(unsigned long)tagAry.count);
        }
        
        CookbookRecipe *tempRecipe = [[CookbookRecipe alloc] initBasicWithTitle:[recipeDict objectForKey:@"recipeTitle"]
                                                                         withID:[recipeDict objectForKey:@"recipeID"]
                                                                       withDesc:[recipeDict objectForKey:@"recipeDescription"]
                                                                      withImage:[recipeDict objectForKey:@"recipeImage"]
                                                                     withTagAry:tagNumAry];
        NSLog(@"temp recipe properties = %@ %@ %@ %@",tempRecipe.title, tempRecipe.recipeID, tempRecipe.desc, tempRecipe.tagAry);
        [self.cookbookAry addObject:tempRecipe];
        NSLog(@"Cookbook ary count after initialization = %lu",(unsigned long)self.cookbookAry.count);
    }
    
    self.cookbookAry = [self alphebetizeAry:self.cookbookAry withKey:@"title"];
}

-(NSMutableArray *)alphebetizeAry:(NSMutableArray *)theArray withKey:(NSString *)key{
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:key ascending:YES selector:@selector(caseInsensitiveCompare:)];
    [theArray sortUsingDescriptors:@[sort]];
    return theArray;
}

@end
