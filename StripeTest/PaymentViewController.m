//
//  PaymentViewController.m
//  StripeTest
//
//  Created by Leonard Li on 10/13/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import "PaymentViewController.h"
#import "PTKView.h"
#import <STPCard.h>

@interface PaymentViewController () <PTKViewDelegate>

@property(weak, nonatomic) PTKView * paymentView;

@property(weak, nonatomic) UIButton * saveButton;

@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * newButton = [[UIButton alloc] initWithFrame:CGRectMake(50,50,290,55)];
    [newButton setTitle:@"save" forState:UIControlStateNormal];
    [newButton addTarget:self action:@selector(saveButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [newButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.saveButton = newButton;
    [self.view addSubview:self.saveButton];
    PTKView *view = [[PTKView alloc] initWithFrame:CGRectMake(15,20,290,55)];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.paymentView = view;
    self.paymentView.delegate = self;
    [self.view addSubview:self.paymentView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)paymentView:(PTKView *)view withCard:(PTKCard *)card isValid:(BOOL)valid
{
    // Toggle navigation, for example
    NSLog(@"%@",[NSString stringWithFormat:@"%d",valid]);
}

- (void)saveButtonOnClick:(id)sender{
    STPCard *card = [[STPCard alloc] init];
    card.number = self.paymentView.card.number;
    card.expMonth = self.paymentView.card.expMonth;
    card.expYear = self.paymentView.card.expYear;
    card.cvc = self.paymentView.card.cvc;
    [Stripe createTokenWithCard:card completion:^(STPToken *token, NSError *error) {
        if (error) {
            NSLog(@"ERROR");
        } else {
        [self createBackendChargeWithToken:token];
        }
    }];
}

- (void)createBackendChargeWithToken:(STPToken *)token{
    NSLog(@"%@",token.tokenId);
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
