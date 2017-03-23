//
//  ItemSelectedViewController.m
//  exo_actu_ios
//
//  Created by GUIOT Kevin on 23/03/2017.
//  Copyright © 2017 GUIOT Kevin. All rights reserved.
//

#import "ItemSelectedViewController.h"

@implementation ItemSelectedViewController

@synthesize title = _title;
@synthesize date = _date;
@synthesize image = _image;
@synthesize description = _description;
@synthesize link = _link;

/*
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)moreButton:(UIButton *)sender {
    
    // On ouvre le lien sur Safari
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_link]];
}

- (IBAction)moreBarButton:(UIBarButtonItem *)sender {
    
    // On prépare les options de partage
    UIImage *image = _image.image;

    NSArray *activityItems = @[image];
    UIActivityViewController *activityViewControntroller = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityViewControntroller.excludedActivityTypes = @[];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        activityViewControntroller.popoverPresentationController.sourceView = self.view;
        activityViewControntroller.popoverPresentationController.sourceRect = CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/4, 0, 0);
    }
    [self presentViewController:activityViewControntroller animated:true completion:nil];
}
@end
