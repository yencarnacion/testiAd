/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

//
//  MainViewController.h
//  testiad
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright ___ORGANIZATIONNAME___ ___YEAR___. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Uncomment to override the CDVCommandDelegateImpl used
        // _commandDelegate = [[MainCommandDelegate alloc] initWithViewController:self];
        // Uncomment to override the CDVCommandQueue used
        // _commandQueue = [[MainCommandQueue alloc] initWithViewController:self];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Uncomment to override the CDVCommandDelegateImpl used
        // _commandDelegate = [[MainCommandDelegate alloc] initWithViewController:self];
        // Uncomment to override the CDVCommandQueue used
        // _commandQueue = [[MainCommandQueue alloc] initWithViewController:self];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

#pragma mark View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    // View defaults to full size.  If you want to customize the view's size, or its subviews (e.g. webView),
    // you can do so here.

    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

/* Comment out the block below to over-ride */

/*
- (CDVCordovaView*) newCordovaViewWithFrame:(CGRect)bounds
{
    return[super newCordovaViewWithFrame:bounds];
}
*/

#pragma mark UIWebDelegate implementation

//- (void)webViewDidFinishLoad:(UIWebView*)theWebView
//{
//    // Black base color for background matches the native apps
//    theWebView.backgroundColor = [UIColor blackColor];
//
//    return [super webViewDidFinishLoad:theWebView];
//}

