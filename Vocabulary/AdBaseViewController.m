//
//  AdBaseViewController.m
//  Vocabulary
//
//  Created by 缪和光 on 12-11-4.
//  Copyright (c) 2012年 缪和光. All rights reserved.
//

#import "AdBaseViewController.h"
#import "GADAdMobExtras.h"

@interface AdBaseViewController ()

- (NSString *)hexStringWithRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue;

@end

@implementation AdBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.banner = [[GADBannerView alloc]initWithAdSize:kGADAdSizeBanner];
    self.banner.adUnitID = @"75ec8a2a75764c0e";
    self.banner.rootViewController = self;
    self.banner.delegate = self;
    GADRequest *request = [GADRequest request];
    GADAdMobExtras *extras = [[GADAdMobExtras alloc] init] ;
    extras.additionalParameters =
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     [self hexStringWithRed:141 green:198 blue:65], @"color_bg",
     [self hexStringWithRed:141 green:198 blue:65], @"color_bg_top",
     [self hexStringWithRed:141 green:198 blue:65], @"color_border",
     [self hexStringWithRed:88 green:87 blue:92], @"color_link",
     [self hexStringWithRed:255 green:255 blue:255], @"color_text",
     [self hexStringWithRed:88 green:87 blue:92], @"color_url",
     nil];
    
    [request registerAdNetworkExtras:extras];
    //[self.banner loadRequest:request];
    NSLog(@"hex:%@",[self hexStringWithRed:244 green:233 blue:215]);
}

- (void)viewWillAppear:(BOOL)animated
{
    BOOL shouldAddToView = YES;
    for (UIView *view in self.view.subviews) {
        if (view == self.banner) {
            shouldAddToView = NO;
            break;
        }
    }
    if (shouldAddToView) {
        [self.view addSubview:self.banner];
        self.banner.frame = self.bannerFrame;
    }
    CGPoint bannerCenter = self.banner.center;
    bannerCenter.x = self.view.bounds.size.width/2;
    self.banner.center = bannerCenter;
}

- (void)viewDidDisappear:(BOOL)animated
{
    self.banner.delegate = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - mark GADBannerViewDelegate
- (void)adViewDidReceiveAd:(GADBannerView *)view
{
    NSLog(@"receive ad succeed");
    
}

- (void)adView:(GADBannerView *)view
didFailToReceiveAdWithError:(GADRequestError *)error
{
    NSLog(@"%@",error);
}

- (NSString *)hexStringWithRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue
{
    NSString *str = [[NSString stringWithFormat:@"%02x%02x%02x",red,green,blue] capitalizedString];
    return str;
}

@end