//
//  DetailedRecipeViewController.m
//  Cooking by the Book
//
//  Created by Jack Smith on 8/10/16.
//  Copyright © 2016 EthanJack. All rights reserved.
//

#import "DetailedRecipeViewController.h"
#import "DataClass.h"
#import "Helper.h"

@interface DetailedRecipeViewController ()

@end

@implementation DetailedRecipeViewController

-(void)viewWillAppear:(BOOL)animated{
    DataClass *obj = [DataClass getInstance];
    //self.navigationItem.title = @"%@",obj.cookbookAry.;
    NSString *post = [NSString stringWithFormat:@"id=%@",obj.currDetailedRecipeId];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSMutableURLRequest *request = [Helper setupPost:postData withURLEnd:@"getRecipe"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *postData, NSURLResponse *response, NSError *error) {
        NSString *ret_ = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        NSLog(@"ret = %@",ret_);

    
        }];
    [dataTask resume];
    NSLog(@"Detailed Recipe ID = %@",obj.currDetailedRecipeId);
    

}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