- (void)webViewDidFinishLoad:(UIWebView*)theWebView
{
    // Black base color for background matches the native apps
    theWebView.backgroundColor = [UIColor blackColor];
    
    adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    adView.delegate = self;
    
    CGRect adFrame = adView.frame;
    if([UIApplication sharedApplication].statusBarOrientation
       == UIInterfaceOrientationPortrait
       || [UIApplication sharedApplication].statusBarOrientation
       == UIInterfaceOrientationPortraitUpsideDown) {
        adView.currentContentSizeIdentifier =
        ADBannerContentSizeIdentifierPortrait;
        
        CGRect viewBounds;
        
        if([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait){
            viewBounds = CGRectMake([[UIScreen mainScreen] applicationFrame].origin.x, [[UIScreen mainScreen] applicationFrame].origin.y, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height-adView.frame.size.height);
            NSLog(@"orientation starts as Portrait rect: %@", NSStringFromCGRect(viewBounds));
        } else {
            viewBounds = CGRectMake([[UIScreen mainScreen] applicationFrame].origin.x, adView.frame.size.height, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height-adView.frame.size.height);
            NSLog(@"orientation starts as Portrait upside down rect: %@", NSStringFromCGRect(viewBounds));
        }
        
        self.view.frame = viewBounds;
        
        adFrame.origin.y = [[UIScreen mainScreen] applicationFrame].size.height-adView.frame.size.height;
    } else {
        adView.currentContentSizeIdentifier =
        ADBannerContentSizeIdentifierLandscape;
        
        CGRect viewBounds;
        
        
        if([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft){
            viewBounds = CGRectMake([[UIScreen mainScreen] applicationFrame].origin.x, [[UIScreen mainScreen] applicationFrame].origin.y, [[UIScreen mainScreen] applicationFrame].size.width-adView.frame.size.height, [[UIScreen mainScreen] applicationFrame].size.height);
        } else {
            viewBounds = CGRectMake(adView.frame.size.height, [[UIScreen mainScreen] applicationFrame].origin.y, [[UIScreen mainScreen] applicationFrame].size.width-adView.frame.size.height , [[UIScreen mainScreen] applicationFrame].size.height);
            
        }
        self.view.frame = viewBounds;
        
        adFrame.size.width = adView.frame.size.width;
        adFrame.origin.y = [[UIScreen mainScreen] applicationFrame].size.width-adView.frame.size.height;
    }
    adView.frame = adFrame;
    [self.view addSubview:adView];
    [self.view bringSubviewToFront:adView];
    
    return [super webViewDidFinishLoad:theWebView];
    // Create a view of the standard size at the top of the screen.
    
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)newInterfaceOrientation duration:(NSTimeInterval)duration {
    CGRect mainFrame = [[UIScreen mainScreen] applicationFrame];
    [self.view setFrame:mainFrame];
    if (newInterfaceOrientation != UIInterfaceOrientationLandscapeLeft && newInterfaceOrientation != UIInterfaceOrientationLandscapeRight) {
        adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
        
        CGRect viewBounds;
        
        if(newInterfaceOrientation == UIInterfaceOrientationPortrait){
            viewBounds = CGRectMake([[UIScreen mainScreen] applicationFrame].origin.x, [[UIScreen mainScreen] applicationFrame].origin.y, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height-adView.frame.size.height);
        } else {
            viewBounds = CGRectMake([[UIScreen mainScreen] applicationFrame].origin.x, adView.frame.size.height, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height-adView.frame.size.height);
        }
        
        NSLog(@"orientation to Portrait rect: %@", NSStringFromCGRect(viewBounds));
        
        self.view.frame = viewBounds;
        
        CGRect adViewBounds = CGRectMake(0.0, [[UIScreen mainScreen] applicationFrame].size.height - adView.frame.size.height, adView.frame.size.width, adView.frame.size.height);
        
        NSLog(@"Portrait adView rect: %@", NSStringFromCGRect(adViewBounds));
        
        adView.frame = adViewBounds;
    }
    else {
        adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
        
        CGRect viewBounds;
        if(newInterfaceOrientation == UIInterfaceOrientationLandscapeLeft){
            viewBounds = CGRectMake([[UIScreen mainScreen] applicationFrame].origin.x, [[UIScreen mainScreen] applicationFrame].origin.y, [[UIScreen mainScreen] applicationFrame].size.width-adView.frame.size.height, [[UIScreen mainScreen] applicationFrame].size.height);
        } else {
            viewBounds = CGRectMake(adView.frame.size.height, [[UIScreen mainScreen] applicationFrame].origin.y, [[UIScreen mainScreen] applicationFrame].size.width-adView.frame.size.height , [[UIScreen mainScreen] applicationFrame].size.height);
        }
        NSLog(@"orientation to Landscape rect: %@", NSStringFromCGRect(viewBounds));
        
        self.view.frame = viewBounds;
        
        
        CGRect adViewBounds = CGRectMake(0.0, [[UIScreen mainScreen] applicationFrame].size.width - adView.frame.size.height, adView.frame.size.width, adView.frame.size.height);
        
        NSLog(@"Landscape adView rect: %@", NSStringFromCGRect(adViewBounds));
        
        
        adView.frame = adViewBounds;
    }
    [self.view bringSubviewToFront:adView];
}

-(BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    // this indicates that the banner has been clicked.. confirm?
    NSLog(@"banner clicked: will %s application\n",willLeave?"leave":"cover");
    
    return YES;
}


/* Comment out the block below to over-ride */

/*

- (void) webViewDidStartLoad:(UIWebView*)theWebView
{
    return [super webViewDidStartLoad:theWebView];
}

- (void) webView:(UIWebView*)theWebView didFailLoadWithError:(NSError*)error
{
    return [super webView:theWebView didFailLoadWithError:error];
}

- (BOOL) webView:(UIWebView*)theWebView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    return [super webView:theWebView shouldStartLoadWithRequest:request navigationType:navigationType];
}
*/

@end

@implementation MainCommandDelegate

/* To override the methods, uncomment the line in the init function(s)
   in MainViewController.m
 */

#pragma mark CDVCommandDelegate implementation

- (id)getCommandInstance:(NSString*)className
{
    return [super getCommandInstance:className];
}

/*
   NOTE: this will only inspect execute calls coming explicitly from native plugins,
   not the commandQueue (from JavaScript). To see execute calls from JavaScript, see
   MainCommandQueue below
*/
- (BOOL)execute:(CDVInvokedUrlCommand*)command
{
    return [super execute:command];
}

- (NSString*)pathForResource:(NSString*)resourcepath;
{
    return [super pathForResource:resourcepath];
}

@end

@implementation MainCommandQueue

/* To override, uncomment the line in the init function(s)
   in MainViewController.m
 */
- (BOOL)execute:(CDVInvokedUrlCommand*)command
{
    return [super execute:command];
}

@end
