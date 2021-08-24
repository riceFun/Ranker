//
//  FYViewController.m
//  Ranker
//
//  Created by riceFun on 2020/11/11.
//

#import "FYViewController.h"
#import "FYDataCenter.h"

@interface FYViewController ()

@end

@implementation FYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新冠";
    
//        [FYCountryCode handle];
        
  [[FYDataCenter sharedInstance] queryCountries];

//        [[FYDataCenter sharedInstance] queryCountriesDayOne];
}


@end
