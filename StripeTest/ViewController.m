//
//  ViewController.m
//  StripeTest
//
//  Created by Leonard Li on 10/13/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import "ViewController.h"
#import "PaymentViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PaymentViewController * pvc = [PaymentViewController alloc];
    [self.navigationController presentViewController:pvc animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
